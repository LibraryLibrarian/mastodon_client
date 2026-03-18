---
sidebar_position: 12
---

# ソーシャル

このページでは、基本的なフォロー操作以外のソーシャルグラフ API を説明します。フォローリクエスト、フォロー中タグ、フォロー候補、エンドースメント、注目タグ、ハッシュタグ操作、お気に入り、ブックマークを扱います。

## フォローリクエスト

アカウントが承認制（ロック）の場合、受信したフォローリクエストは `client.followRequests` を使って明示的に承認または拒否する必要があります。

### 保留中のリクエスト一覧

```dart
final page = await client.followRequests.fetch(limit: 40);
for (final account in page.items) {
  print('${account.acct} があなたをフォローしようとしています');
}

// ページネーション
if (page.nextMaxId != null) {
  final next = await client.followRequests.fetch(maxId: page.nextMaxId);
}
```

`fetch` は `MastodonPage<MastodonAccount>` を返します。ページネーションカーソルはレスポンスの `Link` ヘッダーから取得されます。デフォルトの取得件数は 40 件で、最大は 80 件です。

### リクエストの承認

```dart
final relationship = await client.followRequests.authorize('12345');
print(relationship.followedBy); // true
```

### リクエストの拒否

```dart
final relationship = await client.followRequests.reject('12345');
```

`authorize` と `reject` はどちらも、更新後のリレーションシップ状態を表す `MastodonRelationship` を返します。

## フォロー中のタグ

`client.followedTags` は、認証ユーザーがフォローしているハッシュタグの一覧を返します。フォロー中のタグを含む投稿はホームタイムラインに表示されます。

```dart
final page = await client.followedTags.fetch(limit: 100);
for (final tag in page.items) {
  print('#${tag.name}');
}
```

デフォルトの取得件数は 100 件で、最大は 200 件です。ページネーションは `maxId`、`sinceId`、`minId` で行います。カーソル ID はタグ ID ではなく、フォロー関係の内部レコード ID です。

特定のタグをフォロー・アンフォローするには `client.tags` を使用してください（後述）。

## フォロー候補

`client.suggestions` は、サーバーが推奨するフォロー候補アカウントを返します。スタッフがキュレーションしたアカウントや、まだフォローしていないがポジティブなインタラクションがあったアカウントが含まれます。

```dart
final suggestions = await client.suggestions.fetch(limit: 20);
for (final suggestion in suggestions) {
  print('${suggestion.account.acct} — 理由: ${suggestion.source}');
}
```

`List<MastodonSuggestion>` を返します。デフォルトの取得件数は 40 件で、最大は 80 件です。

フォロー候補からアカウントを削除するには:

```dart
await client.suggestions.remove('12345');
```

対象アカウントが候補に含まれていない場合でも正常終了します。

## エンドースメント

エンドースメントとは、ユーザーが自分のプロフィールに表示するよう選択したアカウントです。`client.endorsements` で一覧を取得できます。

```dart
final page = await client.endorsements.fetch(limit: 40);
for (final account in page.items) {
  print(account.displayName);
}
```

`MastodonPage<MastodonAccount>` を返します。デフォルトの取得件数は 40 件で、最大は 80 件です。エンドース・アンエンドースの操作は `client.accounts.endorse` と `client.accounts.unendorse` で行います。

## 注目タグ（Featured Tags）

注目タグはユーザーのプロフィールに目立つ形で表示されるハッシュタグです。`client.featuredTags` で管理します。

### 注目タグの一覧

```dart
final tags = await client.featuredTags.fetch();
for (final tag in tags) {
  print('#${tag.name} — ${tag.statusesCount} 件の投稿');
}
```

### 注目タグの追加

```dart
final tag = await client.featuredTags.create('dart');
print(tag.id);
```

タグ名は `#` を除いた文字列を渡します。

### 注目タグの削除

```dart
await client.featuredTags.delete(tag.id);
```

### 注目タグ候補の取得

最近使用したハッシュタグを最大 10 件、候補として取得できます:

```dart
final suggestions = await client.featuredTags.fetchSuggestions();
```

`List<MastodonTag>` を返します。

## ハッシュタグ操作

`client.tags` でタグ情報の取得、フォロー、注目設定を行います。

### タグ情報の取得

```dart
final tag = await client.tags.fetch('dart');
print(tag.name);
print(tag.following); // 未認証の場合は null
```

名前の検索は大文字・小文字を区別しません。認証済みの場合は `following` フィールドも含まれます。

### タグのフォロー・アンフォロー

```dart
final tag = await client.tags.follow('dart');
print(tag.following); // true

final unfollowed = await client.tags.unfollow('dart');
print(unfollowed.following); // false
```

### タグの注目・注目解除（Mastodon 4.4.0 以降）

```dart
await client.tags.feature('dart');
await client.tags.unfeature('dart');
```

いずれも更新後の状態を表す `MastodonTag` を返します。

## お気に入り

`client.favourites` は認証ユーザーがお気に入りに追加したすべての投稿を一覧表示します。

```dart
final page = await client.favourites.fetch(limit: 20);
for (final status in page.items) {
  print(status.content);
}

// 古い結果を取得
if (page.nextMaxId != null) {
  final older = await client.favourites.fetch(maxId: page.nextMaxId);
}
```

`MastodonPage<MastodonStatus>` を返します。デフォルトの取得件数は 20 件で、最大は 40 件です。ページネーションは `maxId`、`sinceId`、`minId` で行います。

特定の投稿をお気に入り登録・解除するには `client.statuses.favourite` と `client.statuses.unfavourite` を使用してください。

## ブックマーク

`client.bookmarks` は認証ユーザーがブックマークしたすべての投稿を一覧表示します。

```dart
final page = await client.bookmarks.fetch(limit: 20);
for (final status in page.items) {
  print(status.id);
}
```

`MastodonPage<MastodonStatus>` を返します。デフォルトの取得件数は 20 件で、最大は 40 件です。ページネーションは `maxId`、`sinceId`、`minId` で行います。

ブックマークの追加・削除は `client.statuses.bookmark` と `client.statuses.unbookmark` で行います。
