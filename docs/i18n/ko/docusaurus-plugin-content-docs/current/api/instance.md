---
sidebar_position: 10
---

# 인스턴스 & 서버

이 페이지에서는 서버 메타데이터, 커스텀 이모지, 공지사항, 헬스 상태, 사용자 기본 설정, 프로필 디렉토리, oEmbed 임베드, 타임라인 마커 조회 API를 다룹니다.

## 인스턴스 정보

### 현재 인스턴스 (v2)

```dart
final instance = await client.instance.fetch();
print(instance.title);
print(instance.description);
print(instance.version);
```

설정된 언어, 규칙, 연락처 정보를 포함한 전체 v2 메타데이터를 담은 `MastodonInstance`를 반환합니다.

### 피어 도메인

```dart
final peers = await client.instance.fetchPeers();
// 알려진 연합 도메인 List<String>
```

### 주간 활동

```dart
final activity = await client.instance.fetchActivity();
for (final week in activity) {
  print('Statuses: ${week.statuses}');
}
```

최대 12주치 `MastodonWeeklyActivity` 객체를 반환합니다.

### 인스턴스 규칙

```dart
final rules = await client.instance.fetchRules();
for (final rule in rules) {
  print(rule.text);
}
```

### 도메인 차단 목록

```dart
final blocked = await client.instance.fetchDomainBlocks();
```

인스턴스가 차단한 도메인 목록을 반환합니다. 이것은 인스턴스 수준의 목록이며 사용자별 목록이 아닙니다. 사용자 수준의 도메인 차단은 [모더레이션](./moderation.md) 페이지를 참고하세요.

### 확장 설명

```dart
final description = await client.instance.fetchExtendedDescription();
print(description.content);
```

### 개인정보 처리방침 및 서비스 약관

```dart
final policy = await client.instance.fetchPrivacyPolicy();
final tos = await client.instance.fetchTermsOfService();

// 날짜로 특정 과거 버전의 서비스 약관 조회
final old = await client.instance.fetchTermsOfServiceByDate('2024-01-01');
```

### 번역 언어

```dart
final languages = await client.instance.fetchTranslationLanguages();
// Map<String, List<String>> — 원본 언어 → 지원되는 대상 언어
languages.forEach((source, targets) {
  print('$source → $targets');
});
```

### 레거시 v1 (비권장)

```dart
// ignore: deprecated_member_use
final instanceV1 = await client.instance.fetchV1();
```

`fetchV1()`은 Mastodon 4.0.0부터 비권장되었습니다. 구버전 서버를 지원해야 하는 경우가 아니라면 `fetch()`를 사용하세요.

---

## 커스텀 이모지

```dart
final emojis = await client.customEmojis.fetch();
for (final emoji in emojis) {
  print(':${emoji.shortcode}: → ${emoji.url}');
}
```

인증이 필요하지 않습니다. 서버에서 사용 가능한 모든 커스텀 이모지의 `List<MastodonCustomEmoji>`를 반환합니다.

---

## 공지사항

### 공지사항 목록 조회

```dart
final announcements = await client.announcements.fetch();
for (final a in announcements) {
  print(a.text);
}
```

### 공지사항 읽음 처리

```dart
await client.announcements.dismiss('announcement-id');
```

인증된 사용자에게 공지사항을 읽음으로 표시합니다.

### 반응

```dart
// 반응 추가 (유니코드 이모지 또는 커스텀 단축코드)
await client.announcements.addReaction('announcement-id', '👍');
await client.announcements.addReaction('announcement-id', 'blobcat');

// 반응 제거
await client.announcements.removeReaction('announcement-id', '👍');
```

---

## 헬스 체크

```dart
final healthy = await client.health.check();
// 웹 프로세스, 데이터베이스, 캐시가 모두 정상이면 true를 반환합니다.
// 컴포넌트 중 하나라도 비정상이면 MastodonException이 발생합니다.
```

인증이 필요하지 않습니다. 모니터링 및 준비 상태 프로브에 유용합니다.

---

## 사용자 기본 설정

```dart
final prefs = await client.preferences.fetch();
print(prefs.postingDefaultVisibility);
print(prefs.postingDefaultLanguage);
print(prefs.expandSpoilers);
```

인증된 사용자의 `MastodonPreferences`를 반환합니다. 기본 설정을 업데이트하려면 `client.accounts.updateCredentials()`를 사용하세요.

---

## 프로필 디렉토리

```dart
// 가장 최근에 활동한 계정 (전체)
final active = await client.directory.fetch(
  order: 'active',
  limit: 40,
);

// 로컬 계정 중 최신 계정만
final newLocal = await client.directory.fetch(
  order: 'new',
  local: true,
);
```

파라미터:

| 파라미터 | 기본값 | 최대값 | 설명 |
|----------|--------|--------|------|
| `limit`   | 40     | 80     | 결과 수 |
| `offset`  | —      | —      | 이 수만큼 결과 건너뜀 |
| `order`   | —      | —      | `active` 또는 `new` |
| `local`   | —      | —      | `true`이면 로컬 계정만 |

인증이 필요하지 않습니다.

---

## oEmbed

```dart
final embed = await client.oembed.fetch(
  'https://mastodon.social/@user/12345',
  maxwidth: 500,
);
print(embed.html);
```

포스트 URL의 임베드 가능한 HTML을 담은 `MastodonOEmbed`를 반환합니다. 인증이 필요하지 않습니다.

---

## 타임라인 마커

마커를 사용하면 세션과 기기 간에 홈 타임라인과 알림 타임라인에서 사용자의 읽은 위치를 유지할 수 있습니다.

### 마커 조회

```dart
final markers = await client.markers.fetch(['home', 'notifications']);
final home = markers['home'];
print(home?.lastReadId);
```

`'home'`, `'notifications'` 또는 둘 다 포함하는 목록을 전달합니다. 아무것도 지정하지 않으면 빈 맵을 반환합니다.

### 마커 저장

```dart
final updated = await client.markers.save(
  homeLastReadId: '109876543210',
  notificationsLastReadId: '987654321',
);
```

`homeLastReadId` 또는 `notificationsLastReadId` 중 하나 이상을 반드시 제공해야 합니다. 서버가 `409 Conflict`(다른 기기에서의 쓰기 충돌)로 응답하면 요청을 재시도하세요.

```dart
// 충돌 시 재시도 예시
Map<String, MastodonMarker> result;
while (true) {
  try {
    result = await client.markers.save(homeLastReadId: lastId);
    break;
  } on MastodonConflictException {
    // 재시도 전 짧은 대기
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
```
