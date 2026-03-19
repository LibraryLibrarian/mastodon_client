---
sidebar_position: 14
---

# 管理员

管理员 API 提供服务器管理功能。所有端点都需要较高权限的 OAuth scope（通常为 `admin:read:*` 或 `admin:write:*`）。仅在拥有对应服务端权限的账号下使用这些 API。

## 账号管理

`client.adminAccounts` 提供面向管理员的完整账号管理功能。

### 列出账号

提供两个版本的列表端点。

**v1** — 布尔型过滤标志：

```dart
final page = await client.adminAccounts.fetch(
  pending: true,   // 仅列出待审核账号
  limit: 100,
);
for (final account in page.items) {
  print('${account.account?.acct} — ${account.email}');
}
```

可用过滤器：`local`、`remote`、`active`、`pending`、`disabled`、`silenced`、`suspended`、`sensitized`、`staff`。搜索参数：`username`、`displayName`、`email`、`ip`、`byDomain`。分页：`maxId`、`sinceId`、`minId`。默认限制 100 条，最大 200 条。

**v2** — 结构化过滤参数（推荐新代码使用）：

```dart
final page = await client.adminAccounts.fetchV2(
  origin: 'local',
  status: 'pending',
  limit: 50,
);
```

`origin` 为 `local` 或 `remote`。`status` 为 `active`、`pending`、`disabled`、`silenced` 或 `suspended` 之一。`permissions` 传入 `staff` 可限定为员工账号。`roleIds` 按角色 ID 过滤，`invitedBy` 按邀请人账号 ID 过滤。

### 获取单个账号

```dart
final account = await client.adminAccounts.fetchById('12345');
print(account.ip);
print(account.confirmed);
```

### 审批与拒绝待审核账号

```dart
await client.adminAccounts.approve('12345');
await client.adminAccounts.reject('12345');
```

### 执行处置操作

```dart
await client.adminAccounts.performAction(
  '12345',
  MastodonAdminAccountActionRequest(
    type: 'suspend',
    reportId: '999',
    text: 'Violated community guidelines.',
    sendEmailNotification: true,
  ),
);
```

相关未处理的举报会被自动标记为已解决。需要"管理用户"和"管理举报"权限。

### 其他处置方法

```dart
await client.adminAccounts.enable('12345');       // 重新启用已停用账号
await client.adminAccounts.unsilence('12345');    // 解除静默
await client.adminAccounts.unsuspend('12345');    // 解除封禁
await client.adminAccounts.unsensitive('12345'); // 移除敏感标记
```

### 删除账号数据

```dart
await client.adminAccounts.delete('12345');
```

永久删除已封禁账号的数据。需要"删除用户数据"权限。

## 举报管理

`client.adminReports` 管理用户提交的滥用举报。

### 列出举报

```dart
final page = await client.adminReports.fetch(
  resolved: false,  // 仅列出未处理举报
  limit: 100,
);
```

可通过 `accountId`（举报人）或 `targetAccountId`（被举报账号）过滤。使用 `resolved: true` 显示已处理举报。分页通过 `maxId`、`sinceId`、`minId` 实现。

### 获取与更新单条举报

```dart
final report = await client.adminReports.fetchById('42');

final updated = await client.adminReports.update(
  '42',
  MastodonAdminReportUpdateRequest(assignedAccountId: 'moderator-id'),
);
```

### 分配与解决

```dart
await client.adminReports.assignToSelf('42');
await client.adminReports.unassign('42');
await client.adminReports.resolve('42');
await client.adminReports.reopen('42'); // 重新打开已解决举报
```

## 域名管理

### 允许域名列表

对于运行在白名单模式下的服务器，`client.adminDomainAllows` 控制哪些远程域名被允许联合。

```dart
// 列出已允许域名
final page = await client.adminDomainAllows.fetch();

// 允许一个域名
final entry = await client.adminDomainAllows.create(domain: 'example.social');

// 移除已允许域名
await client.adminDomainAllows.delete(entry.id);
```

### 域名屏蔽列表

`client.adminDomainBlocks` 管理对远程域名的联合屏蔽。

```dart
// 列出已屏蔽域名
final page = await client.adminDomainBlocks.fetch();

// 屏蔽一个域名
final block = await client.adminDomainBlocks.create(
  MastodonAdminDomainBlockRequest(
    domain: 'spam.example',
    severity: 'suspend',
    rejectMedia: true,
    rejectReports: true,
    privateComment: 'Known spam instance',
    publicComment: 'Suspended for spam.',
  ),
);

// 更新屏蔽
await client.adminDomainBlocks.update(block.id, updatedRequest);

// 删除屏蔽
await client.adminDomainBlocks.delete(block.id);
```

## IP 屏蔽

`client.adminIpBlocks` 管理 IP 地址段屏蔽。

```dart
// 列出 IP 屏蔽
final page = await client.adminIpBlocks.fetch();

// 创建 IP 屏蔽
final block = await client.adminIpBlocks.create(
  MastodonAdminIpBlockCreateRequest(
    ip: '192.0.2.0/24',
    severity: 'no_access',
    comment: 'Abusive subnet',
  ),
);

// 更新
await client.adminIpBlocks.update(
  block.id,
  MastodonAdminIpBlockUpdateRequest(severity: 'sign_up_block'),
);

// 删除
await client.adminIpBlocks.delete(block.id);
```

## 邮件屏蔽

### 规范化邮件屏蔽

`client.adminCanonicalEmailBlocks` 屏蔽规范化（canonical）邮件地址，防止用户使用被屏蔽邮件的变体重新注册。

```dart
// 列出屏蔽
final page = await client.adminCanonicalEmailBlocks.fetch();

// 测试某邮件是否匹配已有屏蔽规则
final matches = await client.adminCanonicalEmailBlocks.test(
  email: 'test@example.com',
);

// 通过邮件地址屏蔽（规范化哈希由服务端计算）
final block = await client.adminCanonicalEmailBlocks.create(
  email: 'spammer@example.com',
);

// 或通过预计算的哈希值屏蔽
await client.adminCanonicalEmailBlocks.create(
  canonicalEmailHash: 'sha256hashvalue',
);

// 删除
await client.adminCanonicalEmailBlocks.delete(block.id);
```

### 邮件域名屏蔽

`client.adminEmailDomainBlocks` 禁止整个邮件域名注册。

```dart
// 列出已屏蔽邮件域名
final page = await client.adminEmailDomainBlocks.fetch();

// 屏蔽一个域名
final block = await client.adminEmailDomainBlocks.create(
  domain: 'disposable-mail.example',
);

// 删除
await client.adminEmailDomainBlocks.delete(block.id);
```

## 管理标签

`client.adminTags` 提供对话题标签的管理控制。

### 列出与获取标签

```dart
final page = await client.adminTags.fetch(limit: 50);
final tag = await client.adminTags.fetchById('tag-id');
```

### 更新标签

```dart
final updated = await client.adminTags.update(
  'tag-id',
  displayName: 'Dart',
  listable: true,
  trendable: true,
  usable: true,
);
```

所有字段均为可选，只有提供的字段才会被更新。`listable` 控制标签是否出现在公开列表中，`trendable` 控制是否参与趋势端点，`usable` 控制是否可以在帖子中使用。

## 管理趋势

`client.adminTrends` 提供对未审核趋势内容的访问，并允许在公开展示前进行审批或拒绝。

### 趋势链接

```dart
final links = await client.adminTrends.fetchLinks();
await client.adminTrends.approveLink(id: links.first.id);
await client.adminTrends.rejectLink(id: links.first.id);
```

### 链接发布者

```dart
final publishers = await client.adminTrends.fetchPublishers();
await client.adminTrends.approvePublisher(id: publishers.first.id);
await client.adminTrends.rejectPublisher(id: publishers.first.id);
```

### 趋势帖子

```dart
final statuses = await client.adminTrends.fetchStatuses();
await client.adminTrends.approveStatus(id: statuses.first.id);
await client.adminTrends.rejectStatus(id: statuses.first.id);
```

### 趋势标签

```dart
final tags = await client.adminTrends.fetchTags();
await client.adminTrends.approveTag(id: tags.first.id);
await client.adminTrends.rejectTag(id: tags.first.id);
```

读取端点需要 `admin:read` scope；写入端点需要 `admin:write`。

## 指标、维度与留存

这三个数据分析端点均使用 `POST` 请求，通过请求体指定查询的指标和日期范围。

### 指标（量化数据）

```dart
final measures = await client.adminMeasures.fetch(
  MastodonAdminMeasureRequest(
    keys: ['active_users', 'new_users'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
for (final m in measures) {
  print('${m.key}: ${m.total}');
}
```

返回活跃用户数、新注册用户数、互动数量等时间序列数据。

### 维度（定性数据）

```dart
final dimensions = await client.adminDimensions.fetch(
  MastodonAdminDimensionRequest(
    keys: ['languages', 'sources'],
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 1, 31),
  ),
);
```

返回语言分布、客户端软件版本等分类统计数据。

### 留存（群组数据）

```dart
final cohorts = await client.adminRetention.fetch(
  MastodonAdminRetentionRequest(
    startAt: DateTime(2025, 1, 1),
    endAt: DateTime(2025, 3, 31),
    frequency: 'month',
  ),
);
```

返回按注册时间分组、按后续活跃情况统计的用户留存群组数据。三个数据分析端点均需要 `admin:read` OAuth scope。
