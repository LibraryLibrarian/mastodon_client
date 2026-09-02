---
sidebar_position: 10
---

# インスタンス・サーバー

サーバーのメタデータ、カスタム絵文字、お知らせ、ヘルスチェック、ユーザー設定、プロフィールディレクトリ、oEmbed、タイムラインマーカーを扱う API を説明します。

## インスタンス情報

### 現在のインスタンス（v2）

```dart
final instance = await client.instance.fetch();
print(instance.title);
print(instance.description);
print(instance.version);
```

設定言語・ルール・連絡先情報を含む v2 メタデータを持つ `MastodonInstance` を返します。

### バージョン依存機能の判定

新しい Mastodon リリースで追加された機能を表示する前に
`detectCapabilities()` で対応状況を判定できます。

```dart
final capabilities = await client.instance.detectCapabilities();

switch (capabilities.supportFor(MastodonCapability.collections)) {
  case MastodonCapabilitySupport.supported:
    // Collections 機能を表示する
  case MastodonCapabilitySupport.unsupported:
    // Collections 機能を非表示または無効にする
  case MastodonCapabilitySupport.unknown:
    // 保守的な代替動作にするか、利用者が実行できるようにする
}
```

| Capability | サーバー機能 | 必要 Mastodon | API サーフェス水準 |
|---|---|---:|---:|
| `tagFeaturing` | タグの feature / unfeature | 4.4.0 | 6 |
| `annualReportDetails` | 年指定の Annual Report 取得 | 4.4.0 | 6 |
| `oauthUserInfo` | OpenID Connect user info | 4.4.0 | 6 |
| `asyncRefreshes` | 実験的な非同期更新状態 | 4.4.0 | 6 |
| `quotePosts` | 引用投稿関連の操作 | 4.5.0 | 7 |
| `collections` | Collections endpoint | 4.6.0 | 10 |
| `donationCampaigns` | Donation campaign endpoint | 4.6.0 | 10 |
| `editableProfile` | 編集可能プロフィールの取得・更新 | 4.6.0 | 10 |
| `annualReportGeneration` | Annual Report の生成・状態取得 | 4.6.0 | 10 |

判定手順は次のとおりです。

1. `GET /api/v2/instance` を取得し、`api_versions.mastodon` を優先します。
2. このフィールドが無い場合、`MastodonInstance.version` の先頭にある
   `major.minor.patch` をベストエフォートで利用します。
3. v2 endpoint 自体が 404 の場合はレガシーの `GET /api/v1/instance` を取得し、
   そのバージョン文字列を使います。404 以外のエラーではフォールバックせず、
   そのまま例外を送出します。
4. 利用できるメタデータを解釈できなければ `unknown` を返します。

API 呼び出しごとに instance 情報を取得せず、結果はサーバーごと・アプリプロセスの
生存期間中に一度キャッシュしてください。

`api_versions.mastodon` はリリース番号ではなく API サーフェスの水準です。パッチ
リリースやルートを追加しない変更でも増加し、複数リリースで同じ値になったり、整数が
飛んだりします。表にある下限判定だけに使い、Mastodon リリースへ逆変換しないでください。

判定結果は参考情報です。フォークや互換実装は宣言したメタデータと一致しない場合が
あるため、実際の API 呼び出しのエラーも必ず処理してください。特に 404 応答だけでは、
endpoint が無い場合とリソースが無い場合を確実に区別できません。

### ピアドメイン一覧

```dart
final peers = await client.instance.fetchPeers();
// 連合済みドメインの List<String>
```

### 週次アクティビティ

```dart
final activity = await client.instance.fetchActivity();
for (final week in activity) {
  print('投稿数: ${week.statuses}');
}
```

最大 12 週分の `MastodonWeeklyActivity` オブジェクトを返します。

### インスタンスルール

```dart
final rules = await client.instance.fetchRules();
for (final rule in rules) {
  print(rule.text);
}
```

### ドメインブロック

```dart
final blocked = await client.instance.fetchDomainBlocks();
```

インスタンスがブロックしているドメインの一覧を返します。これはサーバーレベルのリストです。ユーザーレベルのドメインブロックについては[モデレーション](./moderation.md)のページを参照してください。

### 詳細説明

```dart
final description = await client.instance.fetchExtendedDescription();
print(description.content);
```

### プライバシーポリシーと利用規約

```dart
final policy = await client.instance.fetchPrivacyPolicy();
final tos = await client.instance.fetchTermsOfService();

// 日付を指定して過去バージョンの利用規約を取得
final old = await client.instance.fetchTermsOfServiceByDate('2024-01-01');
```

### 翻訳対応言語

```dart
final languages = await client.instance.fetchTranslationLanguages();
// Map<String, List<String>> — ソース言語 → 対応ターゲット言語
languages.forEach((source, targets) {
  print('$source → $targets');
});
```

### レガシー v1（非推奨）

```dart
// ignore: deprecated_member_use
final instanceV1 = await client.instance.fetchV1();
```

`fetchV1()` は Mastodon 4.0.0 以降で非推奨です。古いサーバーとの互換性が必要な場合を除き、`fetch()` を使用してください。

---

## カスタム絵文字

```dart
final emojis = await client.customEmojis.fetch();
for (final emoji in emojis) {
  print(':${emoji.shortcode}: → ${emoji.url}');
}
```

認証不要です。サーバーで利用可能なすべてのカスタム絵文字を `List<MastodonCustomEmoji>` で返します。

---

## お知らせ

### お知らせの一覧取得

```dart
final announcements = await client.announcements.fetch();
for (final a in announcements) {
  print(a.text);
}
```

### お知らせを既読にする

```dart
await client.announcements.dismiss('announcement-id');
```

認証ユーザーに対して、指定したお知らせを既読としてマークします。

### リアクション

```dart
// リアクションを追加（Unicode 絵文字またはカスタム絵文字のショートコード）
await client.announcements.addReaction('announcement-id', '👍');
await client.announcements.addReaction('announcement-id', 'blobcat');

// リアクションを削除
await client.announcements.removeReaction('announcement-id', '👍');
```

---

## ヘルスチェック

```dart
final healthy = await client.health.check();
// Web プロセス・データベース・キャッシュがすべて正常なら true を返す。
// いずれかが異常な場合は MastodonException をスローする。
```

認証不要です。監視やレディネスプローブに活用できます。

---

## ユーザー設定

```dart
final prefs = await client.preferences.fetch();
print(prefs.postingDefaultVisibility);
print(prefs.postingDefaultLanguage);
print(prefs.expandSpoilers);
```

認証ユーザーの `MastodonPreferences` を返します。設定を変更するには `client.accounts.updateCredentials()` を使用してください。

---

## プロフィールディレクトリ

```dart
// 最近アクティブなアカウント（全サーバー対象）
final active = await client.directory.fetch(
  order: 'active',
  limit: 40,
);

// 新規登録のローカルアカウントのみ
final newLocal = await client.directory.fetch(
  order: 'new',
  local: true,
);
```

パラメーター:

| パラメーター | デフォルト | 最大値 | 説明 |
|-------------|-----------|-------|------|
| `limit`     | 40        | 80    | 取得件数 |
| `offset`    | —         | —     | 先頭からスキップする件数 |
| `order`     | —         | —     | `active`（最終投稿順）または `new`（作成日順） |
| `local`     | —         | —     | `true` でローカルアカウントのみ取得 |

認証不要です。

---

## oEmbed

```dart
final embed = await client.oembed.fetch(
  'https://mastodon.social/@user/12345',
  maxwidth: 500,
);
print(embed.html);
```

ステータス URL の埋め込み用 HTML を含む `MastodonOEmbed` を返します。認証不要です。

---

## タイムラインマーカー

マーカーを使うと、ホームタイムラインと通知タイムラインの既読位置をセッションやデバイスをまたいで保持できます。

### マーカーの取得

```dart
final markers = await client.markers.fetch(['home', 'notifications']);
final home = markers['home'];
print(home?.lastReadId);
```

`'home'`・`'notifications'` のいずれか、または両方を含むリストを渡します。何も指定しない場合は空のマップを返します。

### マーカーの保存

```dart
final updated = await client.markers.save(
  homeLastReadId: '109876543210',
  notificationsLastReadId: '987654321',
);
```

`homeLastReadId` と `notificationsLastReadId` のうち少なくとも一方を指定してください。別のデバイスからの書き込みと競合した場合、サーバーは `409 Conflict` を返します。その際はリトライしてください。

```dart
// 競合時のリトライ例
Map<String, MastodonMarker> result;
while (true) {
  try {
    result = await client.markers.save(homeLastReadId: lastId);
    break;
  } on MastodonConflictException {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
```
