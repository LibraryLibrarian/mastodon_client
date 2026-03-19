---
sidebar_position: 13
---

# 其他 API

本页介绍定时帖子、趋势、个人资料图片管理、应用注册、邮件确认以及异步刷新状态等 API。

## 定时帖子

使用 `client.scheduledStatuses` 管理排队等待发布的帖子。创建定时帖子时，在调用 `client.statuses.create` 时传入 `scheduledAt` 参数即可。

### 列出定时帖子

```dart
final page = await client.scheduledStatuses.fetch(limit: 20);
for (final s in page.items) {
  print('${s.id} scheduled for ${s.scheduledAt}');
}

// 分页
if (page.nextMaxId != null) {
  final next = await client.scheduledStatuses.fetch(maxId: page.nextMaxId);
}
```

返回 `MastodonPage<MastodonScheduledStatus>`。默认限制 20 条，最大 40 条。

### 获取单条定时帖子

```dart
final s = await client.scheduledStatuses.fetchById('9876');
```

### 重新设置时间

新时间必须至少为未来 5 分钟，并应使用 ISO 8601 格式提供：

```dart
final updated = await client.scheduledStatuses.update(
  '9876',
  scheduledAt: '2025-12-31T23:59:00.000Z',
);
```

### 取消

```dart
await client.scheduledStatuses.delete('9876');
```

## 趋势

所有趋势接口均为公开接口，无需认证。使用 `client.trends`。

### 热门标签

```dart
final tags = await client.trends.fetchTags(limit: 10);
for (final tag in tags) {
  print('#${tag.name}');
}
```

返回过去一周内使用量上升的标签，按内部趋势分值排序。默认限制 10 条，最大 20 条。使用 `offset` 进行分页。

### 热门帖子

```dart
final statuses = await client.trends.fetchStatuses(limit: 20);
```

返回近期互动量明显高于平均水平的帖子。默认限制 20 条，最大 40 条。

### 热门链接

```dart
final links = await client.trends.fetchLinks(limit: 10);
for (final link in links) {
  print(link.url);
}
```

返回在网络中被频繁分享的链接。默认限制 10 条，最大 20 条。

三个方法均接受 `offset` 参数用于偏移量分页。

## 个人资料图片管理

`client.profile` 允许移除个人资料头像和横幅图片。

### 删除头像

```dart
final account = await client.profile.deleteAvatar();
```

### 删除横幅

```dart
final account = await client.profile.deleteHeader();
```

两个方法均返回更新后的 `MastodonCredentialAccount`，即使当前未设置图片也会成功执行。需要 `write:accounts` OAuth scope。

上传新头像或横幅请使用 `client.accounts.updateCredentials`。

## 应用注册

使用 `client.apps` 进行 OAuth 应用注册和 token 验证。

### 注册应用

```dart
final app = await client.apps.create(
  clientName: 'My Mastodon App',
  redirectUris: ['myapp://oauth/callback'],
  scopes: 'read write push',
  website: 'https://example.com',
);
print(app.clientId);
print(app.clientSecret);
```

`redirectUris` 为必填项。带外流程传入 `['urn:ietf:wg:oauth:2.0:oob']`。省略 `scopes` 时默认为 `read`。返回 `MastodonCredentialApplication`。

### 验证应用凭证

```dart
final app = await client.apps.verifyCredentials();
print(app.name);
```

返回 `MastodonApplication`。token 无效时抛出认证错误。

## 邮件确认

`client.emails` 处理新注册账号的确认邮件重发。

### 重发确认邮件

```dart
await client.emails.resendConfirmation();

// 可同时更新邮件地址
await client.emails.resendConfirmation(email: 'new@example.com');
```

提供 `email` 时，会在发送确认邮件前先更新未确认的邮件地址。

### 检查确认状态

```dart
await client.emails.checkConfirmation();
```

两个方法都需要使用创建未确认账号的客户端所获取的 token。

## 异步刷新

`client.asyncRefreshes` 允许查询后台刷新任务的进度。这是 Mastodon 4.4.0 中新增的实验性 API。

当响应中包含 `Mastodon-Async-Refresh` 请求头时，其值为可轮询的 ID，直到操作完成：

```dart
final refresh = await client.asyncRefreshes.fetch('refresh-id-from-header');
print(refresh.complete); // 完成时为 true
```

返回 `MastodonAsyncRefresh`。需要 `read` OAuth scope。
