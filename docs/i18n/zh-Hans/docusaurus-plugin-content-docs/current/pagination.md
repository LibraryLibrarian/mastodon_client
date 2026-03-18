---
sidebar_position: 3
---

# 分页

Mastodon API 使用基于游标的分页方式。本库通过 `MastodonPage<T>` 对其进行了封装。

## MastodonPage 结构

```dart
class MastodonPage<T> {
  final List<T> items;      // 当前页的数据项
  final String? nextMaxId;  // 下一页的游标（更旧的数据）
  final String? prevMinId;  // 上一页的游标（更新的数据）
}
```

## 基本用法

### 获取第一页

```dart
final page = await client.notifications.fetch(limit: 20);

for (final notification in page.items) {
  print(notification.type);
}
```

### 获取下一页（更旧的数据）

将 `nextMaxId` 作为 `maxId` 参数传入：

```dart
if (page.nextMaxId != null) {
  final nextPage = await client.notifications.fetch(
    limit: 20,
    maxId: page.nextMaxId,
  );
}
```

### 获取上一页（更新的数据）

将 `prevMinId` 作为 `minId` 参数传入：

```dart
if (page.prevMinId != null) {
  final prevPage = await client.notifications.fetch(
    limit: 20,
    minId: page.prevMinId,
  );
}
```

## 分页参数

| 参数 | 方向 | 说明 |
|------|------|------|
| `maxId` | 更旧 | 返回此 ID 之前的结果 |
| `sinceId` | 更新 | 返回此 ID 之后的结果（可能有间隔） |
| `minId` | 更新 | 返回紧接此 ID 之后的结果（无间隔） |
| `limit` | — | 最大结果数量（省略时使用服务器默认值） |

### `sinceId` 与 `minId` 的区别

- `sinceId`：返回比指定 ID 更新的**最新** `limit` 条结果（中间可能有跳过）
- `minId`：返回**从指定 ID 紧接之后**开始的 `limit` 条结果（无间隔的顺序翻页）

实时更新检查使用 `sinceId`；顺序遍历分页使用 `minId`。

## 遍历所有分页

```dart
Future<List<MastodonNotification>> fetchAll() async {
  final all = <MastodonNotification>[];
  String? maxId;

  while (true) {
    final page = await client.notifications.fetch(
      limit: 40,
      maxId: maxId,
    );
    all.addAll(page.items);

    if (page.nextMaxId == null) break;
    maxId = page.nextMaxId;
  }

  return all;
}
```

:::caution
一次性获取大量数据会对服务器造成负担，请注意频率限制。
:::

## 支持分页的 API

以下是返回分页结果的主要 API：

- `client.notifications.fetch()` — 通知
- `client.accounts.fetchFollowers()` — 关注者列表
- `client.accounts.fetchFollowing()` — 关注列表
- `client.accounts.fetchStatuses()` — 账号帖子
- `client.timelines.*` — 时间线
- `client.favourites.fetch()` — 收藏列表
- `client.bookmarks.fetch()` — 书签列表
- `client.blocks.fetch()` — 已屏蔽账号
- `client.mutes.fetch()` — 已静音账号
