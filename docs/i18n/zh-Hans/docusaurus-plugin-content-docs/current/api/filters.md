---
sidebar_position: 6
---

# 过滤器

`client.filters` API 管理服务端内容过滤器（Mastodon 4.0+）。过滤器可以隐藏或对匹配指定关键词或特定帖子 ID 的帖子显示警告。

## 获取过滤器

### 所有过滤器

```dart
final filters = await client.filters.fetch();

for (final filter in filters) {
  print('${filter.title}: ${filter.filterAction}');
}
```

### 单个过滤器

```dart
final filter = await client.filters.fetchById('1');
print(filter.title);
```

## 创建过滤器

`title` 和 `context` 为必填项。`context` 是一个列表，指定过滤器适用的一个或多个位置：

| 值 | 过滤器适用位置 |
|---|---|
| `home` | 主页和列表时间线 |
| `notifications` | 通知时间线 |
| `public` | 公开时间线 |
| `thread` | 会话线程内 |
| `account` | 查看个人资料时 |

```dart
final filter = await client.filters.create(
  title: 'Hide spoilers',
  context: ['home', 'public'],
  filterAction: 'warn',
  expiresIn: 86400, // 1 天；省略则永不过期
);
```

`filterAction` 接受 `'warn'`（显示警告）、`'hide'`（完全移除帖子）或 `'blur'`。省略时使用服务器默认值。

### 创建时附带关键词

通过 `keywordsAttributes` 在创建时添加关键词。

```dart
final filter = await client.filters.create(
  title: 'Election noise',
  context: ['home', 'notifications', 'public'],
  filterAction: 'warn',
  keywordsAttributes: [
    MastodonFilterKeywordParam(keyword: 'election', wholeWord: true),
    MastodonFilterKeywordParam(keyword: 'vote'),
  ],
);
```

## 更新过滤器

所有参数均为可选，只有提供的字段才会被更新。

```dart
final updated = await client.filters.update(
  '1',
  title: 'Updated title',
  filterAction: 'hide',
);
```

## 删除过滤器

```dart
await client.filters.delete('1');
```

## 过滤关键词

关键词是过滤器用于匹配的词语，每个关键词属于一个过滤器。

### 列出关键词

```dart
final keywords = await client.filters.fetchKeywords('1');

for (final kw in keywords) {
  print('${kw.keyword} (whole word: ${kw.wholeWord})');
}
```

### 添加关键词

```dart
final keyword = await client.filters.createKeyword(
  '1', // 过滤器 ID
  keyword: 'spoiler',
  wholeWord: true,
);
```

### 获取单个关键词

```dart
final keyword = await client.filters.fetchKeywordById('42');
```

### 更新关键词

```dart
final updated = await client.filters.updateKeyword(
  '42',
  keyword: 'spoilers',
  wholeWord: false,
);
```

### 删除关键词

```dart
await client.filters.deleteKeyword('42');
```

### 在过滤器更新中批量修改关键词

向 `update()` 传入 `keywordsAttributes`，可在一次请求中添加、修改或删除多个关键词。将条目的 `destroy` 设为 `true` 可删除该关键词。

```dart
await client.filters.update(
  '1',
  keywordsAttributes: [
    MastodonFilterKeywordUpdateParam(keyword: 'newword'),           // 添加
    MastodonFilterKeywordUpdateParam(id: '10', keyword: 'changed'), // 修改
    MastodonFilterKeywordUpdateParam(id: '11', keyword: '', destroy: true), // 删除
  ],
);
```

## 过滤帖子

除关键词匹配外，还可以将特定帖子添加到过滤器，使其始终被隐藏。

### 列出已过滤帖子

```dart
final statuses = await client.filters.fetchStatuses('1');
```

### 将帖子添加到过滤器

```dart
final filterStatus = await client.filters.createStatus(
  '1', // 过滤器 ID
  statusId: '109876543210',
);
```

### 获取单条过滤帖子记录

```dart
final filterStatus = await client.filters.fetchStatusById('99');
```

### 从过滤器移除帖子

```dart
await client.filters.deleteStatus('99');
```

## 已弃用：v1 过滤器

v1 过滤器 API 已在 Mastodon 4.0.0 中弃用，仅用于兼容旧版实例。

| v1 方法 | v2 对应方法 |
|---|---|
| `fetchV1()` | `fetch()` |
| `fetchByIdV1(id)` | `fetchById(id)` |
| `createV1(phrase:, context:)` | `create(title:, context:)` |
| `updateV1(id, phrase:, context:)` | `update(id)` |
| `deleteV1(id)` | `delete(id)` |

与 v2 的主要差异：

- v1 使用单个 `phrase` 字符串，而非关键词列表。
- `irreversible: true` 会永久从主页和通知中丢弃匹配帖子，不显示任何客户端警告。
- `deleteV1()` 只删除 `FilterKeyword` 记录，不删除父过滤器。
- v1 过滤器仅在客户端生效，服务端不强制执行。
