---
sidebar_position: 1
slug: /
---

# Getting Started

mastodon_client is a pure Dart Mastodon API client library.
It works in any environment where Dart runs: Flutter, server-side Dart, CLI tools, and more.

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  mastodon_client: ^0.0.1
```

Then fetch it:

```bash
dart pub get
```

## Basic Usage

### Initializing the client

```dart
import 'package:mastodon_client/mastodon_client.dart';

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'your_access_token',
);
```

`baseUrl` must include the scheme (e.g. `https://`).
`accessToken` can be omitted when only using endpoints that do not require authentication.

### Your first API call

Fetching server information (no authentication required):

```dart
final instance = await client.instance.fetch();
print(instance.title);       // Server name
print(instance.description); // Server description
```

Fetching the authenticated user's account:

```dart
final me = await client.accounts.verifyCredentials();
print(me.displayName); // Display name
print(me.acct);        // Username
```

### API structure

Every API is exposed as a property on `MastodonClient`, acting as a namespace:

```dart
client.accounts      // Account operations
client.statuses      // Status operations
client.timelines     // Timeline retrieval
client.notifications // Notification operations
client.media         // Media upload
client.search        // Search
client.oauth         // OAuth token operations
// ... and many more
```

### Controlling log output

HTTP request/response logs are printed to stdout by default.

```dart
// Disable logging
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  enableLog: false,
);

// Use a custom logger
final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: 'token',
  logger: FunctionLogger((level, message) {
    // Your custom log handling
  }),
);
```

See [Logging](./advanced/logging.md) for details.

## Next steps

- [Authentication](./authentication.md) — Obtaining access tokens via OAuth
- [Pagination](./pagination.md) — Cursor-based pagination
- [Error Handling](./error-handling.md) — Exception hierarchy and catch patterns
