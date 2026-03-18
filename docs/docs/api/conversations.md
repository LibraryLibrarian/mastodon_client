---
sidebar_position: 9
---

# Conversations and Polls

## Conversations

The `client.conversations` API handles direct message conversations — threads that consist of statuses with `visibility: direct`.

### Fetching conversations

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

Returns `MastodonPage<MastodonConversation>`. Use `nextMaxId` and `prevMinId` for pagination:

```dart
MastodonPage<MastodonConversation>? page = await client.conversations.fetch();

while (page != null && page.nextMaxId != null) {
  page = await client.conversations.fetch(maxId: page.nextMaxId);
  for (final conversation in page.items) {
    print(conversation.id);
  }
}
```

Pagination parameters:

| Parameter | Description |
|-----------|-------------|
| `limit`   | Maximum results (default: 20, max: 40) |
| `maxId`   | Return conversations older than this ID |
| `sinceId` | Return conversations newer than this ID |
| `minId`   | Return conversations immediately after this ID (forward pagination) |

### Marking a conversation as read

```dart
final conversation = await client.conversations.markAsRead('7');
print(conversation.unread); // false
```

Returns the updated `MastodonConversation`.

### Deleting a conversation

```dart
await client.conversations.delete('7');
```

### The MastodonConversation model

| Field | Type | Description |
|-------|------|-------------|
| `id` | `String` | Internal conversation ID |
| `unread` | `bool` | Whether the conversation has unread messages |
| `accounts` | `List<MastodonAccount>` | Participants (excluding the authenticated user) |
| `lastStatus` | `MastodonStatus?` | Most recent status in the conversation, or `null` |

---

## Polls

The `client.polls` API lets you fetch polls and submit votes. Polls are typically attached to statuses; use `status.poll` to get the poll ID.

### Fetching a poll

```dart
final poll = await client.polls.fetch('34');
print(poll.votesCount);
print(poll.expired);

for (final option in poll.options) {
  print('${option.title}: ${option.votesCount ?? "hidden"}');
}
```

### Voting on a poll

Pass a list of zero-based option indices. For single-choice polls, pass exactly one index.

```dart
// Single choice
final poll = await client.polls.vote('34', [0]);

// Multiple choices (allowed when poll.multiple == true)
final poll = await client.polls.vote('34', [0, 2]);

print(poll.voted);    // true
print(poll.ownVotes); // e.g. [0, 2]
```

Throws `MastodonAlreadyVotedException` if the authenticated user has already voted.

### The MastodonPoll model

| Field | Type | Description |
|-------|------|-------------|
| `id` | `String` | Internal poll ID |
| `expiresAt` | `DateTime?` | Expiration timestamp |
| `expired` | `bool` | Whether the poll has ended |
| `multiple` | `bool` | Whether multiple choices are allowed |
| `votesCount` | `int` | Total number of votes cast |
| `votersCount` | `int?` | Number of unique voters (differs from `votesCount` for multiple-choice polls) |
| `options` | `List<MastodonPollOption>` | Available options |
| `emojis` | `List<MastodonCustomEmoji>` | Custom emojis used in option text |
| `voted` | `bool?` | Whether the authenticated user has voted |
| `ownVotes` | `List<int>?` | Indices of options the authenticated user voted for |

`MastodonPollOption` fields:

| Field | Type | Description |
|-------|------|-------------|
| `title` | `String` | Option text |
| `votesCount` | `int?` | Votes for this option; `null` for non-public polls |
