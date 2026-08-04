# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- **Breaking:** ID fields that some instances return as numbers are now typed `String?` and coerced from either representation, instead of being typed `int` or non-nullable `String`. Code that reads these fields as `int`, or that relies on them being non-null, needs updating:
  - `MastodonRole.id`: `int` (required) → `String?`
  - `MastodonAdminRole.id`: `int` (required) → `String?`
  - `MastodonWebPushSubscription.id`: `String` → `String?`
  - `MastodonNotificationGroup.mostRecentNotificationId`: `String` → `String?`
- **Breaking:** `MastodonOEmbed.title`, `.authorName`, `.authorUrl`, `.providerName`, and `.providerUrl` are now `String?`. Real responses omit them for some providers, so the previous non-nullable typing could not represent them
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

[1.0.0-beta.1]: https://github.com/LibraryLibrarian/mastodon_client/releases/tag/v1.0.0-beta.1
