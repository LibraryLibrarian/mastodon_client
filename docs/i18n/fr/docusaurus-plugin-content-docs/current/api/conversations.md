---
sidebar_position: 9
---

# Conversations et sondages

## Conversations

L'API `client.conversations` gère les conversations en message direct — des fils composés de statuts avec `visibility: direct`.

### Récupérer les conversations

```dart
final page = await client.conversations.fetch(limit: 20);

for (final conversation in page.items) {
  print(conversation.id);
  print(conversation.unread);
  print(conversation.accounts.map((a) => a.acct).join(', '));
  if (conversation.lastStatus != null) {
    print(conversation.lastStatus!.content);
  }
}
```

Retourne `MastodonPage<MastodonConversation>`. Utilisez `nextMaxId` et `prevMinId` pour la pagination :

```dart
MastodonPage<MastodonConversation>? page = await client.conversations.fetch();

while (page != null && page.nextMaxId != null) {
  page = await client.conversations.fetch(maxId: page.nextMaxId);
  for (final conversation in page.items) {
    print(conversation.id);
  }
}
```

Paramètres de pagination :

| Paramètre | Description |
|-----------|-------------|
| `limit`   | Nombre maximum de résultats (défaut : 20, max : 40) |
| `maxId`   | Retourner les conversations plus anciennes que cet ID |
| `sinceId` | Retourner les conversations plus récentes que cet ID |
| `minId`   | Retourner les conversations immédiatement après cet ID (pagination en avant) |

### Marquer une conversation comme lue

```dart
final conversation = await client.conversations.markAsRead('7');
print(conversation.unread); // false
```

Retourne la `MastodonConversation` mise à jour.

### Supprimer une conversation

```dart
await client.conversations.delete('7');
```

### Le modèle MastodonConversation

| Champ | Type | Description |
|-------|------|-------------|
| `id` | `String` | ID interne de la conversation |
| `unread` | `bool` | Indique si la conversation contient des messages non lus |
| `accounts` | `List<MastodonAccount>` | Participants (excluant l'utilisateur authentifié) |
| `lastStatus` | `MastodonStatus?` | Statut le plus récent de la conversation, ou `null` |

---

## Sondages

L'API `client.polls` permet de récupérer des sondages et de soumettre des votes. Les sondages sont généralement attachés à des statuts ; utilisez `status.poll` pour obtenir l'ID du sondage.

### Récupérer un sondage

```dart
final poll = await client.polls.fetch('34');
print(poll.votesCount);
print(poll.expired);

for (final option in poll.options) {
  print('${option.title}: ${option.votesCount ?? "hidden"}');
}
```

### Voter dans un sondage

Passez une liste d'indices d'options (base zéro). Pour les sondages à choix unique, passez exactement un indice.

```dart
// Single choice
final poll = await client.polls.vote('34', [0]);

// Multiple choices (allowed when poll.multiple == true)
final poll = await client.polls.vote('34', [0, 2]);

print(poll.voted);    // true
print(poll.ownVotes); // e.g. [0, 2]
```

Lève `MastodonAlreadyVotedException` si l'utilisateur authentifié a déjà voté.

### Le modèle MastodonPoll

| Champ | Type | Description |
|-------|------|-------------|
| `id` | `String` | ID interne du sondage |
| `expiresAt` | `DateTime?` | Horodatage d'expiration |
| `expired` | `bool` | Indique si le sondage est terminé |
| `multiple` | `bool` | Indique si plusieurs choix sont autorisés |
| `votesCount` | `int` | Nombre total de votes exprimés |
| `votersCount` | `int?` | Nombre de votants uniques (diffère de `votesCount` pour les sondages à choix multiple) |
| `options` | `List<MastodonPollOption>` | Options disponibles |
| `emojis` | `List<MastodonCustomEmoji>` | Emojis personnalisés utilisés dans le texte des options |
| `voted` | `bool?` | Indique si l'utilisateur authentifié a voté |
| `ownVotes` | `List<int>?` | Indices des options choisies par l'utilisateur authentifié |

Champs de `MastodonPollOption` :

| Champ | Type | Description |
|-------|------|-------------|
| `title` | `String` | Texte de l'option |
| `votesCount` | `int?` | Votes pour cette option ; `null` pour les sondages non publics |
