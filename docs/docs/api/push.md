---
sidebar_position: 8
---

# Push Notifications

The `client.push` API manages Web Push subscriptions. It follows the [Web Push Protocol](https://www.rfc-editor.org/rfc/rfc8030) and allows your application to receive notifications in the background.

## Subscribing

Create a new Web Push subscription by providing your push endpoint and VAPID keys:

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
print(subscription.serverKey); // use to verify incoming pushes
```

### Alert types

`MastodonPushAlertSettings` accepts any combination of the following fields. Fields set to `null` are omitted from the request. On creation, omitted fields use the server defaults. Updates replace the whole settings object as described below.

| Field | Description |
|-------|-------------|
| `mention` | Mentioned in a status |
| `quote` | Status was quoted |
| `status` | New post from a followed user |
| `reblog` | Status was boosted |
| `follow` | New follower |
| `followRequest` | New follow request |
| `favourite` | Status was favourited |
| `poll` | A poll you voted in or created has ended |
| `update` | A status you interacted with was edited |
| `quotedUpdate` | A quoted status was edited |
| `adminSignUp` | New user sign-up (admin only) |
| `adminReport` | New report (admin only) |

### Policy values

| Value | Description |
|-------|-------------|
| `all` | Receive notifications from all users |
| `followed` | Receive notifications only from users you follow |
| `follower` | Receive notifications only from your followers |
| `none` | Disable all push notifications |

## Fetching the current subscription

```dart
final subscription = await client.push.fetch();
print(subscription.endpoint);
print(subscription.alerts.mention);
print(subscription.policy);
```

## Updating alert settings

Use `update` to replace the subscription's `data` portion (alerts and policy) without recreating the subscription. This is not a partial update: every omitted alert type becomes disabled, and omitting `policy` resets it to `all`. Send every alert type that should remain enabled. A request with neither `alerts` nor `policy` throws `ArgumentError` before sending an HTTP request.

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

To explicitly disable every alert and reset the policy to `all`, send an empty alert settings object:

```dart
await client.push.update(
  const MastodonPushSubscriptionUpdateRequest(
    alerts: MastodonPushAlertSettings(),
  ),
);
```

## Unsubscribing

```dart
await client.push.delete();
```

Deletes the current Web Push subscription. Subsequent calls to `fetch` will throw a `MastodonNotFoundException`.

## The MastodonWebPushSubscription model

| Field | Type | Description |
|-------|------|-------------|
| `id` | `String` | Subscription ID |
| `endpoint` | `String` | Push endpoint URL |
| `serverKey` | `String` | Server public key for verifying push messages |
| `alerts` | `MastodonPushAlerts` | Active alert settings |
| `policy` | `String` | Notification policy |
| `standard` | `bool?` | Whether the subscription conforms to the standardized Web Push spec (Mastodon 4.4+) |
