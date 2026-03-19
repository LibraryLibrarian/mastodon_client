---
sidebar_position: 3
---

# Notifications

L'API `client.notifications` gère la récupération des notifications, leur rejet et les politiques associées.

## Récupérer les notifications

### Liste

```dart
final page = await client.notifications.fetch(limit: 20);

for (final n in page.items) {
  print('${n.type}: ${n.account?.displayName}');
}
```

### Filtrer par type

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

### Notification unique

```dart
final notification = await client.notifications.fetchById('12345');
```

### Nombre non lus (Mastodon 4.3+)

```dart
final count = await client.notifications.fetchUnreadCount();
print(count.count);
```

## Rejeter des notifications

### Rejeter une notification

```dart
await client.notifications.dismiss('12345');
```

### Tout effacer

```dart
await client.notifications.clear();
```

## Politique de notification (Mastodon 4.3+)

### Récupérer la politique actuelle

```dart
final policy = await client.notifications.fetchPolicy();
print(policy.forNotFollowing); // accept, filter, drop
```

### Mettre à jour la politique

```dart
await client.notifications.updatePolicy(policy);
```

## Demandes de notification (Mastodon 4.3+)

Les notifications filtrées provenant de comptes correspondant à la politique sont collectées sous forme de demandes.

### Lister les demandes

```dart
final page = await client.notifications.fetchRequests(limit: 20);
```

### Accepter / rejeter

```dart
// Single
await client.notifications.acceptRequest('12345');
await client.notifications.dismissRequest('12345');

// Batch
await client.notifications.acceptRequests(['1', '2', '3']);
await client.notifications.dismissRequests(['4', '5']);
```

### Vérifier le statut de fusion

```dart
final merged = await client.notifications.checkRequestsMerged();
if (merged) {
  // Accepted requests have been merged into the notification list
}
```

## Notifications groupées (v2)

Pour l'API de notifications groupées, utilisez `client.groupedNotifications` :

```dart
final result = await client.groupedNotifications.fetch(limit: 20);
for (final group in result.notificationGroups) {
  print('${group.type}: ${group.notificationsCount} notifications');
}
```
