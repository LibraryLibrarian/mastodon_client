---
sidebar_position: 2
---

# 帖子

`client.statuses` API 提供帖子的创建、获取和互动操作。

## 获取帖子

### 单条帖子

```dart
final status = await client.statuses.fetch('12345');
print(status.content);
```

### 批量获取帖子

```dart
final statuses = await client.statuses.fetchMultiple(['1', '2', '3']);
```

不存在或无法访问的 ID 会从结果中静默排除。

### 线程上下文

```dart
final context = await client.statuses.fetchContext('12345');
print('${context.ancestors.length} ancestors');
print('${context.descendants.length} descendants');
```

### 编辑历史

```dart
final history = await client.statuses.fetchHistory('12345');
for (final edit in history) {
  print(edit.content);
}
```

### 源文本（用于编辑）

```dart
final source = await client.statuses.fetchSource('12345');
print(source.text);        // 纯文本内容
print(source.spoilerText); // 内容警告文字
```

## 发布帖子

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'Hello, Mastodon!',
    visibility: MastodonVisibility.public,
  ),
);

// result 为 MastodonStatusCreated 或 MastodonStatusScheduled
if (result case MastodonStatusCreated(:final status)) {
  print('Posted: ${status.url}');
}
```

### 附带媒体

```dart
final attachment = await client.media.upload(imageBytes, 'photo.jpg',
  description: 'A beautiful sunset',
);

final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'Check this out!',
    mediaIds: [attachment.id],
  ),
);
```

### 附带投票

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'What do you prefer?',
    poll: MastodonPollCreateRequest(
      options: ['Option A', 'Option B', 'Option C'],
      expiresIn: 86400, // 24 小时
      multiple: false,
    ),
  ),
);
```

### 定时发布

```dart
final result = await client.statuses.create(
  MastodonStatusCreateRequest(
    status: 'This will be posted later',
    scheduledAt: '2025-12-31T00:00:00.000Z',
  ),
);

if (result case MastodonStatusScheduled(:final scheduledStatus)) {
  print('Scheduled for: ${scheduledStatus.scheduledAt}');
}
```

### 幂等性

```dart
final result = await client.statuses.create(
  request,
  idempotencyKey: 'unique-key-123',
);
```

使用相同 key 重复请求将返回相同结果。

## 编辑帖子

```dart
final updated = await client.statuses.edit(
  '12345',
  MastodonStatusEditRequest(
    status: 'Updated content',
  ),
);
```

## 删除帖子

```dart
final deleted = await client.statuses.delete('12345');
// 返回包含源文本信息的快照，可用于重新起草
print(deleted.text);
```

## 互动

### 转嘟 / 取消转嘟

```dart
final boosted = await client.statuses.boost('12345');
// 返回包装帖子；原始帖子在 boosted.reblog 中

final unboosted = await client.statuses.unboost('12345');
// 直接返回原始帖子
```

### 收藏 / 取消收藏

```dart
await client.statuses.favourite('12345');
await client.statuses.unfavourite('12345');
```

### 书签 / 移除书签

```dart
await client.statuses.bookmark('12345');
await client.statuses.unbookmark('12345');
```

### 静音 / 取消静音对话

```dart
await client.statuses.mute('12345');   // 停止线程通知
await client.statuses.unmute('12345');
```

### 置顶 / 取消置顶

```dart
await client.statuses.pin('12345');
await client.statuses.unpin('12345');
```

## 谁转嘟了 / 谁收藏了

```dart
final boosters = await client.statuses.fetchRebloggedBy('12345', limit: 40);
final favouriters = await client.statuses.fetchFavouritedBy('12345', limit: 40);
```

两者均返回支持分页的 `MastodonPage<MastodonAccount>`。

## 翻译

```dart
final translation = await client.statuses.translate('12345', lang: 'en');
print(translation.content);
```

仅公开或不公开列出(unlisted)的帖子可被翻译。
