---
sidebar_position: 8
---

# 푸시 알림

`client.push` API는 Web Push 구독을 관리합니다. [Web Push Protocol](https://www.rfc-editor.org/rfc/rfc8030)을 따르며 애플리케이션이 백그라운드에서 알림을 수신할 수 있게 합니다.

## 구독 등록

푸시 엔드포인트와 VAPID 키를 제공하여 새 Web Push 구독을 생성합니다:

```dart
final subscription = await client.push.create(
  MastodonPushSubscriptionRequest(
    endpoint: 'https://push.example.com/subscription/abc123',
    p256dh: '<Base64url-encoded P-256 ECDH public key>',
    auth: '<Base64url-encoded authentication secret>',
    standard: true,
    alerts: MastodonPushAlertSettings(
      mention: true,
      follow: true,
      reblog: true,
      favourite: true,
      poll: true,
    ),
    policy: 'followed', // all | followed | follower | none
  ),
);

print(subscription.id);
print(subscription.serverKey); // 수신된 푸시 검증에 사용
```

### 알림 타입

`MastodonPushAlertSettings`는 다음 필드의 임의 조합을 허용합니다. `null`로 설정된 필드는 요청에서 생략됩니다. 구독을 생성할 때 생략된 필드에는 서버 기본값이 사용됩니다. 업데이트할 때는 아래 설명과 같이 전체 설정 객체가 교체됩니다.

| 필드 | 설명 |
|------|------|
| `mention` | 포스트에서 언급됨 |
| `quote` | 포스트가 인용됨 |
| `status` | 팔로우하는 사용자의 새 포스트 |
| `reblog` | 포스트가 부스트됨 |
| `follow` | 새 팔로워 |
| `followRequest` | 새 팔로우 요청 |
| `favourite` | 포스트가 좋아요됨 |
| `poll` | 투표하거나 생성한 설문이 종료됨 |
| `update` | 상호작용한 포스트가 수정됨 |
| `quotedUpdate` | 인용된 포스트가 수정됨 |
| `adminSignUp` | 새 사용자 가입 (관리자 전용) |
| `adminReport` | 새 신고 (관리자 전용) |

### 정책 값

| 값 | 설명 |
|----|------|
| `all` | 모든 사용자의 알림 수신 |
| `followed` | 팔로우하는 사용자의 알림만 수신 |
| `follower` | 팔로워의 알림만 수신 |
| `none` | 모든 푸시 알림 비활성화 |

## 현재 구독 조회

```dart
final subscription = await client.push.fetch();
print(subscription.endpoint);
print(subscription.alerts.mention);
print(subscription.policy);
```

## 알림 설정 업데이트

`update`를 사용하면 구독을 재생성하지 않고 `data` 부분(알림과 정책)을 교체할 수 있습니다. 부분 업데이트가 아니므로 생략한 모든 알림 타입은 비활성화되고, `policy`를 생략하면 `all`로 재설정됩니다. 계속 활성화할 모든 알림 타입을 지정해야 합니다. `alerts`와 `policy`를 모두 생략하면 HTTP 요청을 보내기 전에 `ArgumentError`가 발생합니다.

```dart
final updated = await client.push.update(
  MastodonPushSubscriptionUpdateRequest(
    alerts: MastodonPushAlertSettings(
      mention: true,
      follow: false,
      reblog: true,
      favourite: true,
      poll: true,
    ),
    policy: 'all',
  ),
);
```

모든 알림을 명시적으로 비활성화하고 정책을 `all`로 재설정하려면 빈 알림 설정 객체를 전송합니다.

```dart
await client.push.update(
  const MastodonPushSubscriptionUpdateRequest(
    alerts: MastodonPushAlertSettings(),
  ),
);
```

## 구독 해제

```dart
await client.push.delete();
```

현재 Web Push 구독을 삭제합니다. 이후 `fetch` 호출은 `MastodonNotFoundException`을 발생시킵니다.

## MastodonWebPushSubscription 모델

| 필드 | 타입 | 설명 |
|------|------|------|
| `id` | `String` | 구독 ID |
| `endpoint` | `String` | 푸시 엔드포인트 URL |
| `serverKey` | `String` | 푸시 메시지 검증용 서버 공개 키 |
| `alerts` | `MastodonPushAlerts` | 활성화된 알림 설정 |
| `policy` | `String` | 알림 정책 |
| `standard` | `bool?` | 표준화된 Web Push 스펙을 따르는지 여부 (Mastodon 4.4+) |
