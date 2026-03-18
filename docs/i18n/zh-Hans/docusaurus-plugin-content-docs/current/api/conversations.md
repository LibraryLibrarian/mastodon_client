---
sidebar_position: 9
---

# 对话与投票

## 对话

`client.conversations` API 处理对话会话——由 `visibility: direct` 帖子组成的话题线程。

### 获取会话列表

```dart
final page = await client.conversations.fetch(limit: 20);

for (final conversation in page.items) {
  print(conversation.id);
  print(conversation.unread);
  print(conversation.accounts.map((a) => a.acct).join(', '));
  if (conversation.lastStatus != null) {
    print(conversation.lastStatus!.content);
  }
}
```

返回 `MastodonPage<MastodonConversation>`。使用 `nextMaxId` 和 `prevMinId` 进行分页：

```dart
MastodonPage<MastodonConversation>? page = await client.conversations.fetch();

while (page != null && page.nextMaxId != null) {
  page = await client.conversations.fetch(maxId: page.nextMaxId);
  for (final conversation in page.items) {
    print(conversation.id);
  }
}
```

分页参数：

| 参数 | 说明 |
|------|------|
| `limit`   | 最大结果数（默认：20，上限：40） |
| `maxId`   | 返回比此 ID 更旧的会话 |
| `sinceId` | 返回比此 ID 更新的会话 |
| `minId`   | 返回紧接此 ID 之后的会话（顺序翻页） |

### 将会话标记为已读

```dart
final conversation = await client.conversations.markAsRead('7');
print(conversation.unread); // false
```

返回更新后的 `MastodonConversation`。

### 删除会话

```dart
await client.conversations.delete('7');
```

### MastodonConversation 模型

| 字段 | 类型 | 说明 |
|------|------|------|
| `id` | `String` | 会话内部 ID |
| `unread` | `bool` | 是否有未读消息 |
| `accounts` | `List<MastodonAccount>` | 参与者（不含已认证用户） |
| `lastStatus` | `MastodonStatus?` | 会话中最新的帖子，或 `null` |

---

## 投票

`client.polls` API 用于获取投票和提交投票选项。投票通常附加在帖子上，可通过 `status.poll` 获取投票 ID。

### 获取投票

```dart
final poll = await client.polls.fetch('34');
print(poll.votesCount);
print(poll.expired);

for (final option in poll.options) {
  print('${option.title}: ${option.votesCount ?? "hidden"}');
}
```

### 参与投票

传入从 0 开始的选项索引列表。单选投票只传一个索引。

```dart
// 单选
final poll = await client.polls.vote('34', [0]);

// 多选（当 poll.multiple == true 时允许）
final poll = await client.polls.vote('34', [0, 2]);

print(poll.voted);    // true
print(poll.ownVotes); // 例如 [0, 2]
```

如果已认证用户已投过票，则抛出 `MastodonAlreadyVotedException`。

### MastodonPoll 模型

| 字段 | 类型 | 说明 |
|------|------|------|
| `id` | `String` | 投票内部 ID |
| `expiresAt` | `DateTime?` | 到期时间戳 |
| `expired` | `bool` | 投票是否已结束 |
| `multiple` | `bool` | 是否允许多选 |
| `votesCount` | `int` | 总投票数 |
| `votersCount` | `int?` | 唯一投票人数（多选时与 `votesCount` 不同） |
| `options` | `List<MastodonPollOption>` | 可选项列表 |
| `emojis` | `List<MastodonCustomEmoji>` | 选项文字中使用的自定义表情 |
| `voted` | `bool?` | 已认证用户是否已投票 |
| `ownVotes` | `List<int>?` | 已认证用户投票的选项索引 |

`MastodonPollOption` 字段：

| 字段 | 类型 | 说明 |
|------|------|------|
| `title` | `String` | 选项文字 |
| `votesCount` | `int?` | 该选项的票数；非公开投票时为 `null` |
