[日本語](README.ja.md) | [简体中文](README.zh-Hans.md) | [Deutsch](README.de.md) | [Français](README.fr.md) | [한국어](README.ko.md)

# mastodon_client

A pure Dart client library for the [Mastodon](https://joinmastodon.org/) API. Provides typed access to all major API categories with built-in OAuth support, cursor-based pagination, and structured error handling.

> **Beta**: API implementation is complete but test coverage is minimal. Response models and method signatures may change based on test findings. See the [changelog](CHANGELOG.md) for details.

## Features

- Covers all major Mastodon API categories (Accounts, Statuses, Timelines, Notifications, Media, and more)
- OAuth 2.0 token management (obtain, revoke, PKCE support)
- Cursor-based pagination via `MastodonPage<T>`
- Sealed exception hierarchy for exhaustive error handling
- Async media upload with automatic v2/v1 fallback and processing polling
- Configurable logging through a swappable `Logger` interface
- Pure Dart — no Flutter dependency required

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  mastodon_client: ^1.0.0-beta.1
```

Then run:

```
dart pub get
```

## Quick Start

```dart
import 'package:mastodon_client/mastodon_client.dart';

void main() async {
  final client = MastodonClient(
    baseUrl: 'https://mastodon.social',
    accessToken: 'YOUR_ACCESS_TOKEN',
  );

  // Fetch the authenticated user
  final me = await client.accounts.verifyCredentials();
  print(me.displayName);

  // Post a status
  await client.statuses.create(
    MastodonStatusCreateRequest(
      status: 'Hello from mastodon_client!',
      visibility: MastodonVisibility.public,
    ),
  );

  // Paginated home timeline
  final page = await client.timelines.fetchHome(limit: 20);
  for (final status in page.items) {
    print(status.content);
  }
}
```

## API Overview

`MastodonClient` exposes the following properties, each covering a distinct area of the Mastodon API:

| Property | Description |
|---|---|
| `accounts` | Account information, search, follow, block, mute, profile updates |
| `statuses` | Create, edit, delete, boost, favourite, bookmark, pin, translate |
| `timelines` | Home, local, federated, hashtag, list timelines |
| `notifications` | Notifications, policies, requests (v1 + grouped v2) |
| `media` | Upload (v2/v1 fallback), async processing, update, delete |
| `search` | Accounts, statuses, hashtags (offset + cursor pagination) |
| `filters` | v2 CRUD with keywords and status entries (+ v1 deprecated) |
| `lists` | List CRUD and account management |
| `oauth` | Token obtain/revoke, server metadata, user info |
| `apps` | Application registration and verification |
| `instance` | Server info (v1/v2), peers, activity, rules, domain blocks |
| `customEmojis` | Custom emoji listing |
| `announcements` | Server announcements and reactions |
| `conversations` | Direct message conversations |
| `polls` | Poll fetching and voting |
| `push` | Web Push subscription management |
| `tags` | Hashtag info, follow/unfollow |
| `trends` | Trending tags, statuses, links |
| `blocks` | Blocked accounts listing |
| `mutes` | Muted accounts listing |
| `domainBlocks` | User-level domain block management |
| `reports` | Report creation |
| `followRequests` | Follow request management |
| `suggestions` | Follow suggestions |
| `favourites` | Favourited statuses listing |
| `bookmarks` | Bookmarked statuses listing |
| `endorsements` | Featured accounts listing |
| `featuredTags` | Featured tags management |
| `followedTags` | Followed tags listing |
| `directory` | Profile directory |
| `preferences` | User preferences |
| `markers` | Timeline read position markers |
| `scheduledStatuses` | Scheduled status management |
| `health` | Server health check |
| `profile` | Avatar/header image management |
| `groupedNotifications` | Grouped notifications (v2) |
| `adminAccounts` | Admin account management |
| `adminReports` | Admin report management |
| `adminDomainBlocks` | Admin domain block management |
| `adminDomainAllows` | Admin domain allow management |
| `adminIpBlocks` | Admin IP block management |
| `adminCanonicalEmailBlocks` | Admin canonical email block management |
| `adminEmailDomainBlocks` | Admin email domain block management |
| `adminTags` | Admin tag management |
| `adminTrends` | Admin trends management |
| `adminMeasures` | Admin quantitative measures |
| `adminDimensions` | Admin categorical dimensions |
| `adminRetention` | Admin user retention cohorts |

## Authentication

Mastodon uses OAuth 2.0. Register an application, redirect the user for authorization, and exchange the code for a token:

```dart
// 1. Register your app
final app = await client.apps.create(
  clientName: 'My App',
  redirectUris: ['urn:ietf:wg:oauth:2.0:oob'],
  scopes: 'read write push',
);

// 2. Direct the user to the authorization URL (platform-dependent)

// 3. Exchange the authorization code for a token
final token = await client.oauth.obtainToken(
  grantType: 'authorization_code',
  clientId: app.clientId!,
  clientSecret: app.clientSecret!,
  redirectUri: 'urn:ietf:wg:oauth:2.0:oob',
  code: authorizationCode,
);

// 4. Create a new client with the token
final authedClient = MastodonClient(
  baseUrl: 'https://mastodon.social',
  accessToken: token.accessToken,
);
```

## Error Handling

All exceptions extend the sealed class `MastodonException`, allowing exhaustive pattern matching:

```dart
try {
  final user = await client.accounts.fetchById('abc123');
} on MastodonUnauthorizedException {
  // 401 — token invalid or expired
} on MastodonForbiddenException {
  // 403 — operation not permitted
} on MastodonNotFoundException {
  // 404 — resource not found
} on MastodonRateLimitException catch (e) {
  // 429 — rate limited; check e.retryAfter
} on MastodonValidationException {
  // 422 — invalid request body
} on MastodonServerException {
  // 5xx — server-side error
} on MastodonNetworkException {
  // Timeout, connection refused, etc.
}
```

## Logging

Enable the built-in stdout logger via `enableLog`, or supply a custom `Logger` implementation:

```dart
class MyLogger implements Logger {
  @override void debug(String message) { /* ... */ }
  @override void info(String message)  { /* ... */ }
  @override void warn(String message)  { /* ... */ }
  @override void error(String message, [Object? error, StackTrace? stackTrace]) { /* ... */ }
}

final client = MastodonClient(
  baseUrl: 'https://mastodon.social',
  logger: MyLogger(),
);
```

## Documentation

- API reference: https://librarylibrarian.github.io/mastodon_client/
- pub.dev page: https://pub.dev/packages/mastodon_client
- GitHub: https://github.com/LibraryLibrarian/mastodon_client

## License

See [LICENSE](LICENSE).
