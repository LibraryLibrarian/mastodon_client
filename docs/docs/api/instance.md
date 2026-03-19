---
sidebar_position: 10
---

# Instance & Server

This page covers the APIs for fetching server metadata, custom emojis, announcements, health status, user preferences, the profile directory, oEmbed embeds, and timeline markers.

## Instance information

### Current instance (v2)

```dart
final instance = await client.instance.fetch();
print(instance.title);
print(instance.description);
print(instance.version);
```

Returns a `MastodonInstance` with full v2 metadata including configured languages, rules, and contact information.

### Peer domains

```dart
final peers = await client.instance.fetchPeers();
// List<String> of known federated domains
```

### Weekly activity

```dart
final activity = await client.instance.fetchActivity();
for (final week in activity) {
  print('Statuses: ${week.statuses}');
}
```

Returns up to 12 weeks of `MastodonWeeklyActivity` objects.

### Instance rules

```dart
final rules = await client.instance.fetchRules();
for (final rule in rules) {
  print(rule.text);
}
```

### Domain blocks

```dart
final blocked = await client.instance.fetchDomainBlocks();
```

Returns the list of domains the instance has blocked. This is a server-level list, not the per-user list; see the [Moderation](./moderation.md) page for user-level domain blocks.

### Extended description

```dart
final description = await client.instance.fetchExtendedDescription();
print(description.content);
```

### Privacy policy and terms of service

```dart
final policy = await client.instance.fetchPrivacyPolicy();
final tos = await client.instance.fetchTermsOfService();

// Fetch a specific historical version of the ToS by date
final old = await client.instance.fetchTermsOfServiceByDate('2024-01-01');
```

### Translation languages

```dart
final languages = await client.instance.fetchTranslationLanguages();
// Map<String, List<String>> — source lang → supported target langs
languages.forEach((source, targets) {
  print('$source → $targets');
});
```

### Legacy v1 (deprecated)

```dart
// ignore: deprecated_member_use
final instanceV1 = await client.instance.fetchV1();
```

`fetchV1()` is deprecated as of Mastodon 4.0.0. Prefer `fetch()` unless you need to support older servers.

---

## Custom emojis

```dart
final emojis = await client.customEmojis.fetch();
for (final emoji in emojis) {
  print(':${emoji.shortcode}: → ${emoji.url}');
}
```

No authentication is required. Returns a `List<MastodonCustomEmoji>` of all custom emojis available on the server.

---

## Announcements

### Listing announcements

```dart
final announcements = await client.announcements.fetch();
for (final a in announcements) {
  print(a.text);
}
```

### Dismissing an announcement

```dart
await client.announcements.dismiss('announcement-id');
```

Marks the announcement as read for the authenticated user.

### Reactions

```dart
// Add a reaction (Unicode emoji or custom shortcode)
await client.announcements.addReaction('announcement-id', '👍');
await client.announcements.addReaction('announcement-id', 'blobcat');

// Remove a reaction
await client.announcements.removeReaction('announcement-id', '👍');
```

---

## Health check

```dart
final healthy = await client.health.check();
// Returns true if the web process, database, and cache are all healthy.
// Throws MastodonException if any component is unhealthy.
```

No authentication is required. Useful for monitoring and readiness probes.

---

## User preferences

```dart
final prefs = await client.preferences.fetch();
print(prefs.postingDefaultVisibility);
print(prefs.postingDefaultLanguage);
print(prefs.expandSpoilers);
```

Returns the authenticated user's `MastodonPreferences`. To update preferences, use `client.accounts.updateCredentials()`.

---

## Profile directory

```dart
// Most recently active accounts (global)
final active = await client.directory.fetch(
  order: 'active',
  limit: 40,
);

// Newest local accounts only
final newLocal = await client.directory.fetch(
  order: 'new',
  local: true,
);
```

Parameters:

| Parameter | Default | Max | Description |
|-----------|---------|-----|-------------|
| `limit`   | 40      | 80  | Number of results |
| `offset`  | —       | —   | Skip this many results |
| `order`   | —       | —   | `active` or `new` |
| `local`   | —       | —   | `true` for local accounts only |

No authentication is required.

---

## oEmbed

```dart
final embed = await client.oembed.fetch(
  'https://mastodon.social/@user/12345',
  maxwidth: 500,
);
print(embed.html);
```

Returns a `MastodonOEmbed` with the embeddable HTML for a status URL. No authentication is required.

---

## Timeline markers

Markers let you persist a user's read position in the home timeline and notifications timeline across sessions and devices.

### Fetching markers

```dart
final markers = await client.markers.fetch(['home', 'notifications']);
final home = markers['home'];
print(home?.lastReadId);
```

Pass a list containing `'home'`, `'notifications'`, or both. Returns an empty map if neither is specified.

### Saving markers

```dart
final updated = await client.markers.save(
  homeLastReadId: '109876543210',
  notificationsLastReadId: '987654321',
);
```

At least one of `homeLastReadId` or `notificationsLastReadId` must be provided. If the server responds with `409 Conflict` (write conflict from another device), retry the request.

```dart
// Retry on conflict example
Map<String, MastodonMarker> result;
while (true) {
  try {
    result = await client.markers.save(homeLastReadId: lastId);
    break;
  } on MastodonConflictException {
    // Small delay before retry
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
```
