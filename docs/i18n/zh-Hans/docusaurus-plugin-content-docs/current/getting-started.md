---
sidebar_position: 1
slug: /
---

# 快速开始

mastodon_client 是一个纯 Dart 编写的 Mastodon API 客户端库。
它可以在任何支持 Dart 的环境中运行：Flutter、服务端 Dart、CLI 工具等。

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  mastodon_client: ^0.0.1
```

然后拉取依赖：

```bash
dart pub get
```

## 基本用法

### 初始化客户端

```dart
import 'package:mastodon_client/mastodon_client.dart';

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_access_token',
);
```

`baseUrl` 必须包含协议头（例如 `https://`）。
如果只使用不需要认证的端点，可以省略 `accessToken`。

### 第一个 API 调用

获取服务器信息（无需认证）：

```dart
final instance = await client.instance.fetch();
print(instance.title);       // 服务器名称
print(instance.description); // 服务器描述
```

获取已认证用户的账号信息：

```dart
final me = await client.accounts.verifyCredentials();
print(me.displayName); // 显示名称
print(me.acct);        // 用户名
```

### API 结构

所有 API 都作为 `MastodonClient` 的属性暴露，用于命名空间隔离：

```dart
client.accounts      // 账号操作
client.statuses      // 帖子操作
client.timelines     // 时间线获取
client.notifications // 通知操作
client.media         // 媒体上传
client.search        // 搜索
client.oauth         // OAuth token 操作
// ... 以及更多
```

### 控制日志输出

HTTP 请求/响应日志默认输出到 stdout。

```dart
// 禁用日志
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);

// 使用自定义 logger
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: FunctionLogger((level, message) {
    // Your custom log handling
  }),
);
```

详情请参阅 [日志](./advanced/logging.md)。

## 下一步

- [认证](./authentication.md) — 通过 OAuth 获取 access token
- [分页](./pagination.md) — 基于游标的分页
- [错误处理](./error-handling.md) — 异常层级与捕获模式
