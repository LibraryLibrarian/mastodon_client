# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/LibraryLibrarian/mastodon_client/commits/main
