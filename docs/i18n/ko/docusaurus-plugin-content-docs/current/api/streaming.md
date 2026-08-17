---
sidebar_position: 15
---

# 스트리밍

`client.streaming` API는 Mastodon 스트리밍 API(WebSocket)를 통해 실시간 업데이트를 전달합니다. 단일 연결에 모든 구독을 다중화하므로 여러 채널을 구독해도 소켓이 여러 개 열리지 않습니다.

`client.streaming`에 접근하는 것만으로는 연결이 열리지 않습니다. 소켓은 `connect()`를 호출할 때만 열리므로, REST만 사용하는 애플리케이션은 이 API를 통해 네트워크에 접근하지 않습니다.

## 연결

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
);

await client.streaming.connect();
```

엔드포인트는 자동으로 확인됩니다. 클라이언트는 `GET /api/v2/instance`의 `configuration.urls.streaming`을 먼저 읽고, 없으면 `GET /api/v1/instance`의 `urls.streaming_api`로 폴백하며, 그것도 없으면 REST 호스트를 재사용합니다. 확인된 값은 정규화됩니다. `http`는 `ws`로, `https`는 `wss`로 변환되고, 포트는 유지되며, `/api/v1/streaming`이 없으면 추가됩니다.

공개 채널을 포함해 스트리밍에는 항상 액세스 토큰이 필요합니다. 익명 접근은 Mastodon v4.2.0에서 제거되었습니다.

## 구독

```dart
final home = await client.streaming.subscribe(const MastodonStream.user());

home.events.listen((event) {
  switch (event) {
    case MastodonUpdateEvent(:final status):
      print(status.content);
    case MastodonStatusUpdateEvent(:final status):
      print('편집됨: ${status.id}');
    case MastodonDeleteEvent(:final statusId):
      print('삭제됨: $statusId');
    case MastodonNotificationEvent(:final notification):
      print(notification.type);
    case MastodonUnknownStreamEvent(:final event):
      print('알 수 없는 이벤트: $event');
    default:
      break;
  }
});

await home.cancel();
```

각 구독 핸들은 세 개의 계층을 제공합니다.

| 속성 | 타입 | 내용 |
|---|---|---|
| `events` | `Stream<MastodonStreamEvent>` | 타입이 지정된 sealed 이벤트 |
| `statuses` | `Stream<MastodonStatus>` | `update` 및 `status.update`의 포스트 |
| `messages` | `Stream<MastodonStreamingMessage>` | payload가 디코딩되지 않은 원시 봉투 |

## 채널

채널은 sealed 타입인 `MastodonStream`으로 표현합니다.

| 팩토리 | 프로토콜상의 이름 |
|---|---|
| `MastodonStream.user()` | `user` |
| `MastodonStream.userNotification()` | `user:notification` |
| `MastodonStream.public()` | `public` |
| `MastodonStream.public(local: true)` | `public:local` |
| `MastodonStream.public(remote: true)` | `public:remote` |
| `MastodonStream.public(onlyMedia: true)` | `public:media` |
| `MastodonStream.public(local: true, onlyMedia: true)` | `public:local:media` |
| `MastodonStream.public(remote: true, onlyMedia: true)` | `public:remote:media` |
| `MastodonStream.hashtag('dart')` | `hashtag` |
| `MastodonStream.hashtag('dart', local: true)` | `hashtag:local` |
| `MastodonStream.list('42')` | `list` |
| `MastodonStream.direct()` | `direct` |

`local`과 `remote`를 동시에 true로 지정할 수는 없습니다. 서버에 해당하는 채널이 존재하지 않으므로 이 조합은 assertion으로 거부됩니다.

Mastodon 포크가 추가한 채널처럼 이 라이브러리가 타입으로 제공하지 않는 채널에는 `subscribeRaw`를 사용하세요.

```dart
final raw = await client.streaming.subscribeRaw('someCustomStream');
raw.messages.listen((message) => print(message.payload));
```

## 참조 카운트

Mastodon은 이미 활성화된 채널에 대한 두 번째 `subscribe`를 조용히 무시하므로, 클라이언트가 참조 카운트를 유지합니다. 카운트가 0에서 1이 될 때 `subscribe` 프레임을 보내고, 다시 0이 될 때 `unsubscribe`를 보냅니다.

이를 위해 해시태그 키는 소문자로 정규화됩니다. 정규화하지 않으면 `Dart`와 `dart`가 서버 측에서 충돌하여 두 번째 구독자가 이벤트를 받지 못합니다.

```dart
final a = await client.streaming.subscribe(const MastodonStream.hashtag('Dart'));
final b = await client.streaming.subscribe(const MastodonStream.hashtag('dart'));

await a.cancel(); // b가 아직 활성이므로 unsubscribe는 보내지 않음
await b.cancel(); // 이제 unsubscribe가 전송됨
```

## 오류

구독에 성공해도 확인 응답은 오지 않으며, 서버 오류에는 채널 이름도 상관 ID도 포함되지 않습니다. 따라서 구독 프레임은 순차적으로 전송되고, 그 뒤의 대기 구간에 도착한 오류는 가장 최근 요청에 연결됩니다.

```dart
try {
  await client.streaming.subscribe(const MastodonStream.list('999'));
} on MastodonStreamingSubscriptionException catch (e) {
  print('${e.message} (${e.status})');
}
```

`MastodonStreamingSubscriptionException.status`가 nullable인 이유는 서버가 `unsubscribe` 오류에서 `status`를 생략하기 때문입니다.

연결 수준의 실패는 `MastodonStreamingConnectionException`으로, 예기치 않은 종료는 `MastodonStreamingClosedException`으로 표현됩니다. 잡는 대신 관찰하고 싶은 경우를 위해 두 가지 모두 `client.streaming.errors`로도 전달됩니다.

## 재연결과 생명주기

재연결은 지수 백오프와 지터를 사용해 자동으로 이루어지며, 상한은 `MastodonStreamingConfig.reconnectMaxDelay`로 제한됩니다. 구독 상태는 연결에 종속되므로, 대체 연결을 사용할 수 있게 되면 활성 구독이 모두 다시 전송됩니다.

종료 코드에 따라 처리가 다릅니다.

| 종료 코드 | 동작 |
|---|---|
| `1000` | 정상 종료. 재연결하지 않음. |
| `1003` | 서버가 바이너리 프레임을 거부함. 재시도 없이 오류로 보고. |
| `1005` | 종료 프레임 없음. 토큰이 취소되었을 수 있으므로 무작정 재시도하지 않음. |
| 그 외 | 백오프 후 재연결. |

핸드셰이크 중의 HTTP 401은 재시도 루프에 들어가지 않고 즉시 던져집니다. 유효하지 않은 토큰으로 재시도해도 성공할 수 없기 때문입니다.

애플리케이션이 백그라운드로 전환되거나 돌아올 때는 `suspend()`와 `resume()`을 사용하고, 정리에는 `dispose()`를 사용하세요.

```dart
await client.streaming.suspend();
await client.streaming.resume();

await client.dispose();
```

`MastodonClient.dispose()`는 스트리밍 연결과 HTTP 전송을 닫습니다. 스트리밍을 한 번도 사용하지 않았다면 이를 위해 스트리밍 클라이언트를 새로 만들지 않습니다.

## 설정

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
  streamingConfig: MastodonStreamingConfig(
    authMode: MastodonStreamingAuthMode.subprotocol,
    pingInterval: Duration(seconds: 30),
    reconnectMaxDelay: Duration(seconds: 30),
    reconnectJitter: 0.2,
  ),
);
```

세 가지 인증 방식을 지원합니다. 기본값인 `subprotocol`은 토큰을 유일한 WebSocket 하위 프로토콜로 전송하며, 웹을 포함한 모든 플랫폼에서 동작하고 액세스 로그에 토큰을 남기지 않습니다. `header`는 `dart:io`가 필요하고, `queryParameter`는 URL에 토큰이 노출되는 레거시 방식입니다. `enableAuthFallback`을 켜 둔 상태에서는 실패 후 나머지 방식을 차례로 시도하며, 성공한 방식이 이후 재연결에서 우선 사용됩니다. 로그 출력에서 토큰은 항상 마스킹됩니다.

## 유의 사항

다음 동작은 Mastodon 스트리밍 서버 자체에서 비롯된 것으로, 흔히 클라이언트 버그처럼 보입니다.

- `read:statuses`로 제한된 토큰은 `user`에서 홈 포스트는 받지만 알림은 전혀 받지 못하며, 오류도 발생하지 않습니다. 알림에는 `read` 또는 `read:notifications`가 필요합니다.
- `only_media`는 WebSocket에서 무시됩니다. 미디어만 받으려면 채널 이름으로 선택해야 합니다.
- `user`와 `user:notification`을 함께 구독하면 서버가 둘을 서로 다른 채널 집합으로 취급하므로 모든 알림이 두 번 전달됩니다. `user`만으로 충분합니다.
- 공개 및 해시태그 채널의 `update`와 `status.update`는 언어 설정, 피드 접근 설정(Mastodon v4.5 이상), 차단, 뮤트, 도메인 차단에 의해 조용히 삭제될 수 있습니다. 공개 스트림이 조용하다고 해서 반드시 고장 난 것은 아닙니다.
- `filters_changed`는 이벤트 타입으로 정의되어 있지만 Mastodon v4.3 이상에서는 클라이언트에 전달되지 않습니다. 서버가 payload 없는 메시지를 버리기 때문입니다.
- 소켓이 끊긴 동안 발생한 이벤트는 재연결 후에도 다시 전달되지 않습니다. REST의 `since_id` 또는 `min_id`로 공백을 메우세요.

## 상태 확인

스트리밍 프로세스는 자체 상태 확인 엔드포인트를 가지며, JSON이 아닌 일반 텍스트를 반환합니다.

```dart
final healthy = await client.health.checkStreaming();
```
