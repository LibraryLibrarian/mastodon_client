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

### Capacités dépendantes de la version

Utilisez `detectCapabilities()` avant de proposer des fonctionnalités ajoutées dans
les versions récentes de Mastodon :

```dart
final capabilities = await client.instance.detectCapabilities();

switch (capabilities.supportFor(MastodonCapability.collections)) {
  case MastodonCapabilitySupport.supported:
    // Proposer les fonctionnalités liées aux collections.
  case MastodonCapabilitySupport.unsupported:
    // Masquer ou désactiver les fonctionnalités liées aux collections.
  case MastodonCapabilitySupport.unknown:
    // Utiliser un repli prudent ou laisser l'utilisateur essayer.
}
```

| Capability | Fonction serveur | Version minimale de Mastodon | Niveau d'évolution de l'API |
|---|---|---:|---:|
| `tagFeaturing` | Mettre en avant un tag ou cesser de le mettre en avant | 4.4.0 | 6 |
| `annualReportDetails` | Récupérer un rapport annuel par année | 4.4.0 | 6 |
| `oauthUserInfo` | Informations OpenID Connect | 4.4.0 | 6 |
| `asyncRefreshes` | État expérimental d'actualisation asynchrone | 4.4.0 | 6 |
| `quotePosts` | Opérations de citation de publications | 4.5.0 | 7 |
| `collections` | Endpoints de collections | 4.6.0 | 10 |
| `donationCampaigns` | Endpoint de campagne de dons | 4.6.0 | 10 |
| `editableProfile` | Récupérer ou mettre à jour le profil modifiable | 4.6.0 | 10 |
| `annualReportGeneration` | Générer un rapport ou lire son état | 4.6.0 | 10 |

La détection applique les règles suivantes :

1. Effectuer une requête `GET` vers `/api/v2/instance` et privilégier
   `api_versions.mastodon`.
2. Si ce champ manque, analyser le préfixe `major.minor.patch` de
   `MastodonInstance.version` comme solution de repli indicative.
3. Si l'endpoint v2 lui-même renvoie une réponse 404, interroger l'ancien
   endpoint `GET /api/v1/instance` et utiliser sa chaîne de version. Les autres
   erreurs sont propagées sans repli.
4. Retourner `unknown` si les métadonnées disponibles sont ininterprétables.

Mettez le résultat en cache une fois par serveur pendant la durée du processus
de l'application, au lieu de redemander les métadonnées avant chaque appel API.

`api_versions.mastodon` représente un niveau d'évolution de l'API, et non une
version de Mastodon. Il peut augmenter dans une version corrective ou lors
d'une modification sans nouvelle route, rester identique pour plusieurs
versions et sauter des entiers. Utilisez uniquement les seuils minimaux du
tableau ; n'en déduisez pas une version de Mastodon.

Les résultats sont indicatifs. Les forks et implémentations compatibles peuvent
différer des métadonnées annoncées : gérez toujours les erreurs de l'appel API
réel. Une réponse 404 ne distingue notamment pas de manière fiable un endpoint
absent d'une ressource absente.

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
