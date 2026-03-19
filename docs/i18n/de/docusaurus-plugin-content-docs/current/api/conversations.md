---
sidebar_position: 9
---

# Konversationen und Umfragen

## Konversationen

Die `client.conversations`-API verwaltet Direktnachrichten-Konversationen — Threads, die aus Statusmeldungen mit `visibility: direct` bestehen.

### Konversationen abrufen

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

Gibt `MastodonPage<MastodonConversation>` zurück. Verwende `nextMaxId` und `prevMinId` zur Paginierung:

```dart
MastodonPage<MastodonConversation>? page = await client.conversations.fetch();

while (page != null && page.nextMaxId != null) {
  page = await client.conversations.fetch(maxId: page.nextMaxId);
  for (final conversation in page.items) {
    print(conversation.id);
  }
}
```

Paginierungsparameter:

| Parameter | Beschreibung |
|-----------|-------------|
| `limit`   | Maximale Ergebnisanzahl (Standard: 20, max: 40) |
| `maxId`   | Konversationen älter als diese ID zurückgeben |
| `sinceId` | Konversationen neuer als diese ID zurückgeben |
| `minId`   | Konversationen unmittelbar nach dieser ID zurückgeben (Vorwärts-Paginierung) |

### Konversation als gelesen markieren

```dart
final conversation = await client.conversations.markAsRead('7');
print(conversation.unread); // false
```

Gibt das aktualisierte `MastodonConversation` zurück.

### Konversation löschen

```dart
await client.conversations.delete('7');
```

### Das MastodonConversation-Modell

| Feld | Typ | Beschreibung |
|------|-----|-------------|
| `id` | `String` | Interne Konversations-ID |
| `unread` | `bool` | Ob die Konversation ungelesene Nachrichten hat |
| `accounts` | `List<MastodonAccount>` | Teilnehmer (ohne den authentifizierten Benutzer) |
| `lastStatus` | `MastodonStatus?` | Neueste Statusmeldung der Konversation, oder `null` |

---

## Umfragen

Die `client.polls`-API ermöglicht das Abrufen von Umfragen und das Einreichen von Stimmen. Umfragen sind in der Regel an Statusmeldungen angehängt; verwende `status.poll`, um die Umfrage-ID zu erhalten.

### Umfrage abrufen

```dart
final poll = await client.polls.fetch('34');
print(poll.votesCount);
print(poll.expired);

for (final option in poll.options) {
  print('${option.title}: ${option.votesCount ?? "hidden"}');
}
```

### In einer Umfrage abstimmen

Eine Liste nullbasierter Optionsindizes übergeben. Bei Einzelauswahl-Umfragen genau einen Index angeben.

```dart
// Single choice
final poll = await client.polls.vote('34', [0]);

// Multiple choices (allowed when poll.multiple == true)
final poll = await client.polls.vote('34', [0, 2]);

print(poll.voted);    // true
print(poll.ownVotes); // e.g. [0, 2]
```

Wirft `MastodonAlreadyVotedException`, wenn der authentifizierte Benutzer bereits abgestimmt hat.

### Das MastodonPoll-Modell

| Feld | Typ | Beschreibung |
|------|-----|-------------|
| `id` | `String` | Interne Umfrage-ID |
| `expiresAt` | `DateTime?` | Ablaufzeitpunkt |
| `expired` | `bool` | Ob die Umfrage beendet ist |
| `multiple` | `bool` | Ob Mehrfachauswahl erlaubt ist |
| `votesCount` | `int` | Gesamtanzahl abgegebener Stimmen |
| `votersCount` | `int?` | Anzahl eindeutiger Wähler (weicht bei Mehrfachauswahl von `votesCount` ab) |
| `options` | `List<MastodonPollOption>` | Verfügbare Optionen |
| `emojis` | `List<MastodonCustomEmoji>` | Benutzerdefinierte Emojis im Optionstext |
| `voted` | `bool?` | Ob der authentifizierte Benutzer abgestimmt hat |
| `ownVotes` | `List<int>?` | Indizes der vom authentifizierten Benutzer gewählten Optionen |

`MastodonPollOption`-Felder:

| Feld | Typ | Beschreibung |
|------|-----|-------------|
| `title` | `String` | Optionstext |
| `votesCount` | `int?` | Stimmen für diese Option; `null` bei nicht-öffentlichen Umfragen |
