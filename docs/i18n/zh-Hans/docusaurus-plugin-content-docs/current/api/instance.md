---
sidebar_position: 10
---

# 实例与服务器

本页介绍用于获取服务器元数据、自定义表情、公告、健康状态、用户偏好设置、个人资料目录、oEmbed 嵌入以及时间线标记的 API。

## 实例信息

### 当前实例（v2）

```dart
final instance = await client.instance.fetch();
print(instance.title);
print(instance.description);
print(instance.version);
```

返回包含完整 v2 元数据的 `MastodonInstance`，包括配置的语言、规则和联系信息。

### 与版本相关的功能

在提供新版 Mastodon 才有的功能前，请使用 `detectCapabilities()` 检测支持情况：

```dart
final capabilities = await client.instance.detectCapabilities();

switch (capabilities.supportFor(MastodonCapability.collections)) {
  case MastodonCapabilitySupport.supported:
    // 提供收藏列表功能。
  case MastodonCapabilitySupport.unsupported:
    // 隐藏或禁用收藏列表功能。
  case MastodonCapabilitySupport.unknown:
    // 使用保守的回退方案，或允许用户尝试该操作。
}
```

| Capability | 服务器功能 | 最低 Mastodon 版本 | API 功能级别 |
|---|---|---:|---:|
| `tagFeaturing` | 将标签设为精选或取消精选 | 4.4.0 | 6 |
| `annualReportDetails` | 按年份获取年度报告 | 4.4.0 | 6 |
| `oauthUserInfo` | OpenID Connect 用户信息 | 4.4.0 | 6 |
| `asyncRefreshes` | 实验性异步刷新状态 | 4.4.0 | 6 |
| `quotePosts` | 引用嘟文操作 | 4.5.0 | 7 |
| `collections` | 收藏列表端点 | 4.6.0 | 10 |
| `donationCampaigns` | 捐赠活动端点 | 4.6.0 | 10 |
| `editableProfile` | 获取或更新可编辑个人资料 | 4.6.0 | 10 |
| `annualReportGeneration` | 生成报告或获取其状态 | 4.6.0 | 10 |

检测遵循以下规则：

1. 获取 `GET /api/v2/instance`，并优先使用 `api_versions.mastodon`。
2. 若该字段缺失，则尽力解析 `MastodonInstance.version` 开头的
   `major.minor.patch`。
3. 若 v2 端点本身返回 404，则获取旧版 `GET /api/v1/instance`，并使用其版本字符串。
   其他错误会直接向上传递，不会触发回退。
4. 若无法解析现有元数据，则返回 `unknown`。

请在每个应用进程生命周期内，按服务器缓存一次结果。不要在每次 API 调用前都请求实例元数据。

`api_versions.mastodon` 表示 API 功能级别，而不是发布版本号。它可能在补丁版本或不新增路由
的变更中增加，多个发布版本可能共享同一值，也可能跳过整数。请仅使用表中的最低阈值，
不要将其反向转换为 Mastodon 发布版本。

功能检测结果仅供参考。派生版本和兼容实现的实际功能可能与其报告的元数据不一致，因此
仍须处理实际 API 调用的错误。尤其是，404 响应无法可靠地区分端点不存在和资源不存在。

### 已知对等域名

```dart
final peers = await client.instance.fetchPeers();
// 已知联合域名的 List<String>
```

### 每周活动

```dart
final activity = await client.instance.fetchActivity();
for (final week in activity) {
  print('Statuses: ${week.statuses}');
}
```

返回最多 12 周的 `MastodonWeeklyActivity` 对象。

### 实例规则

```dart
final rules = await client.instance.fetchRules();
for (final rule in rules) {
  print(rule.text);
}
```

### 域名屏蔽列表

```dart
final blocked = await client.instance.fetchDomainBlocks();
```

返回该实例屏蔽的域名列表。这是服务器级别的列表，不是用户个人的屏蔽列表；用户级别的域名屏蔽请参阅 [内容管理](./moderation.md) 页面。

### 扩展说明

```dart
final description = await client.instance.fetchExtendedDescription();
print(description.content);
```

### 隐私政策与服务条款

```dart
final policy = await client.instance.fetchPrivacyPolicy();
final tos = await client.instance.fetchTermsOfService();

// 按日期获取特定历史版本的服务条款
final old = await client.instance.fetchTermsOfServiceByDate('2024-01-01');
```

### 翻译语言

```dart
final languages = await client.instance.fetchTranslationLanguages();
// Map<String, List<String>> — 源语言 → 支持的目标语言
languages.forEach((source, targets) {
  print('$source → $targets');
});
```

### 旧版 v1（已弃用）

```dart
// ignore: deprecated_member_use
final instanceV1 = await client.instance.fetchV1();
```

`fetchV1()` 自 Mastodon 4.0.0 起已弃用。除非需要支持旧版服务器，否则请使用 `fetch()`。

---

## 自定义表情

```dart
final emojis = await client.customEmojis.fetch();
for (final emoji in emojis) {
  print(':${emoji.shortcode}: → ${emoji.url}');
}
```

无需认证。返回服务器上所有自定义表情的 `List<MastodonCustomEmoji>`。

---

## 公告

### 列出公告

```dart
final announcements = await client.announcements.fetch();
for (final a in announcements) {
  print(a.text);
}
```

### 关闭公告

```dart
await client.announcements.dismiss('announcement-id');
```

为已认证用户将该公告标记为已读。

### 表情反应

```dart
// 添加反应（Unicode 表情或自定义 shortcode）
await client.announcements.addReaction('announcement-id', '👍');
await client.announcements.addReaction('announcement-id', 'blobcat');

// 移除反应
await client.announcements.removeReaction('announcement-id', '👍');
```

---

## 健康检查

```dart
final healthy = await client.health.check();
// 当 Web 进程、数据库和缓存全部正常时返回 true。
// 若任意组件不健康则抛出 MastodonException。
```

无需认证。适用于监控和就绪探针。

---

## 用户偏好设置

```dart
final prefs = await client.preferences.fetch();
print(prefs.postingDefaultVisibility);
print(prefs.postingDefaultLanguage);
print(prefs.expandSpoilers);
```

返回已认证用户的 `MastodonPreferences`。若要更新偏好设置，请使用 `client.accounts.updateCredentials()`。

---

## 个人资料目录

```dart
// 最近活跃账号（全局）
final active = await client.directory.fetch(
  order: 'active',
  limit: 40,
);

// 仅本地最新账号
final newLocal = await client.directory.fetch(
  order: 'new',
  local: true,
);
```

参数：

| 参数 | 默认值 | 上限 | 说明 |
|------|--------|------|------|
| `limit`   | 40 | 80 | 结果数量 |
| `offset`  | — | — | 跳过此数量的结果 |
| `order`   | — | — | `active` 或 `new` |
| `local`   | — | — | `true` 仅限本地账号 |

无需认证。

---

## oEmbed

```dart
final embed = await client.oembed.fetch(
  'https://mastodon.social/@user/12345',
  maxwidth: 500,
);
print(embed.html);
```

返回包含帖子 URL 可嵌入 HTML 的 `MastodonOEmbed`。无需认证。

---

## 时间线标记

标记允许你在会话和设备之间持久化用户在主页时间线和通知时间线中的已读位置。

### 获取标记

```dart
final markers = await client.markers.fetch(['home', 'notifications']);
final home = markers['home'];
print(home?.lastReadId);
```

传入包含 `'home'`、`'notifications'` 或两者的列表。若两者均未指定，则返回空 map。

### 保存标记

```dart
final updated = await client.markers.save(
  homeLastReadId: '109876543210',
  notificationsLastReadId: '987654321',
);
```

`homeLastReadId` 和 `notificationsLastReadId` 至少提供其中一个。如果服务器响应 `409 Conflict`（另一设备的写入冲突），请重试请求。

```dart
// 冲突重试示例
Map<String, MastodonMarker> result;
while (true) {
  try {
    result = await client.markers.save(homeLastReadId: lastId);
    break;
  } on MastodonConflictException {
    // 短暂延迟后重试
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
```
