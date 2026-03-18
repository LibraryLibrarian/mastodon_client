---
sidebar_position: 10
---

# Instance et serveur

Cette page couvre les APIs pour récupérer les métadonnées du serveur, les emojis personnalisés, les annonces, l'état de santé, les préférences utilisateur, le répertoire de profils, les intégrations oEmbed et les marqueurs de fil.

## Informations sur l'instance

### Instance courante (v2)

```dart
final instance = await client.instance.fetch();
print(instance.title);
print(instance.description);
print(instance.version);
```

Retourne un `MastodonInstance` avec les métadonnées v2 complètes incluant les langues configurées, les règles et les informations de contact.

### Domaines pairs

```dart
final peers = await client.instance.fetchPeers();
// List<String> of known federated domains
```

### Activité hebdomadaire

```dart
final activity = await client.instance.fetchActivity();
for (final week in activity) {
  print('Statuses: ${week.statuses}');
}
```

Retourne jusqu'à 12 semaines d'objets `MastodonWeeklyActivity`.

### Règles de l'instance

```dart
final rules = await client.instance.fetchRules();
for (final rule in rules) {
  print(rule.text);
}
```

### Domaines bloqués

```dart
final blocked = await client.instance.fetchDomainBlocks();
```

Retourne la liste des domaines bloqués par l'instance. Il s'agit d'une liste au niveau du serveur, pas de la liste par utilisateur ; voir la page [Modération](./moderation.md) pour les blocages de domaines par utilisateur.

### Description étendue

```dart
final description = await client.instance.fetchExtendedDescription();
print(description.content);
```

### Politique de confidentialité et conditions d'utilisation

```dart
final policy = await client.instance.fetchPrivacyPolicy();
final tos = await client.instance.fetchTermsOfService();

// Fetch a specific historical version of the ToS by date
final old = await client.instance.fetchTermsOfServiceByDate('2024-01-01');
```

### Langues de traduction

```dart
final languages = await client.instance.fetchTranslationLanguages();
// Map<String, List<String>> — source lang → supported target langs
languages.forEach((source, targets) {
  print('$source → $targets');
});
```

### Ancienne v1 (dépréciée)

```dart
// ignore: deprecated_member_use
final instanceV1 = await client.instance.fetchV1();
```

`fetchV1()` est dépréciée depuis Mastodon 4.0.0. Préférez `fetch()` sauf si vous devez prendre en charge des serveurs plus anciens.

---

## Emojis personnalisés

```dart
final emojis = await client.customEmojis.fetch();
for (final emoji in emojis) {
  print(':${emoji.shortcode}: → ${emoji.url}');
}
```

Aucune authentification n'est requise. Retourne une `List<MastodonCustomEmoji>` de tous les emojis personnalisés disponibles sur le serveur.

---

## Annonces

### Lister les annonces

```dart
final announcements = await client.announcements.fetch();
for (final a in announcements) {
  print(a.text);
}
```

### Rejeter une annonce

```dart
await client.announcements.dismiss('announcement-id');
```

Marque l'annonce comme lue pour l'utilisateur authentifié.

### Réactions

```dart
// Add a reaction (Unicode emoji or custom shortcode)
await client.announcements.addReaction('announcement-id', '👍');
await client.announcements.addReaction('announcement-id', 'blobcat');

// Remove a reaction
await client.announcements.removeReaction('announcement-id', '👍');
```

---

## Vérification d'état

```dart
final healthy = await client.health.check();
// Returns true if the web process, database, and cache are all healthy.
// Throws MastodonException if any component is unhealthy.
```

Aucune authentification n'est requise. Utile pour la surveillance et les sondes de disponibilité.

---

## Préférences utilisateur

```dart
final prefs = await client.preferences.fetch();
print(prefs.postingDefaultVisibility);
print(prefs.postingDefaultLanguage);
print(prefs.expandSpoilers);
```

Retourne les `MastodonPreferences` de l'utilisateur authentifié. Pour mettre à jour les préférences, utilisez `client.accounts.updateCredentials()`.

---

## Répertoire de profils

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

Paramètres :

| Paramètre | Défaut | Max | Description |
|-----------|--------|-----|-------------|
| `limit`   | 40     | 80  | Nombre de résultats |
| `offset`  | —      | —   | Sauter ce nombre de résultats |
| `order`   | —      | —   | `active` ou `new` |
| `local`   | —      | —   | `true` pour les comptes locaux uniquement |

Aucune authentification n'est requise.

---

## oEmbed

```dart
final embed = await client.oembed.fetch(
  'https://mastodon.social/@user/12345',
  maxwidth: 500,
);
print(embed.html);
```

Retourne un `MastodonOEmbed` avec le HTML intégrable pour une URL de statut. Aucune authentification n'est requise.

---

## Marqueurs de fil

Les marqueurs vous permettent de persister la position de lecture d'un utilisateur dans le fil personnel et le fil des notifications entre les sessions et les appareils.

### Récupérer les marqueurs

```dart
final markers = await client.markers.fetch(['home', 'notifications']);
final home = markers['home'];
print(home?.lastReadId);
```

Passez une liste contenant `'home'`, `'notifications'`, ou les deux. Retourne une map vide si aucun n'est spécifié.

### Sauvegarder les marqueurs

```dart
final updated = await client.markers.save(
  homeLastReadId: '109876543210',
  notificationsLastReadId: '987654321',
);
```

Au moins l'un de `homeLastReadId` ou `notificationsLastReadId` doit être fourni. Si le serveur répond avec `409 Conflict` (conflit d'écriture depuis un autre appareil), relancez la requête.

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
