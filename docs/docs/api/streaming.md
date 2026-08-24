---
sidebar_position: 15
---

# Streaming

The `client.streaming` API delivers real-time updates over the Mastodon Streaming API (WebSocket). A single connection multiplexes every subscription, so subscribing to several channels does not open several sockets.

Accessing `client.streaming` does not open a connection. The socket is opened only when `connect()` is called, so REST-only applications never touch the network through this API.

## Connecting

```dart
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_token',
);

await client.streaming.connect();
```

The endpoint is discovered automatically. The client reads `configuration.urls.streaming` from `GET /api/v2/instance`, falls back to `urls.streaming_api` from `GET /api/v1/instance`, and finally reuses the REST host. The resolved value is normalized: `http` becomes `ws`, `https` becomes `wss`, the port is preserved, and `/api/v1/streaming` is appended when missing.

Streaming requires an access token in every case, including public channels. Anonymous access was removed in Mastodon v4.2.0.

## Subscribing

```dart
final home = await client.streaming.subscribe(const MastodonStream.user());

home.events.listen((event) {
  switch (event) {
    case MastodonUpdateEvent(:final status):
      print(status.content);
    case MastodonStatusUpdateEvent(:final status):
      print('edited: ${status.id}');
    case MastodonDeleteEvent(:final statusId):
      print('deleted: $statusId');
    case MastodonNotificationEvent(:final notification):
      print(notification.type);
    case MastodonUnknownStreamEvent(:final event):
      print('unknown event: $event');
    default:
      break;
  }
});

await home.cancel();
```

Each subscription handle exposes three layers:

| Property | Type | Contents |
|---|---|---|
| `events` | `Stream<MastodonStreamEvent>` | Typed, sealed events |
| `statuses` | `Stream<MastodonStatus>` | Statuses from `update` and `status.update` |
| `messages` | `Stream<MastodonStreamingMessage>` | Raw envelopes with an undecoded payload |

## Channels

Channels are described by the sealed `MastodonStream` type.

| Factory | Wire name |
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

`local` and `remote` cannot both be true — no such channel exists on the server, and the combination is rejected by an assertion.

For channels this library does not model, such as those added by Mastodon forks, use `subscribeRaw`:

```dart
final raw = await client.streaming.subscribeRaw('someCustomStream');
raw.messages.listen((message) => print(message.payload));
```

## Reference counting

Mastodon silently ignores a second `subscribe` for a channel that is already active, so the client keeps a reference count. The `subscribe` frame is sent when the count goes from zero to one, and `unsubscribe` when it returns to zero.

Hashtag keys are normalized to lower case for this purpose. Subscribing to `Dart` and `dart` without normalization would collide on the server side and leave the second subscriber without events.

```dart
final a = await client.streaming.subscribe(const MastodonStream.hashtag('Dart'));
final b = await client.streaming.subscribe(const MastodonStream.hashtag('dart'));

await a.cancel(); // No unsubscribe yet — b is still active.
await b.cancel(); // Now unsubscribe is sent.
```

## Errors

A successful subscription produces no acknowledgement, and server errors carry no channel name or correlation ID. Subscription frames are therefore serialized, and an error arriving during the quiet window that follows is attributed to the most recent request.

```dart
try {
  await client.streaming.subscribe(const MastodonStream.list('999'));
} on MastodonStreamingSubscriptionException catch (e) {
  print('${e.message} (${e.status})');
}
```

`MastodonStreamingSubscriptionException.status` is nullable because the server omits `status` from `unsubscribe` errors.

Connection-level failures surface as `MastodonStreamingConnectionException`, and unexpected closures as `MastodonStreamingClosedException`. Both are also emitted on `client.streaming.errors` for applications that prefer to observe rather than catch.

## Reconnection and lifecycle

Reconnection is automatic, with exponential backoff and jitter capped by `MastodonStreamingConfig.reconnectMaxDelay`. Every active subscription is resent once the replacement connection is usable, because subscription state lives on the connection.

Close codes are treated differently:

| Close code | Behavior |
|---|---|
| `1000` | Normal closure. No reconnection. |
| `1003` | The server rejected a binary frame. Reported as an error without retrying. |
| `1005` | No close frame. May indicate a revoked token, so the client does not retry blindly. |
| Others | Reconnect with backoff. |

An HTTP 401 during the handshake is raised immediately instead of entering the retry loop, since retrying an invalid token cannot succeed.

Use `suspend()` and `resume()` when the application moves to and from the background, and release everything with `dispose()`:

```dart
await client.streaming.suspend();
await client.streaming.resume();

await client.dispose();
```

`MastodonClient.dispose()` closes the streaming connection and the HTTP transport. It does not create a streaming client if one was never used.

## Configuration

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

Three authentication modes are supported. The default, `subprotocol`, sends the token as the only WebSocket subprotocol; it works on every platform including the web and keeps the token out of access logs. `header` requires `dart:io`, and `queryParameter` is a legacy mode that exposes the token in the URL. When `enableAuthFallback` is left enabled, the remaining modes are tried after a failure and the successful mode is preferred on later reconnections. Tokens are always redacted from log output.

## Things to know

These behaviors come from the Mastodon streaming server itself and regularly look like client bugs.

- A token limited to `read:statuses` receives home statuses on `user`, but receives no notifications at all — without any error. Notifications require `read` or `read:notifications`.
- `only_media` is ignored over WebSocket. Media-only behavior must be selected through the channel name.
- Subscribing to both `user` and `user:notification` delivers every notification twice, because the server treats them as distinct channel sets. `user` alone is enough.
- `update` and `status.update` on public and hashtag channels can be dropped silently by language preferences, feed access settings (Mastodon v4.5 and later), blocks, mutes, and domain blocks. A public stream that stays quiet is not necessarily broken.
- `filters_changed` is defined as an event type but is not delivered to clients on Mastodon v4.3 and later, because the server discards payload-free messages.
- Events produced while the socket is disconnected are not replayed after reconnection. Fill the gap through REST endpoints using `since_id` or `min_id`.

## Health check

The streaming process exposes its own health endpoint, which returns plain text rather than JSON:

```dart
final healthy = await client.health.checkStreaming();
```
