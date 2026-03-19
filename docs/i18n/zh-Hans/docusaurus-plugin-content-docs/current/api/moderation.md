---
sidebar_position: 11
---

# 内容管理

本页介绍用于管理已屏蔽账号、已静音账号、域名屏蔽和用户举报的 API。

所有列表方法均返回 `MastodonPage<T>`，其中包含结果项以及从 `Link` 响应头中解析出的 `nextMaxId` 和 `prevMinId` 游标。详情请参阅 [分页](../pagination.md) 指南。

---

## 已屏蔽账号

### 列出屏蔽

```dart
final page = await client.blocks.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// 下一页
if (page.nextMaxId != null) {
  final next = await client.blocks.fetch(maxId: page.nextMaxId);
}
```

参数：

| 参数 | 默认值 | 上限 | 说明 |
|------|--------|------|------|
| `limit`   | 40 | 80 | 结果数量 |
| `maxId`   | — | — | 返回比此 ID 更旧的结果 |
| `sinceId` | — | — | 返回比此 ID 更新的结果 |
| `minId`   | — | — | 返回紧接此 ID 之后最旧的结果（反向分页） |

屏蔽或取消屏蔽账号请使用 `client.accounts.block()` 和 `client.accounts.unblock()`。

---

## 已静音账号

### 列出静音

```dart
final page = await client.mutes.fetch(limit: 40);
for (final account in page.items) {
  print(account.acct);
}

// 下一页
if (page.nextMaxId != null) {
  final next = await client.mutes.fetch(maxId: page.nextMaxId);
}
```

参数：

| 参数 | 默认值 | 上限 | 说明 |
|------|--------|------|------|
| `limit`   | 40 | 80 | 结果数量 |
| `maxId`   | — | — | 返回比此 ID 更旧的结果 |
| `sinceId` | — | — | 返回比此 ID 更新的结果 |

静音或取消静音账号请使用 `client.accounts.mute()` 和 `client.accounts.unmute()`。

---

## 域名屏蔽

用户级别的域名屏蔽可以隐藏整个域名的帖子和通知。这与实例级别的域名屏蔽不同（参见 `client.instance.fetchDomainBlocks()`）。

### 列出已屏蔽域名

```dart
final page = await client.domainBlocks.fetch(limit: 100);
for (final domain in page.items) {
  print(domain);
}
```

参数：

| 参数 | 默认值 | 上限 | 说明 |
|------|--------|------|------|
| `limit`   | 100 | 200 | 结果数量 |
| `maxId`   | — | — | 返回比此 ID 更旧的结果 |
| `sinceId` | — | — | 返回比此 ID 更新的结果 |
| `minId`   | — | — | 返回紧接此 ID 之后最旧的结果（反向分页） |

### 屏蔽域名

```dart
await client.domainBlocks.block('spam.example.com');
```

屏蔽域名后，该域名上所有账号的公开帖子和通知将被隐藏，现有来自该域名的关注者将被移除，并阻止新的关注。

### 取消屏蔽域名

```dart
await client.domainBlocks.unblock('spam.example.com');
```

---

## 举报

### 举报账号

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    comment: 'This account is posting spam.',
    category: 'spam',
  ),
);
print(report.id);
```

### 举报特定帖子

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '12345',
    statusIds: ['111', '222'],
    comment: 'These posts violate the rules.',
    category: 'violation',
    ruleIds: ['1', '3'],
  ),
);
```

### 转发至远程管理员

将 `forward` 设为 `true`，可将举报副本发送给被举报账号所在服务器的管理员。

```dart
final report = await client.reports.create(
  MastodonReportCreateRequest(
    accountId: '67890',
    comment: 'Harassment from a remote account.',
    forward: true,
  ),
);
```

### 请求字段

| 字段 | 必填 | 说明 |
|------|------|------|
| `accountId`  | 是 | 被举报账号的 ID |
| `statusIds`  | 否 | 作为证据附加的帖子 ID |
| `comment`    | 否 | 举报原因（最多 1000 字符） |
| `forward`    | 否 | 转发给远程服务器管理员 |
| `category`   | 否 | `spam`、`legal`、`violation` 或 `other` |
| `ruleIds`    | 否 | 违反的规则 ID（与 `violation` 类别配合使用） |
