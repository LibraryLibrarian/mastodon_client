[English](README.md) | [日本語](README.ja.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [한국어](README.ko.md)

# mastodon_client

纯 Dart 实现的 [Mastodon](https://joinmastodon.org/) API 客户端库。提供对所有主要 API 类别的类型化访问，内置 OAuth 支持、基于游标的分页以及结构化的错误处理。

## 功能特性

- 覆盖所有主要 Mastodon API 类别（账户、嘟文、时间线、通知、媒体等）
- OAuth 2.0 令牌管理（获取、吊销、PKCE 支持）
- 通过 `MastodonPage<T>` 实现基于游标的分页
- 用于穷举式错误处理的 sealed 异常层级
- 支持自动 v2/v1 降级和处理轮询的异步媒体上传
- 通过可替换的 `Logger` 接口实现可配置的日志记录
- 纯 Dart 实现 — 不依赖 Flutter

## 安装

在 `pubspec.yaml` 中添加包：

```yaml
dependencies:
  mastodon_client: ^0.0.1
```

然后运行：

```
dart pub get
```

## 快速开始

```dart
import 'package:mastodon_client/mastodon_client.dart';

void main() async {
  final client = MastodonClient(
    baseUrl: 'https://mastodon.social',
    accessToken: 'YOUR_ACCESS_TOKEN',
  );

  // Fetch the authenticated user
  final me = await client.accounts.verifyCredentials();
  print(me.displayName);

  // Post a status
  await client.statuses.create(
    MastodonStatusCreateRequest(
      status: 'Hello from mastodon_client!',
      visibility: MastodonVisibility.public,
    ),
  );

  // Paginated home timeline
  final page = await client.timelines.fetchHome(limit: 20);
  for (final status in page.items) {
    print(status.content);
  }
}
```

## API 概览

`MastodonClient` 公开以下属性，每个属性覆盖 Mastodon API 的不同领域：

| 属性 | 说明 |
|---|---|
| `accounts` | 账户信息、搜索、关注、屏蔽、隐藏、个人资料更新 |
| `statuses` | 创建、编辑、删除嘟文，转嘟、收藏、书签、置顶、翻译 |
| `timelines` | 主页、本站、跨站、话题标签、列表时间线 |
| `notifications` | 通知、策略、请求（v1 + 分组 v2） |
| `media` | 上传（v2/v1 降级）、异步处理、更新、删除 |
| `search` | 账户、嘟文、话题标签（偏移量＋游标分页） |
| `filters` | 包含关键词和嘟文条目的 v2 CRUD（+ 已废弃的 v1） |
| `lists` | 列表的 CRUD 和账户管理 |
| `oauth` | 令牌获取/吊销、服务器元数据、用户信息 |
| `apps` | 应用程序注册和验证 |
| `instance` | 服务器信息（v1/v2）、节点、活动、规则、域名屏蔽 |
| `customEmojis` | 自定义表情符号列表 |
| `announcements` | 服务器公告和反应 |
| `conversations` | 私信会话 |
| `polls` | 投票获取与投票操作 |
| `push` | Web Push 订阅管理 |
| `tags` | 话题标签信息、关注/取消关注 |
| `trends` | 热门话题标签、嘟文、链接 |
| `blocks` | 已屏蔽账户列表 |
| `mutes` | 已隐藏账户列表 |
| `domainBlocks` | 用户级域名屏蔽管理 |
| `reports` | 举报创建 |
| `followRequests` | 关注请求管理 |
| `suggestions` | 关注建议 |
| `favourites` | 已收藏嘟文列表 |
| `bookmarks` | 已书签嘟文列表 |
| `endorsements` | 推荐账户列表 |
| `featuredTags` | 精选标签管理 |
| `followedTags` | 已关注标签列表 |
| `directory` | 个人资料目录 |
| `preferences` | 用户偏好设置 |
| `markers` | 时间线已读位置标记 |
| `scheduledStatuses` | 定时嘟文管理 |
| `health` | 服务器健康检查 |
| `profile` | 头像/头图管理 |
| `groupedNotifications` | 分组通知（v2） |
| `adminAccounts` | 管理员账户管理 |
| `adminReports` | 管理员举报管理 |
| `adminDomainBlocks` | 管理员域名屏蔽管理 |
| `adminDomainAllows` | 管理员域名允许管理 |
| `adminIpBlocks` | 管理员 IP 屏蔽管理 |
| `adminCanonicalEmailBlocks` | 管理员规范邮件屏蔽管理 |
| `adminEmailDomainBlocks` | 管理员邮件域名屏蔽管理 |
| `adminTags` | 管理员标签管理 |
| `adminTrends` | 管理员热门趋势管理 |
| `adminMeasures` | 管理员定量指标 |
| `adminDimensions` | 管理员分类维度 |
| `adminRetention` | 管理员用户留存队列 |

## 认证

Mastodon 使用 OAuth 2.0。注册应用程序，将用户重定向至授权页面，然后用授权码换取令牌：

```dart
// 1. Register your app
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

// 2. Direct the user to the authorization URL (platform-dependent)

// 3. Exchange the authorization code for a token
final token = await client.oauth.obtainToken(
  grantType: 'authorization_code',
  clientId: app.clientId!,
  clientSecret: app.clientSecret!,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  code: authorizationCode,
);

// 4. Create a new client with the token
final authedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## 错误处理

所有异常均继承自 sealed 类 `MastodonException`，支持穷举式模式匹配：

```dart
try {
  final user = await client.accounts.fetchById('abc123');
} on MastodonUnauthorizedException {
  // 401 — token invalid or expired
} on MastodonForbiddenException {
  // 403 — operation not permitted
} on MastodonNotFoundException {
  // 404 — resource not found
} on MastodonRateLimitException catch (e) {
  // 429 — rate limited; check e.retryAfter
} on MastodonValidationException {
  // 422 — invalid request body
} on MastodonServerException {
  // 5xx — server-side error
} on MastodonNetworkException {
  // Timeout, connection refused, etc.
}
```

## 日志记录

通过 `enableLog` 启用内置的 stdout 日志记录器，或提供自定义的 `Logger` 实现：

```dart
class MyLogger implements Logger {
  @override void debug(String message) { /* ... */ }
  @override void info(String message)  { /* ... */ }
  @override void warn(String message)  { /* ... */ }
  @override void error(String message, [Object? error, StackTrace? stackTrace]) { /* ... */ }
}

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  logger: MyLogger(),
);
```

## 文档

- API 参考：https://librarylibrarian.github.io/mastodon_client/
- pub.dev 页面：https://pub.dev/packages/mastodon_client
- GitHub：https://github.com/LibraryLibrarian/mastodon_client

## 许可证

参见 [LICENSE](LICENSE)。
