---
sidebar_position: 12
---

# 소셜

이 페이지에서는 기본 팔로우 이상의 소셜 그래프 API를 다룹니다: 팔로우 요청, 팔로우한 태그, 팔로우 제안, 추천, 피처된 태그, 태그 작업, 좋아요, 북마크.

## 팔로우 요청

계정이 잠긴 경우, 수신된 팔로우 요청을 `client.followRequests`를 통해 명시적으로 수락하거나 거절해야 합니다.

### 대기 중인 요청 목록 조회

```dart
final page = await client.followRequests.fetch(limit: 40);
for (final account in page.items) {
  print('${account.acct} wants to follow you');
}

// 페이지네이션
if (page.nextMaxId != null) {
  final next = await client.followRequests.fetch(maxId: page.nextMaxId);
}
```

`fetch`는 `MastodonPage<MastodonAccount>`를 반환합니다. 페이지네이션 커서는 `Link` 응답 헤더에서 가져옵니다. 기본 limit은 40이고 최대는 80입니다.

### 요청 수락

```dart
final relationship = await client.followRequests.authorize('12345');
print(relationship.followedBy); // true
```

### 요청 거절

```dart
final relationship = await client.followRequests.reject('12345');
```

`authorize`와 `reject` 모두 업데이트된 관계 상태를 반영하는 `MastodonRelationship`을 반환합니다.

## 팔로우한 태그

`client.followedTags`는 인증된 사용자가 팔로우하는 해시태그 목록을 반환합니다. 팔로우한 태그가 포함된 포스트는 홈 타임라인에 표시됩니다.

```dart
final page = await client.followedTags.fetch(limit: 100);
for (final tag in page.items) {
  print('#${tag.name}');
}
```

기본 limit은 100이고 최대는 200입니다. 페이지네이션은 `maxId`, `sinceId`, `minId`를 사용합니다. 커서 ID는 태그 ID가 아닌 내부 팔로우 관계 레코드 ID입니다.

특정 태그를 팔로우하거나 언팔로우하려면 `client.tags`를 사용하세요 (아래 참조).

## 팔로우 제안

`client.suggestions`는 서버가 팔로우를 권장하는 계정을 반환합니다. 스태프가 직접 선별한 계정이나 사용자가 긍정적으로 상호작용했지만 아직 팔로우하지 않은 계정입니다.

```dart
final suggestions = await client.suggestions.fetch(limit: 20);
for (final suggestion in suggestions) {
  print('${suggestion.account.acct} — reason: ${suggestion.source}');
}
```

`List<MastodonSuggestion>`을 반환합니다. 기본 limit은 40이고 최대는 80입니다.

제안 목록에서 계정을 제거하려면:

```dart
await client.suggestions.remove('12345');
```

계정이 현재 제안 목록에 없어도 성공합니다.

## 추천

추천은 사용자가 프로필에 피처하도록 선택한 계정입니다. `client.endorsements`를 사용해 조회합니다.

```dart
final page = await client.endorsements.fetch(limit: 40);
for (final account in page.items) {
  print(account.displayName);
}
```

`MastodonPage<MastodonAccount>`를 반환합니다. 기본 limit은 40이고 최대는 80입니다. 계정을 추천하거나 추천 해제하려면 `client.accounts.endorse` 및 `client.accounts.unendorse`를 사용하세요.

## 피처된 태그

피처된 태그는 사용자 프로필에 두드러지게 표시되는 해시태그입니다. `client.featuredTags`를 사용해 관리합니다.

### 피처된 태그 목록 조회

```dart
final tags = await client.featuredTags.fetch();
for (final tag in tags) {
  print('#${tag.name} — ${tag.statusesCount} statuses');
}
```

### 피처된 태그 추가

```dart
final tag = await client.featuredTags.create('dart');
print(tag.id);
```

`#` 접두사 없이 태그 이름을 전달합니다.

### 피처된 태그 제거

```dart
await client.featuredTags.delete(tag.id);
```

### 피처된 태그 제안

서버가 최근 사용된 해시태그를 최대 10개 후보로 반환합니다:

```dart
final suggestions = await client.featuredTags.fetchSuggestions();
```

`List<MastodonTag>`를 반환합니다.

## 태그

`client.tags`는 태그 정보 조회, 팔로우, 피처 작업을 제공합니다.

### 태그 정보 조회

```dart
final tag = await client.tags.fetch('dart');
print(tag.name);
print(tag.following); // 인증되지 않은 경우 null
```

이름 조회는 대소문자를 구분하지 않습니다. 인증된 경우 `following` 필드가 포함됩니다.

### 태그 팔로우 및 언팔로우

```dart
final tag = await client.tags.follow('dart');
print(tag.following); // true

final unfollowed = await client.tags.unfollow('dart');
print(unfollowed.following); // false
```

### 태그 피처 및 피처 해제 (Mastodon 4.4.0+)

```dart
await client.tags.feature('dart');
await client.tags.unfeature('dart');
```

두 메서드 모두 업데이트된 상태를 반영하는 `MastodonTag`를 반환합니다.

## 좋아요

`client.favourites`는 인증된 사용자가 좋아요한 모든 포스트를 나열합니다.

```dart
final page = await client.favourites.fetch(limit: 20);
for (final status in page.items) {
  print(status.content);
}

// 더 오래된 결과
if (page.nextMaxId != null) {
  final older = await client.favourites.fetch(maxId: page.nextMaxId);
}
```

`MastodonPage<MastodonStatus>`를 반환합니다. 기본 limit은 20이고 최대는 40입니다. 페이지네이션은 `maxId`, `sinceId`, `minId`를 사용합니다.

특정 포스트에 좋아요를 누르거나 취소하려면 `client.statuses.favourite` 및 `client.statuses.unfavourite`를 사용하세요.

## 북마크

`client.bookmarks`는 인증된 사용자가 북마크한 모든 포스트를 나열합니다.

```dart
final page = await client.bookmarks.fetch(limit: 20);
for (final status in page.items) {
  print(status.id);
}
```

`MastodonPage<MastodonStatus>`를 반환합니다. 기본 limit은 20이고 최대는 40입니다. 페이지네이션은 `maxId`, `sinceId`, `minId`를 사용합니다.

북마크를 추가하거나 제거하려면 `client.statuses.bookmark` 및 `client.statuses.unbookmark`를 사용하세요.
