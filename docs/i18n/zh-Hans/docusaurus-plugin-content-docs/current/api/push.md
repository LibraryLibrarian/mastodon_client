---
sidebar_position: 8
---

# 推送通知

`client.push` API 管理 Web Push 订阅。它遵循 [Web Push 协议](https://www.rfc-editor.org/rfc/rfc8030)，允许应用在后台接收通知。

## 订阅

通过提供推送端点和 VAPID 密钥，创建新的 Web Push 订阅：

```dart
final subscription = await client.push.create(
  MastodonPushSubscriptionRequest(
    endpoint: 'https://push.example.com/subscription/abc123',
    p256dh: '<Base64url-encoded P-256 ECDH public key>',
    auth: '<Base64url-encoded authentication secret>',
    standard: true,
    alerts: MastodonPushAlertSettings(
      mention: true,
      follow: true,
      reblog: true,
      favourite: true,
      poll: true,
    ),
    policy: 'followed', // all | followed | follower | none
  ),
);

print(subscription.id);
print(subscription.serverKey); // 用于验证收到的推送消息
```

### 通知类型

`MastodonPushAlertSettings` 接受以下字段的任意组合。值为 `null` 的字段会从请求中省略，保持原有设置不变。

| 字段 | 说明 |
|------|------|
| `mention` | 在帖子中被提及 |
| `quote` | 帖子被引用 |
| `status` | 所关注用户发布了新帖子 |
| `reblog` | 帖子被转嘟 |
| `follow` | 新关注者 |
| `followRequest` | 新的关注请求 |
| `favourite` | 帖子被收藏 |
| `poll` | 参与或创建的投票已结束 |
| `update` | 互动过的帖子被编辑 |
| `quotedUpdate` | 被引用的帖子被编辑 |
| `adminSignUp` | 新用户注册（仅管理员） |
| `adminReport` | 新举报（仅管理员） |

### 策略值

| 值 | 说明 |
|----|------|
| `all` | 接收所有用户的通知 |
| `followed` | 仅接收所关注用户的通知 |
| `follower` | 仅接收关注者的通知 |
| `none` | 禁用所有推送通知 |

## 获取当前订阅

```dart
final subscription = await client.push.fetch();
print(subscription.endpoint);
print(subscription.alerts.mention);
print(subscription.policy);
```

## 更新通知设置

使用 `update` 更改通知设置或策略，无需重新创建订阅。只能更改 `data` 部分（通知类型和策略）。

```dart
final updated = await client.push.update(
  MastodonPushSubscriptionUpdateRequest(
    alerts: MastodonPushAlertSettings(
      mention: true,
      follow: false,
    ),
    policy: 'all',
  ),
);
```

## 取消订阅

```dart
await client.push.delete();
```

删除当前 Web Push 订阅。之后调用 `fetch` 将抛出 `MastodonNotFoundException`。

## MastodonWebPushSubscription 模型

| 字段 | 类型 | 说明 |
|------|------|------|
| `id` | `String` | 订阅 ID |
| `endpoint` | `String` | 推送端点 URL |
| `serverKey` | `String` | 用于验证推送消息的服务器公钥 |
| `alerts` | `MastodonPushAlerts` | 已启用的通知设置 |
| `policy` | `String` | 通知策略 |
| `standard` | `bool?` | 订阅是否符合标准化 Web Push 规范（Mastodon 4.4+） |
