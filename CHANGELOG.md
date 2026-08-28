# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- **Breaking:** HTTP requests no longer use library-defined 10-second connect,
  receive, or send timeouts. Async media uploads now return the server's HTTP
  202 attachment immediately with a null `url` instead of polling implicitly;
  callers can check progress explicitly with `MediaApi.fetchById()`. Removed
  the now-unused `MastodonMediaProcessingTimeoutException` (issue #46)
- **Breaking:** Account follower, following, and endorsement listings now
  propagate HTTP 403 as `MastodonForbiddenException` instead of silently
  returning an empty page, allowing authorization and scope failures to be
  detected (issue #60)
- **Breaking:** `MastodonStatus.quote` is now a `MastodonQuote?` relationship
  instead of a `MastodonStatus?`, matching Mastodon 4.5 responses. Access the
  embedded status through `status.quote?.quotedStatus`; shallow nested quotes
  expose `quotedStatusId` instead. Edit history now exposes the same entity via
  `MastodonStatusEdit.quote` (issue #43)
- `MastodonNotification` now reads relationship severance details from the
  server's `event` key and exposes admin reports through `report` and the v1
  notification filter flag through `filtered`. Its `toJson()` output now uses
  `event` instead of the incorrect `relationship_severance_event` key (issue #44)
- Removed the unused direct `crypto` dependency and clarified that PKCE support
  is limited to forwarding a caller-provided `code_verifier` during token
  exchange (issue #59)
- **Breaking:** `FiltersApi.update()`, `FiltersApi.updateV1()`, and
  `MastodonAdminIpBlockUpdateRequest.expiresIn` now accept `Optional<int>`
  instead of `int`. Pass `Optional(seconds)` to set an expiration,
  `Optional.null_()` to clear it, or omit the parameter to leave it unchanged
  (issue #61)

### Fixed

- Fixed Web Push subscription updates so `policy` is nested inside `data`,
  documented the server's whole-data replacement behavior, and rejected empty
  updates before they can silently clear existing settings (issue #45)
- `MastodonRateLimitException` now derives `retryAfter` from Mastodon's
  `X-RateLimit-Reset` header when `Retry-After` is unavailable, supports
  HTTP-date values, and exposes `limit`, `remaining`, and `resetAt` (issue #47)

## [1.0.0-beta.3] - 2026-08-25

### Added

- Added the Streaming API over WebSocket, exposed as `client.streaming`, with a single multiplexed connection, reference-counted subscriptions, and typed sealed events (issue #21)
- Added `MastodonStream` covering all twelve official channels, plus `subscribeRaw` for channels this library does not model (issue #21)
- Added automatic streaming endpoint discovery from instance metadata, with normalization of scheme, port, and path (issue #21)
- Added three streaming authentication modes with fallback, close-code-aware reconnection with exponential backoff and jitter, and `suspend()` / `resume()` (issue #21)
- Added `MastodonClient.dispose()` and `HealthApi.checkStreaming()` (issue #21)
- Added Mastodon 4.6 APIs for Collections, Profile, Annual Reports, instance languages, domain block previews, peer search, donation campaigns, unread conversations, notification clearing and policies, and OAuth token inspection (issue #14)
- Added Mastodon 4.5 and 4.6 response fields for media attachments, preview cards, instances, notifications, notification groups, and trend links (issue #17)
- Added automated release branch and pull request creation, version tagging, and `main`-to-`develop` merge-back on top of the existing pub.dev publishing and GitHub Release workflows (issue #38)

### Changed

- **Breaking:** `MastodonCollection.tag` is now a
  `MastodonCollectionTag?` object instead of `String?`, matching Mastodon's
  `{name, url}` response. `MastodonCollection.items` now exposes collection
  item IDs, states, creation times, and conditional account IDs (issue #11)
- **Breaking:** Added value equality (`==` / `hashCode`) and `copyWith` to all
  JSON response models with Freezed. Existing constructors and JSON
  behavior are preserved, while generated `toString` output is disabled to
  avoid exposing model contents in logs (issue #29)
- `MastodonHttpClient` now retains and exposes `baseUrl`, `accessToken`, and `enableLog` (issue #21)
- **Breaking:** `MastodonSuggestion.source` is now nullable and deprecated in
  favor of `sources`. This prevents deserialization failures when Mastodon
  returns `null` or omits the legacy source value (issue #18)
- Deprecated `StatusesApi.fetchCard()`, whose endpoint was removed in Mastodon
  3.0.0. Use the `card` property returned by `StatusesApi.fetch()` instead.
  `fetchCard()` is retained for Mastodon 2.x compatibility and will be removed
  in the next major version (issue #12)

## [1.0.0-beta.2] - 2026-08-13

### Added

- Added CI checks for formatting, static analysis, generated code, unit tests, and package validation on the minimum and stable Dart SDKs (issue #20)
- Added OIDC-based automated publishing to pub.dev for version tags (issue #20)
- Added release version update and verification tooling for pubspec, documentation, CHANGELOG, and release tags (issue #20)
- Added automatic GitHub Release creation from the matching CHANGELOG section after a successful pub.dev publication (issue #20)

### Changed

- **Breaking:** The minimum supported Dart SDK version is now 3.9.0
- Updated runtime and development dependencies, including Dio, json_annotation, logger, build_runner, json_serializable, lints, and test
- Replaced the Flutter-dependent `pedantic_mono` lint configuration with the official Dart `lints/recommended` ruleset, and removed the unused Flutter-dependent `pubspec_dependency_sorter`
- Excluded tests, local build outputs, generated API documentation, and development-only configuration files from published package archives
- **Breaking:** ID fields that some instances return as numbers are now typed `String?` and coerced from either representation, instead of being typed `int` or non-nullable `String`. Code that reads these fields as `int`, or that relies on them being non-null, needs updating:
  - `MastodonRole.id`: `int` (required) → `String?`
  - `MastodonAdminRole.id`: `int` (required) → `String?`
  - `MastodonWebPushSubscription.id`: `String` → `String?`
  - `MastodonNotificationGroup.mostRecentNotificationId`: `String` → `String?`
- **Breaking:** `MastodonOEmbed.title`, `.authorName`, `.authorUrl`, `.providerName`, and `.providerUrl` are now `String?`. Real responses omit them for some providers, so the previous non-nullable typing could not represent them
- `MastodonRole` now lives in `mastodon_account.dart` instead of `mastodon_credential_account.dart`, so that both `MastodonAccount.roles` and `MastodonCredentialAccount.role` can reference it without a circular import. The class itself is unchanged and is still exported from `package:mastodon_client/mastodon_client.dart`
- Refreshed fixtures against a live, federated world (multi-account, cross-server posts/reactions/follows) via the fixture collection tool in `fediverse_e2e`, replacing the single-server March snapshot. Corresponding model tests were updated to assert on structural properties rather than hardcoded IDs/counts where the underlying data is inherently dynamic (timestamps, counters, federated content). Notably `MastodonCredentialAccount`'s `role: Owner` fixture now comes from an actual admin-scoped account rather than a stub

### Added

- `MastodonAccount` fields added in Mastodon 4.6.0: `avatarDescription`, `headerDescription`, `featureApproval` (as `MastodonFeatureApproval`), `showFeatured`, `showMedia`, `showMediaReplies`
- `MastodonStatus.taggedCollections` (Mastodon 4.6.0), listing the `MastodonCollection`s a status has been tagged into. Defaults to an empty list, so servers older than 4.6.0 and existing constructor calls are unaffected
- `MastodonAdminRole.collectionLimit` (Mastodon 4.6.0)
- `MastodonCollection` model, corresponding to `/api/v1/collections` responses
- `httpClientAdapter` parameter on `MastodonClient` / `MastodonHttpClient` to customize the HTTP transport (private CA trust, proxying)
- E2E test layer (`test/e2e/`) targeting the local closed-federation environment (`fediverse_e2e`); enabled via `RUN_E2E=1`, auto-skipped otherwise
- Compatibility E2E suite against Fedibird 3.4.1, pinning which endpoints are available on Mastodon 3.x-era servers and which are not (`/api/v2/instance`, `/api/v2/filters`, `/api/v1/trends/{tags,statuses,links}`, `/api/v1/followed_tags`, `/api/v1/instance/domain_blocks`, and most admin APIs beyond accounts/reports return 404 there)
- Tests for `Link` response header parsing (`parseNextMaxId`/`parsePrevMinId`, used by `MastodonPage` cursor pagination): next/prev-only headers, malformed segments, missing query parameters, and the `min_id`-over-`since_id` precedence for the previous-page cursor
- Tests covering the `unknownEnumValue` fallback for `MastodonFilterAction`, `MastodonTimelineAccessLevel`, `MastodonPreviewCardType`, `MastodonMediaType`, `MastodonVisibility`, `MastodonAdminIpBlockSeverity`, and `MastodonAdminDomainBlockSeverity` when the server returns a value not yet known to this client
- Tests for the HTTP error conversion logic (`convertDioException`): all status-code branches (401/403/404/422/429/5xx/unmapped), error body parsing (`{"error": "..."}` extraction and fallbacks), retry-after header parsing, and network-level errors (connection/timeout/cancel)
- Tests pinning the `int` → `String` coercion of `MastodonRole.id` and `MastodonAdminRole.id`, and the deserialization of every Mastodon 4.6.0 field from a live server response
- `MastodonStatus.card`, exposing the link preview as a `MastodonPreviewCard`. Mastodon added this field in 2.6.0 as the replacement for `GET /api/v1/statuses/:id/card`, then removed the dedicated endpoint in 3.0.0
- `MastodonStatus.filtered`, listing the filters a status matched for the authenticated user as `MastodonFilterResult`s. Without it, the v2 filters already implemented in `FiltersApi` could not be honoured on the timeline side
- `MastodonStatus.application`, the app a status was posted from, as a `MastodonStatusApplication` (`name` / `website` only — the status API does not disclose client credentials)
- `MastodonStatus.quoteApproval` (as `MastodonQuoteApproval`) and `MastodonStatus.quotesCount` (Mastodon 4.5.0)
- `MastodonFilterResult` model, corresponding to the entries of `MastodonStatus.filtered`. Its nested `filter` is serialized without rules, so `MastodonFilter.keywords` and `.statuses` are always empty there
- `MastodonAccount` fields `uri` (ActivityPub identifier), `roles` (publicly visible role badges), `indexable`, and `group`
- `MastodonCredentialAccount` fields that had been added to `MastodonAccount` only: `uri`, `roles`, `indexable`, `group`, `avatarDescription`, `headerDescription`, `featureApproval`, `showFeatured`, `showMedia`, `showMediaReplies`
- `MastodonInstance.wrapstodon` (Mastodon 4.6.0), the year of the annual report campaign currently on offer, or null outside a campaign window
- `MastodonNotification.groupKey`, correlating a v1 notification with its v2 `MastodonNotificationGroup`
- `MastodonRelationship.mutingExpiresAt`, the expiry of a timed mute
- `MastodonSuggestion.sources`, the suggestion reasons in the current vocabulary. `source` is a lossy mapping of the first entry onto the legacy three-value vocabulary
- `MastodonPreferences.readingAutoplayGifs`
- Fixture key coverage test (`test/models/fixture_key_coverage_test.dart`), asserting that every top-level key in a fixture is read back by its model. Ordinary fixture tests cannot catch this class of drift, because `json_serializable` discards unknown keys silently. Fields known to be missing but out of scope are listed explicitly in the test rather than being excluded silently
- `status_filtered.json` fixture, a live response carrying a non-empty `filtered`. It pins that the server returns `status_matches` as `null` rather than an empty array

### Fixed

- `MastodonAdminAccount.role` failed to deserialize with a type cast error against Mastodon 3.x servers and forks such as Fedibird, which return `role` as a plain string (`user` / `moderator` / `admin`) instead of an object. The string form is now accepted and mapped to a `MastodonAdminRole` carrying its name

## [1.0.0-beta.1] - 2026-03-18

### Added

- Core HTTP client with Dio, automatic error conversion, and logging interceptor
- Sealed exception hierarchy (`MastodonException`) mapping HTTP status codes (401, 403, 404, 422, 429, 5xx) and network errors
- Customizable logging via `Logger` interface with `StdoutLogger` and `FunctionLogger` implementations
- Cursor-based pagination with `MastodonPage<T>` and `Link` header parsing
- OAuth token operations (obtain, revoke, server metadata, user info, PKCE support)
- Application registration and verification API
- Account API: fetch, search, lookup, follow, unfollow, block, mute, endorse, relationships, familiar followers, update credentials, create account
- Status API: create, edit, delete, fetch (single/multiple/context/source/history/card/quotes), boost, favourite, bookmark, pin, mute, translate, interaction policy, quote revocation
- Timeline API: home, local, federated, hashtag, list, link timelines
- Notification API: fetch, dismiss, clear, unread count, policies, requests (accept/dismiss/batch), merge status check
- Grouped notifications API (v2)
- Media API: upload with v2/v1 automatic fallback, async processing with polling, fetch, update, delete
- Search API: accounts, statuses, hashtags with offset and cursor-based pagination
- Filter API: v2 CRUD with keywords and status entries, plus v1 deprecated methods
- List API: CRUD, account management
- Conversation API: fetch, mark as read, delete
- Poll API: fetch, vote with `MastodonAlreadyVotedException` handling
- Push API: Web Push subscription create, fetch, update, delete
- Tag API: fetch, follow, unfollow, feature, unfeature
- Trend API: trending tags, statuses, links
- Block, mute, domain block, bookmark, favourite, follow request, followed tag, endorsement, featured tag, suggestion listing APIs
- Instance API: v1/v2 info, peers, activity, rules, domain blocks, extended description, languages
- Custom emoji, announcement (with reactions), directory, health, preference, OEmbed, marker, profile, email confirmation, async refresh APIs
- Scheduled status API: fetch, update, delete
- Report API: create with rule IDs and forward option
- Admin APIs: accounts, reports, domain allows/blocks, IP blocks, canonical email blocks, email domain blocks, tags, trends (with approve/reject), measures, dimensions, retention
- `toJson()` method on all response models
- Deprecated API support: v1 filters, v1 notifications dismiss, v1 search, identity proofs, direct message timeline, pin/unpin (pre-4.4.0)
- Docusaurus documentation site with 20 pages in 6 languages (English, Japanese, Chinese, German, French, Korean)
- GitHub Actions workflow for documentation deployment
- README in 6 languages

[1.0.0-beta.2]: https://github.com/LibraryLibrarian/mastodon_client/releases/tag/v1.0.0-beta.2
[1.0.0-beta.1]: https://github.com/LibraryLibrarian/mastodon_client/releases/tag/v1.0.0-beta.1
