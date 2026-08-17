---
sidebar_position: 15
---

# ストリーミング

`client.streaming` API は Mastodon の Streaming API（WebSocket）を通じてリアルタイム更新を配信します。単一の接続にすべての購読を多重化するため、複数のチャンネルを購読しても接続が複数開かれることはありません。

`client.streaming` にアクセスしただけでは接続は開きません。ソケットが開くのは `connect()` を呼んだときだけなので、REST しか使わないアプリケーションがこの API 経由で通信を発生させることはありません。

## 接続

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
);

await client.streaming.connect();
```

接続先は自動的に解決されます。まず `GET /api/v2/instance` の `configuration.urls.streaming` を読み、無ければ `GET /api/v1/instance` の `urls.streaming_api` にフォールバックし、それも無ければ REST のホストを流用します。解決した値は正規化されます。`http` は `ws` に、`https` は `wss` に変換され、ポートは保持され、`/api/v1/streaming` が無ければ付与されます。

パブリックなチャンネルを含め、ストリーミングには例外なくアクセストークンが必要です。無認証アクセスは Mastodon v4.2.0 で廃止されました。

## 購読

```dart
final home = await client.streaming.subscribe(const MastodonStream.user());

home.events.listen((event) {
  switch (event) {
    case MastodonUpdateEvent(:final status):
      print(status.content);
    case MastodonStatusUpdateEvent(:final status):
      print('編集: ${status.id}');
    case MastodonDeleteEvent(:final statusId):
      print('削除: $statusId');
    case MastodonNotificationEvent(:final notification):
      print(notification.type);
    case MastodonUnknownStreamEvent(:final event):
      print('未知のイベント: $event');
    default:
      break;
  }
});

await home.cancel();
```

購読ハンドルは 3 層を提供します。

| プロパティ | 型 | 内容 |
|---|---|---|
| `events` | `Stream<MastodonStreamEvent>` | 型付きの sealed イベント |
| `statuses` | `Stream<MastodonStatus>` | `update` と `status.update` の投稿 |
| `messages` | `Stream<MastodonStreamingMessage>` | payload 未デコードの生エンベロープ |

## チャンネル

チャンネルは sealed な `MastodonStream` 型で表現します。

| ファクトリ | ワイヤ上の名前 |
|---|---|
| `MastodonStream.user()` | `user` |
| `MastodonStream.userNotification()` | `user:notification` |
| `MastodonStream.public()` | `public` |
| `MastodonStream.public(local: true)` | `public:local` |
| `MastodonStream.public(remote: true)` | `public:remote` |
| `MastodonStream.public(onlyMedia: true)` | `public:media` |
| `MastodonStream.public(local: true, onlyMedia: true)` | `public:local:media` |
| `MastodonStream.public(remote: true, onlyMedia: true)` | `public:remote:media` |
| `MastodonStream.hashtag('dart')` | `hashtag` |
| `MastodonStream.hashtag('dart', local: true)` | `hashtag:local` |
| `MastodonStream.list('42')` | `list` |
| `MastodonStream.direct()` | `direct` |

`local` と `remote` を同時に true にすることはできません。サーバー側に該当するチャンネルが存在しないため、この組み合わせは `assert` で弾かれます。

Mastodon のフォークが追加したチャンネルなど、本ライブラリが型として持たないチャンネルには `subscribeRaw` を使います。

```dart
final raw = await client.streaming.subscribeRaw('someCustomStream');
raw.messages.listen((message) => print(message.payload));
```

## 参照カウント

Mastodon は既に購読済みのチャンネルに対する 2 回目の `subscribe` をサイレントに無視するため、クライアント側で参照カウントを保持しています。カウントが 0 から 1 になったときに `subscribe` を送り、0 に戻ったときに `unsubscribe` を送ります。

このときハッシュタグのキーは小文字に正規化されます。正規化しないまま `Dart` と `dart` を購読すると、サーバー側で衝突して 2 つ目の購読者にイベントが届かなくなります。

```dart
final a = await client.streaming.subscribe(const MastodonStream.hashtag('Dart'));
final b = await client.streaming.subscribe(const MastodonStream.hashtag('dart'));

await a.cancel(); // b がまだ有効なので unsubscribe は送られない
await b.cancel(); // ここで unsubscribe が送られる
```

## エラー

購読が成功しても ack は返らず、サーバーのエラーにはチャンネル名も相関 ID も含まれません。そのため購読フレームは逐次送信され、直後の待機時間内に届いたエラーは直近のリクエストに紐づけられます。

```dart
try {
  await client.streaming.subscribe(const MastodonStream.list('999'));
} on MastodonStreamingSubscriptionException catch (e) {
  print('${e.message} (${e.status})');
}
```

`MastodonStreamingSubscriptionException.status` が nullable なのは、`unsubscribe` のエラーにサーバーが `status` を付けないためです。

接続レベルの失敗は `MastodonStreamingConnectionException`、予期しない切断は `MastodonStreamingClosedException` として表現されます。catch する代わりに観測したい場合のために、いずれも `client.streaming.errors` にも流れます。

## 再接続とライフサイクル

再接続は指数バックオフとジッタで自動的に行われ、上限は `MastodonStreamingConfig.reconnectMaxDelay` でキャップされます。購読の状態は接続に紐づくため、代わりの接続が使えるようになった時点ですべての購読が再送されます。

close code によって扱いが異なります。

| close code | 挙動 |
|---|---|
| `1000` | 正常終了。再接続しない。 |
| `1003` | サーバーがバイナリフレームを拒否した。再試行せずエラーとして報告する。 |
| `1005` | クローズフレーム無し。トークン失効の可能性があるため、無条件には再試行しない。 |
| その他 | バックオフを挟んで再接続する。 |

ハンドシェイク時の HTTP 401 はリトライループに入らず即座に送出されます。無効なトークンで再試行しても成功しないためです。

アプリのバックグラウンド遷移には `suspend()` と `resume()` を使い、後片付けには `dispose()` を使ってください。

```dart
await client.streaming.suspend();
await client.streaming.resume();

await client.dispose();
```

`MastodonClient.dispose()` はストリーミング接続と HTTP トランスポートを閉じます。ストリーミングを一度も使っていない場合、そのために新しくクライアントを生成することはありません。

## 設定

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
  streamingConfig: MastodonStreamingConfig(
    authMode: MastodonStreamingAuthMode.subprotocol,
    pingInterval: Duration(seconds: 30),
    reconnectMaxDelay: Duration(seconds: 30),
    reconnectJitter: 0.2,
  ),
);
```

認証方式は 3 種類あります。既定の `subprotocol` はトークンを唯一の WebSocket サブプロトコルとして送る方式で、Web を含む全プラットフォームで動作し、アクセスログにトークンが残りません。`header` は `dart:io` を必要とし、`queryParameter` は URL にトークンが露出するレガシーな方式です。`enableAuthFallback` を有効にしたままにしておくと、失敗時に残りの方式が順に試され、成功した方式が以降の再接続で優先されます。ログ出力からは常にトークンがマスクされます。

## 注意点

以下は Mastodon の streaming サーバー自体の挙動で、しばしばクライアントのバグに見えるものです。

- `read:statuses` のみのトークンで `user` に繋ぐと、ホームタイムラインは流れますが通知は一切届きません。エラーも出ません。通知には `read` または `read:notifications` が必要です。
- `only_media` は WebSocket では無視されます。メディアのみに絞るにはチャンネル名で指定する必要があります。
- `user` と `user:notification` を同時に購読すると、サーバーが両者を別のチャンネル集合として扱うため、同じ通知が 2 回届きます。`user` だけで十分です。
- パブリックおよびハッシュタグのチャンネルにおける `update` と `status.update` は、言語設定・フィード公開設定（Mastodon v4.5 以降）・ブロック・ミュート・ドメインブロックによってサイレントに破棄されることがあります。パブリックのストリームが静かなままでも、必ずしも壊れているわけではありません。
- `filters_changed` はイベント型として定義されていますが、Mastodon v4.3 以降ではクライアントに配送されません。payload の無いメッセージをサーバーが破棄するためです。
- ソケットが切断されている間に発生したイベントは、再接続後も再配送されません。REST の `since_id` や `min_id` で穴埋めしてください。

## ヘルスチェック

streaming プロセスは独自のヘルスチェックエンドポイントを持ち、JSON ではなくプレーンテキストを返します。

```dart
final healthy = await client.health.checkStreaming();
```
