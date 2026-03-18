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
│   │   └── retryAfter                //   建议等待时长
│   ├── MastodonValidationException   // 422 - 校验错误
│   │   ├── serverMessage             //   服务器详细错误信息
│   │   └── MastodonAlreadyVotedException // 已投过票
│   └── MastodonServerException       // 5xx - 服务器错误
├── MastodonNetworkException          // 网络连接错误
├── MastodonAuthException (sealed)    // OAuth 认证流程错误
│   ├── MastodonAuthCancelledException    // 用户取消
│   ├── MastodonAuthStateMismatchException // 检测到 CSRF
│   └── MastodonAuthTokenException        // token 获取失败
└── MastodonMediaProcessingTimeoutException // 媒体处理超时
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
  await client.statuses.create(request);
} on MastodonValidationException catch (e) {
  print('校验错误: ${e.serverMessage}');
}
```

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

### MastodonMediaProcessingTimeoutException

当上传后异步媒体处理超时时抛出。

```dart
try {
  final attachment = await client.media.upload(bytes, 'photo.jpg');
} on MastodonMediaProcessingTimeoutException catch (e) {
  print('媒体 ${e.mediaId} 处理超时');
  // 稍后通过 client.media.fetchById(e.mediaId) 查询状态
}
```

## 处理频率限制

```dart
Future<T> withRetry<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on MastodonRateLimitException catch (e) {
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
