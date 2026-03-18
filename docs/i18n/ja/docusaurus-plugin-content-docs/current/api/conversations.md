---
sidebar_position: 9
---

# 会話とアンケート

## 会話（Conversations）

`client.conversations` API はダイレクトメッセージの会話を扱います。会話は `visibility: direct` の投稿で構成されるスレッドです。

### 会話の取得

```dart
final page = await client.conversations.fetch(limit: 20);

for (final conversation in page.items) {
  print(conversation.id);
  print(conversation.unread);
  print(conversation.accounts.map((a) => a.acct).join(', '));
  if (conversation.lastStatus != null) {
    print(conversation.lastStatus!.content);
  }
}
```

`MastodonPage<MastodonConversation>` を返します。`nextMaxId` と `prevMinId` でページネーションできます：

```dart
MastodonPage<MastodonConversation>? page = await client.conversations.fetch();

while (page != null && page.nextMaxId != null) {
  page = await client.conversations.fetch(maxId: page.nextMaxId);
  for (final conversation in page.items) {
    print(conversation.id);
  }
}
```

ページネーションパラメータ：

| パラメータ | 説明 |
|-----------|------|
| `limit`   | 最大取得件数（デフォルト: 20、上限: 40） |
| `maxId`   | 指定 ID より古い会話を返す |
| `sinceId` | 指定 ID より新しい会話を返す |
| `minId`   | 指定 ID の直後から前方向にページネーション |

### 会話を既読にする

```dart
final conversation = await client.conversations.markAsRead('7');
print(conversation.unread); // false
```

更新された `MastodonConversation` を返します。

### 会話の削除

```dart
await client.conversations.delete('7');
```

### MastodonConversation モデル

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `id` | `String` | 会話の内部 ID |
| `unread` | `bool` | 未読メッセージがあるか |
| `accounts` | `List<MastodonAccount>` | 会話の参加者（認証ユーザーを除く） |
| `lastStatus` | `MastodonStatus?` | 会話の最新投稿。存在しない場合は `null` |

---

## アンケート（Polls）

`client.polls` API はアンケートの取得と投票を提供します。アンケートは通常、投稿に添付されています。アンケート ID は `status.poll.id` から取得できます。

### アンケートの取得

```dart
final poll = await client.polls.fetch('34');
print(poll.votesCount);
print(poll.expired);

for (final option in poll.options) {
  print('${option.title}: ${option.votesCount ?? "非公開"}');
}
```

### アンケートへの投票

ゼロ始まりの選択肢インデックスのリストを渡します。単一選択のアンケートにはインデックスをひとつだけ指定します。

```dart
// 単一選択
final poll = await client.polls.vote('34', [0]);

// 複数選択（poll.multiple == true の場合のみ有効）
final poll = await client.polls.vote('34', [0, 2]);

print(poll.voted);    // true
print(poll.ownVotes); // 例: [0, 2]
```

認証ユーザーがすでに投票済みの場合は `MastodonAlreadyVotedException` がスローされます。

### MastodonPoll モデル

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `id` | `String` | アンケートの内部 ID |
| `expiresAt` | `DateTime?` | 終了日時 |
| `expired` | `bool` | アンケートが終了しているか |
| `multiple` | `bool` | 複数選択が許可されているか |
| `votesCount` | `int` | 総投票数 |
| `votersCount` | `int?` | ユニーク投票者数（複数選択アンケートでは `votesCount` と異なる場合がある） |
| `options` | `List<MastodonPollOption>` | 選択肢のリスト |
| `emojis` | `List<MastodonCustomEmoji>` | 選択肢テキストで使用されているカスタム絵文字 |
| `voted` | `bool?` | 認証ユーザーが投票済みかどうか |
| `ownVotes` | `List<int>?` | 認証ユーザーが投票した選択肢のインデックス |

`MastodonPollOption` フィールド：

| フィールド | 型 | 説明 |
|-----------|-----|------|
| `title` | `String` | 選択肢のテキスト |
| `votesCount` | `int?` | この選択肢への投票数。非公開アンケートでは `null` |
