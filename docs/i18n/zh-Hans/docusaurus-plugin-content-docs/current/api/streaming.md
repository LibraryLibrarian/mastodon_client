---
sidebar_position: 15
---

# 流式传输

`client.streaming` API 通过 Mastodon 的流式 API（WebSocket）提供实时更新。所有订阅都多路复用到单个连接上，因此订阅多个频道不会打开多个套接字。

访问 `client.streaming` 本身不会建立连接。只有调用 `connect()` 时才会打开套接字，所以仅使用 REST 的应用不会通过此 API 产生任何网络通信。

## 建立连接

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
);

await client.streaming.connect();
```

端点会自动解析。客户端先读取 `GET /api/v2/instance` 的 `configuration.urls.streaming`，若不存在则回退到 `GET /api/v1/instance` 的 `urls.streaming_api`，最后复用 REST 主机。解析出的值会被规范化：`http` 转为 `ws`，`https` 转为 `wss`，端口保留，缺少 `/api/v1/streaming` 时会自动补全。

包括公共频道在内，流式传输始终需要访问令牌。匿名访问已在 Mastodon v4.2.0 中移除。

## 订阅

```dart
final home = await client.streaming.subscribe(const MastodonStream.user());

home.events.listen((event) {
  switch (event) {
    case MastodonUpdateEvent(:final status):
      print(status.content);
    case MastodonStatusUpdateEvent(:final status):
      print('已编辑: ${status.id}');
    case MastodonDeleteEvent(:final statusId):
      print('已删除: $statusId');
    case MastodonNotificationEvent(:final notification):
      print(notification.type);
    case MastodonUnknownStreamEvent(:final event):
      print('未知事件: $event');
    default:
      break;
  }
});

await home.cancel();
```

每个订阅句柄提供三个层次：

| 属性 | 类型 | 内容 |
|---|---|---|
| `events` | `Stream<MastodonStreamEvent>` | 类型化的 sealed 事件 |
| `statuses` | `Stream<MastodonStatus>` | 来自 `update` 和 `status.update` 的嘟文 |
| `messages` | `Stream<MastodonStreamingMessage>` | payload 未解码的原始信封 |

## 频道

频道由 sealed 的 `MastodonStream` 类型描述。

| 工厂方法 | 协议名称 |
|---|---|
| `MastodonStream.user()` | `user` |
| `MastodonStream.userNotification()` | `user:notification` |
| `MastodonStream.public()` | `public` |
| `MastodonStream.public(local: true)` | `public:local` |
| `MastodonStream.public(remote: true)` | `public:remote` |
| `MastodonStream.public(onlyMedia: true)` | `public:media` |
| `MastodonStream.public(local: true, onlyMedia: true)` | `public:local:media` |
| `MastodonStream.public(remote: true, onlyMedia: true)` | `public:remote:media` |
| `MastodonStream.hashtag('dart')` | `hashtag` |
| `MastodonStream.hashtag('dart', local: true)` | `hashtag:local` |
| `MastodonStream.list('42')` | `list` |
| `MastodonStream.direct()` | `direct` |

`local` 和 `remote` 不能同时为 true。服务器上不存在这样的频道，因此该组合会被断言拒绝。

对于本库未建模的频道（例如 Mastodon 分支新增的频道），请使用 `subscribeRaw`：

```dart
final raw = await client.streaming.subscribeRaw('someCustomStream');
raw.messages.listen((message) => print(message.payload));
```

## 引用计数

Mastodon 会静默忽略对已订阅频道的第二次 `subscribe`，因此客户端维护了引用计数。计数从 0 变为 1 时发送 `subscribe`，回到 0 时发送 `unsubscribe`。

为此话题标签的键会被规范化为小写。若不规范化，同时订阅 `Dart` 和 `dart` 会在服务器端发生冲突，导致第二个订阅者收不到事件。

```dart
final a = await client.streaming.subscribe(const MastodonStream.hashtag('Dart'));
final b = await client.streaming.subscribe(const MastodonStream.hashtag('dart'));

await a.cancel(); // b 仍然有效，暂不发送 unsubscribe
await b.cancel(); // 此时才发送 unsubscribe
```

## 错误

订阅成功不会返回确认，而服务器的错误既不含频道名也不含关联 ID。因此订阅帧会串行发送，并将随后静默窗口内到达的错误归因于最近一次请求。

```dart
try {
  await client.streaming.subscribe(const MastodonStream.list('999'));
} on MastodonStreamingSubscriptionException catch (e) {
  print('${e.message} (${e.status})');
}
```

`MastodonStreamingSubscriptionException.status` 可为空，因为服务器在 `unsubscribe` 的错误中不包含 `status`。

连接级别的失败表现为 `MastodonStreamingConnectionException`，意外断开表现为 `MastodonStreamingClosedException`。若倾向于观察而非捕获，二者也会发送到 `client.streaming.errors`。

## 重连与生命周期

重连会自动进行，采用指数退避加抖动，上限由 `MastodonStreamingConfig.reconnectMaxDelay` 限制。由于订阅状态依附于连接，替代连接可用后会重新发送所有活动订阅。

不同的关闭码处理方式不同：

| 关闭码 | 行为 |
|---|---|
| `1000` | 正常关闭。不重连。 |
| `1003` | 服务器拒绝了二进制帧。报告为错误且不重试。 |
| `1005` | 没有关闭帧。可能意味着令牌已失效，因此不会盲目重试。 |
| 其他 | 退避后重连。 |

握手期间的 HTTP 401 会立即抛出而不进入重试循环，因为使用无效令牌重试不可能成功。

应用进入或离开后台时请使用 `suspend()` 和 `resume()`，并用 `dispose()` 释放资源：

```dart
await client.streaming.suspend();
await client.streaming.resume();

await client.dispose();
```

`MastodonClient.dispose()` 会关闭流式连接和 HTTP 传输。如果从未使用过流式功能，它不会为此创建流式客户端。

## 配置

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
  streamingConfig: MastodonStreamingConfig(
    authMode: MastodonStreamingAuthMode.subprotocol,
    pingInterval: Duration(seconds: 30),
    reconnectMaxDelay: Duration(seconds: 30),
    reconnectJitter: 0.2,
  ),
);
```

支持三种认证方式。默认的 `subprotocol` 将令牌作为唯一的 WebSocket 子协议发送；它在包括 Web 在内的所有平台上都可用，并且不会把令牌留在访问日志中。`header` 需要 `dart:io`，而 `queryParameter` 是会在 URL 中暴露令牌的旧方式。保持 `enableAuthFallback` 启用时，失败后会依次尝试其余方式，并在后续重连中优先使用成功的方式。日志输出中的令牌始终会被脱敏。

## 注意事项

以下行为源自 Mastodon 流式服务器本身，经常被误认为是客户端缺陷。

- 仅具有 `read:statuses` 的令牌可以在 `user` 上接收主页嘟文，但完全收不到通知，而且不会报错。通知需要 `read` 或 `read:notifications`。
- `only_media` 在 WebSocket 上会被忽略。只看媒体必须通过频道名来选择。
- 同时订阅 `user` 和 `user:notification` 会使每条通知收到两次，因为服务器将二者视为不同的频道集合。仅订阅 `user` 即可。
- 公共和话题标签频道上的 `update` 与 `status.update` 可能因语言偏好、信息流访问设置（Mastodon v4.5 及以后）、屏蔽、静音和域名屏蔽而被静默丢弃。公共流保持安静未必意味着出错。
- `filters_changed` 虽然定义为事件类型，但在 Mastodon v4.3 及以后不会送达客户端，因为服务器会丢弃没有 payload 的消息。
- 套接字断开期间产生的事件在重连后不会重放。请通过 REST 的 `since_id` 或 `min_id` 补齐缺口。

## 健康检查

流式进程有自己的健康检查端点，返回纯文本而非 JSON：

```dart
final healthy = await client.health.checkStreaming();
```
