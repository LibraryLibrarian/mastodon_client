---
sidebar_position: 3
---

# Benachrichtigungen

Die `client.notifications`-API verwaltet das Abrufen, Schließen und Konfigurieren von Benachrichtigungen.

## Benachrichtigungen abrufen

### Liste

```dart
final page = await client.notifications.fetch(limit: 20);

for (final n in page.items) {
  print('${n.type}: ${n.account?.displayName}');
}
```

### Nach Typ filtern

```dart
// Only mentions and favourites
final page = await client.notifications.fetch(
  types: ['mention', 'favourite'],
);

// Everything except follows
final page = await client.notifications.fetch(
  excludeTypes: ['follow'],
);
```

### Einzelne Benachrichtigung

```dart
final notification = await client.notifications.fetchById('12345');
```

### Benachrichtigungsspezifische Details

Einige v1-Benachrichtigungen enthalten zusätzliche Details:

```dart
final event = notification.relationshipSeveranceEvent; // severed_relationships
final report = notification.report;                    // admin.report
final wasFiltered = notification.filtered;             // Mastodon 4.3+
```

`filtered` ist standardmäßig false, da der Server das Feld nur bei true sendet.
Gruppierte v2-Benachrichtigungen stellen Trennungsdetails als `group.event` und
Meldungen als `group.report` bereit; sie besitzen kein `filtered`-Feld pro
Benachrichtigung.

### Anzahl ungelesener Benachrichtigungen (Mastodon 4.3+)

```dart
final count = await client.notifications.fetchUnreadCount();
print(count.count);
```

## Benachrichtigungen schließen

### Einzelne schließen

```dart
await client.notifications.dismiss('12345');
```

### Alle verwerfen

```dart
await client.notifications.clear();
```

## Benachrichtigungsrichtlinie (Mastodon 4.3+)

### Aktuelle Richtlinie abrufen

```dart
final policy = await client.notifications.fetchPolicy();
print(policy.forNotFollowing); // accept, filter, drop
```

### Richtlinie aktualisieren

```dart
await client.notifications.updatePolicy(policy);
```

## Benachrichtigungsanfragen (Mastodon 4.3+)

Gefilterte Benachrichtigungen von Accounts, die der Richtlinie entsprechen, werden als Anfragen gesammelt.

### Anfragen auflisten

```dart
final page = await client.notifications.fetchRequests(limit: 20);
```

### Annehmen / Ablehnen

```dart
// Single
await client.notifications.acceptRequest('12345');
await client.notifications.dismissRequest('12345');

// Batch
await client.notifications.acceptRequests(['1', '2', '3']);
await client.notifications.dismissRequests(['4', '5']);
```

### Zusammenführungsstatus prüfen

```dart
final merged = await client.notifications.checkRequestsMerged();
if (merged) {
  // Accepted requests have been merged into the notification list
}
```

## Gruppierte Benachrichtigungen (v2)

Für die gruppierte Benachrichtigungs-API `client.groupedNotifications` verwenden:

```dart
final result = await client.groupedNotifications.fetch(limit: 20);
for (final group in result.notificationGroups) {
  print('${group.type}: ${group.notificationsCount} notifications');
}
```
