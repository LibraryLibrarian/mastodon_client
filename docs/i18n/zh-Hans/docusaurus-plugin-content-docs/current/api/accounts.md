---
sidebar_position: 1
---

# 账号

`client.accounts` API 提供账号信息的获取与管理操作。

## 获取账号

### 通过 ID 获取

```dart
final account = await client.accounts.fetchById('12345');
print(account.displayName);
print(account.followersCount);
```

### 通过用户名（acct）获取

```dart
final account = await client.accounts.lookup('user@mastodon.social');
```

如果服务器不支持 lookup 接口，本库会自动回退到基于搜索的查找方式。

### 当前用户

```dart
final me = await client.accounts.verifyCredentials();
print(me.source); // 仅认证用户可获取的附加字段
```

### 批量获取账号

```dart
final accounts = await client.accounts.fetchMultiple(['1', '2', '3']);
```

### 搜索账号

```dart
final results = await client.accounts.search(
  'keyword',
  limit: 10,
  resolve: true, // 通过 WebFinger 解析远程账号
);
```

## 社交关系

### 关注者与关注

两者都返回支持分页的 `MastodonPage<MastodonAccount>`。

```dart
final followers = await client.accounts.fetchFollowers('12345', limit: 40);
final following = await client.accounts.fetchFollowing('12345', limit: 40);
```

对于私密账号，会返回空页面而不是抛出错误。

### 关系状态

```dart
final rels = await client.accounts.fetchRelationships(['12345', '67890']);
for (final rel in rels) {
  print('${rel.id}: following=${rel.following}, followedBy=${rel.followedBy}');
}
```

### 共同关注者

```dart
final familiar = await client.accounts.fetchFamiliarFollowers(['12345']);
```

## 关注 / 取消关注

```dart
// 带选项的关注
final rel = await client.accounts.follow(
  '12345',
  reblogs: true,        // 在主页时间线显示转嘟
  notify: true,         // 新帖子时接收通知
  languages: ['en'],    // 仅显示指定语言的帖子
);

// 取消关注
await client.accounts.unfollow('12345');
```

## 屏蔽 / 静音

```dart
// 屏蔽
await client.accounts.block('12345');
await client.accounts.unblock('12345');

// 静音（带时长）
await client.accounts.mute('12345', duration: 3600); // 1 小时
await client.accounts.unmute('12345');
```

## 个人资料操作

### 更新个人资料

```dart
final updated = await client.accounts.updateCredentials(
  MastodonCredentialAccountUpdateRequest(
    displayName: 'New Name',
    note: 'Updated bio',
  ),
);
```

### 推荐 / 取消推荐（在个人资料上展示）

```dart
await client.accounts.endorse('12345');   // 在个人资料上推荐
await client.accounts.unendorse('12345'); // 从个人资料移除
```

### 私密备注

```dart
await client.accounts.setNote('12345', comment: 'Met at conference');
```

## 账号帖子

```dart
final page = await client.accounts.fetchStatuses(
  '12345',
  limit: 20,
  excludeReplies: true,
  excludeReblogs: true,
);
```

可用过滤器：`excludeReplies`、`excludeReblogs`、`onlyMedia`、`pinned`、`tagged`。
