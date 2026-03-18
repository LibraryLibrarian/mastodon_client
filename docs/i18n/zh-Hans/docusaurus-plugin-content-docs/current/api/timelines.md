---
sidebar_position: 4
---

# 时间线

`client.timelines` API 从不同来源获取帖子流。所有方法均返回 `MastodonPage<MastodonStatus>`，支持基于游标的分页。

## 主页时间线

主页时间线包含你所关注账号的帖子。

```dart
final page = await client.timelines.fetchHome(limit: 20);

for (final status in page.items) {
  print('${status.account.acct}: ${status.content}');
}
```

## 公开时间线

### 本地时间线

来自同一实例账号的帖子。

```dart
final page = await client.timelines.fetchLocal(limit: 20);
```

传入 `onlyMedia: true` 可将结果限定为带有媒体附件的帖子。

```dart
final page = await client.timelines.fetchLocal(onlyMedia: true);
```

### 联合时间线

实例从整个网络接收到的所有公开帖子。

```dart
final page = await client.timelines.fetchFederated(limit: 20);
```

可选参数：

- `onlyMedia` — 仅包含带媒体附件的帖子
- `remoteOnly` — 排除本地账号的帖子

```dart
final page = await client.timelines.fetchFederated(
  remoteOnly: true,
  onlyMedia: true,
);
```

## 话题标签时间线

包含指定话题标签的帖子。传入标签名时不需要 `#` 前缀。

```dart
final page = await client.timelines.fetchHashtag('mastodon', limit: 20);
```

附加标签过滤器可以扩大或缩小结果范围：

- `any` — 同时包含含有这些额外标签的帖子
- `all` — 要求同时包含所有这些额外标签
- `none` — 排除包含这些标签的帖子

```dart
final page = await client.timelines.fetchHashtag(
  'dart',
  any: ['flutter'],
  none: ['spam'],
);
```

可通过 `localOnly` 或 `remoteOnly` 限定范围。

## 列表时间线

来自特定列表中账号的帖子。需要列表的 ID。

```dart
final page = await client.timelines.fetchList('42', limit: 20);
```

## 链接时间线

与特定 URL 相关的帖子（需要服务器支持）。

```dart
final page = await client.timelines.fetchLink(
  'https://example.com/article',
  limit: 20,
);
```

## 分页

所有时间线方法都返回 `MastodonPage<MastodonStatus>`，其中包含用于导航到更旧和更新页面的游标。

### 获取下一页（更旧的帖子）

```dart
var page = await client.timelines.fetchHome(limit: 20);

while (page.nextMaxId != null) {
  page = await client.timelines.fetchHome(
    limit: 20,
    maxId: page.nextMaxId,
  );
  for (final status in page.items) {
    print(status.content);
  }
}
```

### 轮询新帖子

使用 `sinceId` 检查比最后已知 ID 更新的帖子。

```dart
String? latestId = page.items.firstOrNull?.id;

final newPage = await client.timelines.fetchHome(
  sinceId: latestId,
);
```

### 使用 `minId` 顺序翻页

`minId` 返回紧接指定 ID 之后的结果，无间隔，适用于顺序遍历。

```dart
final nextPage = await client.timelines.fetchHome(
  minId: page.prevMinId,
);
```

游标参数的完整说明请参阅 [分页](../pagination.md) 指南。

## 已弃用：私信时间线

`fetchDirect()` 已在 Mastodon 3.0.0 中移除。请改用 Conversations API。
