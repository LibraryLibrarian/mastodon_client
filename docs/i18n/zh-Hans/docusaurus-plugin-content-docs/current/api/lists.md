---
sidebar_position: 7
---

# 列表

`client.lists` API 用于创建和管理列表、添加或移除账号，以及读取列表时间线。

## 获取列表

### 所有列表

```dart
final lists = await client.lists.fetch();
for (final list in lists) {
  print('${list.id}: ${list.title}');
}
```

返回已认证用户拥有的所有列表，类型为 `List<MastodonList>`。

### 单个列表

```dart
final list = await client.lists.fetchById('42');
print(list.title);
print(list.repliesPolicy); // "followed" | "list" | "none"
print(list.exclusive);     // true 表示主页时间线排除列表成员
```

## 创建列表

```dart
final list = await client.lists.create(
  title: 'Developer friends',
  repliesPolicy: 'list',   // 显示列表成员之间的回复
  exclusive: false,
);
print(list.id);
```

`repliesPolicy` 接受：
- `followed` — 显示对查看者所关注用户的回复
- `list` — 显示对其他列表成员的回复
- `none` — 隐藏所有回复

当 `exclusive` 为 `true` 时，列表成员的帖子将从主页时间线中排除。

## 更新列表

```dart
final updated = await client.lists.update(
  '42',
  title: 'Close friends',
  repliesPolicy: 'followed',
  exclusive: true,
);
```

## 删除列表

```dart
await client.lists.delete('42');
```

## 管理账号

### 获取列表中的账号

```dart
final page = await client.lists.fetchAccounts(
  '42',
  limit: 40,
);

for (final account in page.items) {
  print(account.acct);
}
```

返回 `MastodonPage<MastodonAccount>`。使用 `nextMaxId` 和 `prevMinId` 进行分页：

```dart
MastodonPage<MastodonAccount>? page = await client.lists.fetchAccounts('42');

while (page != null && page.nextMaxId != null) {
  page = await client.lists.fetchAccounts(
    '42',
    maxId: page.nextMaxId,
  );
  for (final account in page.items) {
    print(account.acct);
  }
}
```

分页参数：

| 参数 | 说明 |
|------|------|
| `limit`   | 最大结果数（默认：40，上限：80；传 `0` 获取全部） |
| `maxId`   | 返回比此 ID 更旧的结果 |
| `sinceId` | 返回比此 ID 更新的结果 |
| `minId`   | 返回紧接此 ID 之后的结果（顺序翻页） |

### 添加账号

添加的账号必须是已认证用户所关注的。

```dart
await client.lists.addAccounts(
  '42',
  accountIds: ['100', '101', '102'],
);
```

### 移除账号

```dart
await client.lists.removeAccounts(
  '42',
  accountIds: ['101'],
);
```

## MastodonList 模型

| 字段 | 类型 | 说明 |
|------|------|------|
| `id` | `String` | 列表内部 ID |
| `title` | `String` | 列表标题 |
| `repliesPolicy` | `String` | 回复显示策略（`followed` / `list` / `none`） |
| `exclusive` | `bool` | 列表成员是否从主页时间线排除 |
