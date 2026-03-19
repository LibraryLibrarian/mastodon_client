---
sidebar_position: 2
---

# 认证

Mastodon 使用 OAuth 2.0。大多数 API 端点都需要 access token。

## 认证流程概览

```
1. 注册应用   → 获取 client_id / client_secret
2. 用户授权   → 打开浏览器授权页面 → 获取授权码
3. 获取 token → 用授权码换取 access token
```

## 第一步：注册应用

```dart
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

final clientId = app.clientId!;
final clientSecret = app.clientSecret!;
```

将 `urn:ietf:wg:oauth:2.0:oob` 作为重定向 URI，可以启用 OOB（带外）流程，将授权码显示在屏幕上。对于 Web 或移动端应用，请改用回调 URL。

## 第二步：用户授权

在浏览器中打开授权 URL，提示用户进行授权。此步骤与平台相关，不在本库的范围内。

```dart
// 构建授权 URL
final authorizeUrl = Uri.parse('${baseUrl}/oauth/authorize').replace(
  queryParameters: {
    'client_id': clientId,
    'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob',
    'response_type': 'code',
    'scope': 'read write push',
  },
);
// → 在浏览器中打开此 URL
```

用户授权后，将返回授权码。

## 第三步：获取 access token

```dart
final token = await client.oauth.obtainToken(
  grantType: 'authorization_code',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  code: authorizationCode, // 第二步中获取的授权码
);

print(token.accessToken); // 用于 API 调用的 token
```

使用获取的 token 初始化新客户端：

```dart
final authenticatedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## 撤销 token

```dart
await client.oauth.revokeToken(
  clientId: clientId,
  clientSecret: clientSecret,
  token: accessToken,
);
```

## 客户端凭证

在无需用户交互的情况下获取仅限应用的 token：

```dart
final token = await client.oauth.obtainToken(
  grantType: 'client_credentials',
  clientId: clientId,
  clientSecret: clientSecret,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  scope: 'read',
);
```

此 token 只能访问公开信息。

## 服务器元数据

你可以提前获取服务器支持的 scope 和端点列表：

```dart
final metadata = await client.oauth.fetchServerMetadata();
print(metadata.scopesSupported);
```

## 权限范围

| Scope | 说明 |
|-------|------|
| `read` | 所有读取操作 |
| `write` | 所有写入操作 |
| `push` | 接收 Web Push 通知 |
| `follow` | 修改关注关系（等同于 `read:follows` + `write:follows`） |
| `admin:read` | 管理员读取操作 |
| `admin:write` | 管理员写入操作 |

也可以使用更细粒度的 scope，如 `read:accounts`、`write:statuses` 等。
详情请参阅 [Mastodon 官方文档](https://docs.joinmastodon.org/api/oauth-scopes/)。
