---
sidebar_position: 5
---

# 搜索

`client.search` API 在单次请求中跨账号、帖子和话题标签进行搜索。

## 基本搜索

```dart
final result = await client.search.search('mastodon');

print('Accounts: ${result.accounts.length}');
print('Statuses: ${result.statuses.length}');
print('Hashtags: ${result.hashtags.length}');
```

结果为 `MastodonSearchResult`，包含三个列表：

- `accounts` — `List<MastodonAccount>`
- `statuses` — `List<MastodonStatus>`
- `hashtags` — `List<MastodonTag>`

## 按类型过滤

传入 `type` 将结果限定为某一类别。可接受的值为 `'accounts'`、`'statuses'` 和 `'hashtags'`。

```dart
// 仅账号
final result = await client.search.search('alice', type: 'accounts');

// 仅帖子
final result = await client.search.search('hello world', type: 'statuses');

// 仅标签
final result = await client.search.search('dart', type: 'hashtags');
```

## 解析远程账号

设置 `resolve: true`，在未找到本地结果时通过 WebFinger 查询远程账号。需要用户 token。

```dart
final result = await client.search.search(
  'alice@example.social',
  resolve: true,
);
```

## 限定为已关注账号

设置 `following: true` 仅返回你所关注的账号。需要用户 token。

```dart
final result = await client.search.search(
  'alice',
  type: 'accounts',
  following: true,
);
```

## 限定帖子到指定账号

`accountId` 将帖子结果限定为单个账号的发帖。

```dart
final result = await client.search.search(
  'hello',
  type: 'statuses',
  accountId: '109876543210',
);
```

## 排除未审核标签

设置 `excludeUnreviewed: true` 隐藏未经版主审核的标签（Mastodon 3.0.0 新增）。

```dart
final result = await client.search.search(
  'dart',
  type: 'hashtags',
  excludeUnreviewed: true,
);
```

## 分页

搜索 API 在指定 `type` 时支持偏移量分页，同时支持通过 `minId` / `maxId` 进行游标分页。

### 偏移量分页

`offset` 跳过开头的若干结果。与 `limit` 和固定的 `type` 配合使用。需要用户 token。

```dart
final page1 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 0,
);

final page2 = await client.search.search(
  'mastodon',
  type: 'statuses',
  limit: 20,
  offset: 20,
);
```

### 游标分页

使用 `maxId` 和 `minId` 进行类似时间线接口的游标导航。

```dart
final result = await client.search.search(
  'mastodon',
  type: 'statuses',
  maxId: '109876543210',
);
```

每个类别的默认 `limit` 为 20；最大值为 40。

## 已弃用：v1 搜索

`searchV1()` 已在 Mastodon 3.0.0 中移除，仅用于兼容仍运行 2.x 版本的实例。所有新接入请使用 `search()`。

与 v2 的主要差异：

- `hashtags` 返回 `List<String>`（纯标签名），而非 `List<MastodonTag>`
- 不支持 `following` 和 `excludeUnreviewed` 参数
