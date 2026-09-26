---
sidebar_position: 4
---

# 错误处理

本库将 Mastodon API 错误映射到以 `MastodonException` 为根节点的 sealed class 层级结构。

## 异常层级

```
MastodonException (sealed)
├── MastodonApiException              // 通用 HTTP 响应错误
│   ├── MastodonUnauthorizedException // 401 - 认证错误
│   ├── MastodonForbiddenException    // 403 - 权限错误
│   ├── MastodonNotFoundException     // 404 - 资源不存在
│   ├── MastodonRateLimitException    // 429 - 触发频率限制
│   │   ├── retryAfter                //   建议等待时长
│   │   ├── limit                     //   限制周期内的请求上限
│   │   ├── remaining                 //   剩余请求数
│   │   └── resetAt                   //   限制重置时间
│   ├── MastodonValidationException   // 422 - 校验错误
│   │   ├── serverMessage             //   服务器详细错误信息
│   │   ├── details                   //   按请求字段分组的错误
│   │   └── MastodonAlreadyVotedException // 已投过票
│   └── MastodonServerException       // 5xx - 服务器错误
├── MastodonNetworkException          // 网络连接错误
└── MastodonAuthException (sealed)    // OAuth 认证流程错误
    ├── MastodonAuthCancelledException    // 用户取消
    ├── MastodonAuthStateMismatchException // 检测到 CSRF
    └── MastodonAuthTokenException        // token 获取失败
```

## 基本捕获模式

### 捕获所有错误

```dart
try {
  final status = await client.statuses.fetch(id);
} on MastodonException catch (e) {
  print('Error: $e');
}
```

### 按 HTTP 状态码处理

```dart
try {
  final account = await client.accounts.fetchById(accountId);
} on MastodonNotFoundException {
  print('账号不存在');
} on MastodonUnauthorizedException {
  print('token 无效，请重新认证');
} on MastodonRateLimitException catch (e) {
  print('触发频率限制，请在 ${e.retryAfter} 后重试');
} on MastodonApiException catch (e) {
  print('API 错误 (${e.statusCode}): ${e.message}');
} on MastodonNetworkException {
  print('请检查网络连接');
}
```

### 获取校验错误详情

```dart
try {
  await client.accounts.create(request);
} on MastodonValidationException catch (e) {
  print('校验错误: ${e.serverMessage}');
  final details = e.details;
  if (details != null) {
    for (final entry in details.entries) {
      for (final detail in entry.value) {
        print('${entry.key}: ${detail.code} - ${detail.description ?? ''}');
      }
    }
  }
}
```

`details` 是以请求字段为键的 Map。每个 `MastodonValidationErrorDetail`
都包含服务器返回的错误代码和可选说明。未知代码也会以字符串形式保留，以便
保持向前兼容。如果端点未返回 Mastodon 可识别的校验详情结构，`details` 为
`null`。

## 特殊异常

### MastodonAlreadyVotedException

当尝试对已投过票的投票再次投票时抛出。

```dart
try {
  await client.polls.vote(pollId, [0]);
} on MastodonAlreadyVotedException {
  print('已经投过票了');
}
```

## 处理频率限制

`MastodonRateLimitException` 会公开 Mastodon 的 `X-RateLimit-*` 响应头。
建议等待时长会优先使用服务器或代理提供的 `Retry-After`，否则使用
`X-RateLimit-Reset` 时间戳。

```dart
Future<T> withRetry<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on MastodonRateLimitException catch (e) {
    print('剩余 ${e.remaining}/${e.limit} 次请求；${e.resetAt} 重置');
    final wait = e.retryAfter ?? const Duration(seconds: 60);
    await Future<void>.delayed(wait);
    return action();
  }
}

// 用法
final timeline = await withRetry(
  () => client.timelines.fetchHome(limit: 20),
);
```
