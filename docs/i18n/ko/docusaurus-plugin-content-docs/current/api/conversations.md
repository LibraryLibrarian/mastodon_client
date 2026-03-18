---
sidebar_position: 9
---

# 대화 및 설문

## 대화

`client.conversations` API는 다이렉트 메시지 대화를 처리합니다. `visibility: direct`인 포스트로 구성된 스레드입니다.

### 대화 목록 조회

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

`MastodonPage<MastodonConversation>`을 반환합니다. 페이지네이션에는 `nextMaxId`와 `prevMinId`를 사용합니다:

```dart
MastodonPage<MastodonConversation>? page = await client.conversations.fetch();

while (page != null && page.nextMaxId != null) {
  page = await client.conversations.fetch(maxId: page.nextMaxId);
  for (final conversation in page.items) {
    print(conversation.id);
  }
}
```

페이지네이션 파라미터:

| 파라미터 | 설명 |
|----------|------|
| `limit`   | 최대 결과 수 (기본값: 20, 최대: 40) |
| `maxId`   | 이 ID보다 오래된 대화 반환 |
| `sinceId` | 이 ID보다 최근 대화 반환 |
| `minId`   | 이 ID 바로 다음부터 대화 반환 (순차 페이지네이션) |

### 대화를 읽음으로 표시

```dart
final conversation = await client.conversations.markAsRead('7');
print(conversation.unread); // false
```

업데이트된 `MastodonConversation`을 반환합니다.

### 대화 삭제

```dart
await client.conversations.delete('7');
```

### MastodonConversation 모델

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | `String` | 내부 대화 ID |
| `unread` | `bool` | 읽지 않은 메시지 여부 |
| `accounts` | `List<MastodonAccount>` | 참여자 (인증된 사용자 제외) |
| `lastStatus` | `MastodonStatus?` | 대화의 가장 최근 포스트, 없으면 `null` |

---

## 설문

`client.polls` API를 통해 설문을 조회하고 투표할 수 있습니다. 설문은 일반적으로 포스트에 첨부되며, 설문 ID는 `status.poll`을 통해 얻을 수 있습니다.

### 설문 조회

```dart
final poll = await client.polls.fetch('34');
print(poll.votesCount);
print(poll.expired);

for (final option in poll.options) {
  print('${option.title}: ${option.votesCount ?? "hidden"}');
}
```

### 설문 투표

0부터 시작하는 선택지 인덱스 목록을 전달합니다. 단일 선택 설문의 경우 인덱스 하나만 전달합니다.

```dart
// 단일 선택
final poll = await client.polls.vote('34', [0]);

// 다중 선택 (poll.multiple == true인 경우 허용)
final poll = await client.polls.vote('34', [0, 2]);

print(poll.voted);    // true
print(poll.ownVotes); // 예: [0, 2]
```

인증된 사용자가 이미 투표한 경우 `MastodonAlreadyVotedException`이 발생합니다.

### MastodonPoll 모델

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | `String` | 내부 설문 ID |
| `expiresAt` | `DateTime?` | 만료 시각 |
| `expired` | `bool` | 설문 종료 여부 |
| `multiple` | `bool` | 다중 선택 허용 여부 |
| `votesCount` | `int` | 총 투표 수 |
| `votersCount` | `int?` | 고유 투표자 수 (다중 선택 설문에서 `votesCount`와 다를 수 있음) |
| `options` | `List<MastodonPollOption>` | 선택지 목록 |
| `emojis` | `List<MastodonCustomEmoji>` | 선택지 텍스트에 사용된 커스텀 이모지 |
| `voted` | `bool?` | 인증된 사용자의 투표 여부 |
| `ownVotes` | `List<int>?` | 인증된 사용자가 투표한 선택지 인덱스 |

`MastodonPollOption` 필드:

| 필드 | 타입 | 설명 |
|------|------|------|
| `title` | `String` | 선택지 텍스트 |
| `votesCount` | `int?` | 이 선택지의 투표 수; 비공개 설문에서는 `null` |
