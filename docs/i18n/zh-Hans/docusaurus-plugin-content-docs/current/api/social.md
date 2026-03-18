---
sidebar_position: 12
---

# 社交

本页介绍基本关注操作之外的社交图谱 API：关注请求、已关注标签、关注建议、推荐账号、精选标签、标签操作、收藏和书签。

## 关注请求

当账号设为私密时，收到的关注请求需通过 `client.followRequests` 明确接受或拒绝。

### 列出待处理请求

```dart
final page = await client.followRequests.fetch(limit: 40);
for (final account in page.items) {
  print('${account.acct} wants to follow you');
}

// 分页
if (page.nextMaxId != null) {
  final next = await client.followRequests.fetch(maxId: page.nextMaxId);
}
```

`fetch` 返回 `MastodonPage<MastodonAccount>`。分页游标来自 `Link` 响应头。默认限制 40 条，最大 80 条。

### 接受请求

```dart
final relationship = await client.followRequests.authorize('12345');
print(relationship.followedBy); // true
```

### 拒绝请求

```dart
final relationship = await client.followRequests.reject('12345');
```

`authorize` 和 `reject` 均返回反映最新关系状态的 `MastodonRelationship`。

## 已关注标签

`client.followedTags` 列出已认证用户关注的话题标签。关注的标签下的帖子会出现在主页时间线。

```dart
final page = await client.followedTags.fetch(limit: 100);
for (final tag in page.items) {
  print('#${tag.name}');
}
```

默认限制 100 条，最大 200 条。分页使用 `maxId`、`sinceId` 和 `minId`。注意游标 ID 是内部关注关系记录的 ID，而非标签 ID。

关注或取消关注特定标签请使用 `client.tags`（见下文）。

## 关注建议

`client.suggestions` 返回服务器推荐关注的账号——由工作人员精选，或是用户曾有正向互动但尚未关注的账号。

```dart
final suggestions = await client.suggestions.fetch(limit: 20);
for (final suggestion in suggestions) {
  print('${suggestion.account.acct} — reason: ${suggestion.source}');
}
```

返回 `List<MastodonSuggestion>`。默认限制 40 条，最大 80 条。

从建议列表中移除账号：

```dart
await client.suggestions.remove('12345');
```

即使该账号当前不在建议列表中，此操作也会成功。

## 推荐账号

推荐账号是用户选择在个人资料上展示的账号。使用 `client.endorsements` 获取。

```dart
final page = await client.endorsements.fetch(limit: 40);
for (final account in page.items) {
  print(account.displayName);
}
```

返回 `MastodonPage<MastodonAccount>`。默认限制 40 条，最大 80 条。推荐或取消推荐账号请使用 `client.accounts.endorse` 和 `client.accounts.unendorse`。

## 精选标签

精选标签是在用户个人资料上突出显示的话题标签。使用 `client.featuredTags` 进行管理。

### 列出精选标签

```dart
final tags = await client.featuredTags.fetch();
for (final tag in tags) {
  print('#${tag.name} — ${tag.statusesCount} statuses');
}
```

### 添加精选标签

```dart
final tag = await client.featuredTags.create('dart');
print(tag.id);
```

传入标签名时不需要 `#` 前缀。

### 移除精选标签

```dart
await client.featuredTags.delete(tag.id);
```

### 精选标签建议

服务器会返回最多 10 个近期使用的话题标签作为候选：

```dart
final suggestions = await client.featuredTags.fetchSuggestions();
```

返回 `List<MastodonTag>`。

## 标签

`client.tags` 提供标签信息查询、关注和精选操作。

### 获取标签信息

```dart
final tag = await client.tags.fetch('dart');
print(tag.name);
print(tag.following); // 未认证时为 null
```

名称查找不区分大小写。认证后，`following` 字段会包含在响应中。

### 关注与取消关注标签

```dart
final tag = await client.tags.follow('dart');
print(tag.following); // true

final unfollowed = await client.tags.unfollow('dart');
print(unfollowed.following); // false
```

### 精选与取消精选标签（Mastodon 4.4.0+）

```dart
await client.tags.feature('dart');
await client.tags.unfeature('dart');
```

两者均返回反映最新状态的 `MastodonTag`。

## 收藏

`client.favourites` 列出已认证用户收藏的所有帖子。

```dart
final page = await client.favourites.fetch(limit: 20);
for (final status in page.items) {
  print(status.content);
}

// 更旧的结果
if (page.nextMaxId != null) {
  final older = await client.favourites.fetch(maxId: page.nextMaxId);
}
```

返回 `MastodonPage<MastodonStatus>`。默认限制 20 条，最大 40 条。分页使用 `maxId`、`sinceId` 和 `minId`。

收藏或取消收藏特定帖子请使用 `client.statuses.favourite` 和 `client.statuses.unfavourite`。

## 书签

`client.bookmarks` 列出已认证用户书签的所有帖子。

```dart
final page = await client.bookmarks.fetch(limit: 20);
for (final status in page.items) {
  print(status.id);
}
```

返回 `MastodonPage<MastodonStatus>`。默认限制 20 条，最大 40 条。分页使用 `maxId`、`sinceId` 和 `minId`。

添加或移除书签请使用 `client.statuses.bookmark` 和 `client.statuses.unbookmark`。
