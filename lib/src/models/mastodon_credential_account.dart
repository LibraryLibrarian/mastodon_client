import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_custom_emoji.dart';

part 'mastodon_credential_account.freezed.dart';
part 'mastodon_credential_account.g.dart';

/// Account information of the authenticated user.
///
/// Includes all [MastodonAccount] fields plus additional information
/// available only to authenticated users, such as `source` (default posting
/// settings) and `role` (user role).
///
/// Corresponds to responses from `/api/v1/accounts/verify_credentials`,
/// `/api/v1/accounts/update_credentials`,
/// `DELETE /api/v1/profile/avatar|header`, etc.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCredentialAccount with _$MastodonCredentialAccount {
  const MastodonCredentialAccount({
    required this.id,
    required this.username,
    required this.acct,
    required this.displayName,
    required this.note,
    required this.url,
    required this.avatarUrl,
    required this.avatarStaticUrl,
    required this.headerUrl,
    required this.headerStaticUrl,
    required this.locked,
    required this.bot,
    required this.followersCount,
    required this.followingCount,
    required this.statusesCount,
    required this.fields,
    required this.emojis,
    this.uri,
    this.discoverable,
    this.indexable,
    this.group,
    this.noindex,
    this.createdAt,
    this.lastStatusAt,
    this.moved,
    this.suspended,
    this.limited,
    this.hideCollections,
    this.avatarBlurhash,
    this.headerBlurhash,
    this.avatarDescription,
    this.headerDescription,
    this.featureApproval,
    this.showFeatured,
    this.showMedia,
    this.showMediaReplies,
    this.roles = const <MastodonRole>[],
    this.source,
    this.role,
  });

  factory MastodonCredentialAccount.fromJson(Map<String, dynamic> json) =>
      _$MastodonCredentialAccountFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonCredentialAccountToJson(this);

  /// Internal ID of the account.
  @override
  final String id;

  /// Username within the instance.
  @override
  final String username;

  /// Fully qualified account name.
  @override
  final String acct;

  /// Display name.
  @JsonKey(defaultValue: '')
  @override
  final String displayName;

  /// Profile bio (HTML format).
  @JsonKey(defaultValue: '')
  @override
  final String note;

  /// Profile page URL.
  @JsonKey(defaultValue: '')
  @override
  final String url;

  /// ActivityPub URI identifying the account.
  ///
  /// Differs from [url], which points at the human-readable profile page.
  @override
  final String? uri;

  /// URL of the avatar image (animated version).
  @JsonKey(name: 'avatar', defaultValue: '')
  @override
  final String avatarUrl;

  /// URL of the avatar image (static version).
  @JsonKey(name: 'avatar_static', defaultValue: '')
  @override
  final String avatarStaticUrl;

  /// URL of the header image (animated version).
  @JsonKey(name: 'header', defaultValue: '')
  @override
  final String headerUrl;

  /// URL of the header image (static version).
  @JsonKey(name: 'header_static', defaultValue: '')
  @override
  final String headerStaticUrl;

  /// Whether follow requests require approval.
  @JsonKey(defaultValue: false)
  @override
  final bool locked;

  /// Whether this is a bot account.
  @JsonKey(defaultValue: false)
  @override
  final bool bot;

  /// Whether the account opts in to discovery features.
  @override
  final bool? discoverable;

  /// Whether the account allows its public statuses to be indexed by the
  /// instance's full-text search.
  @override
  final bool? indexable;

  /// Whether this is a group actor rather than a person.
  @override
  final bool? group;

  /// Whether the account opts out of search engine indexing.
  @override
  final bool? noindex;

  /// Number of followers.
  @JsonKey(defaultValue: 0)
  @override
  final int followersCount;

  /// Number of accounts being followed.
  @JsonKey(defaultValue: 0)
  @override
  final int followingCount;

  /// Number of statuses posted.
  @JsonKey(defaultValue: 0)
  @override
  final int statusesCount;

  /// Timestamp when the account was created.
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;

  /// Date of the last posted status.
  @SafeDateTimeConverter()
  @override
  final DateTime? lastStatusAt;

  /// List of profile fields.
  @JsonKey(defaultValue: <MastodonField>[])
  @override
  final List<MastodonField> fields;

  /// List of custom emojis.
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  @override
  final List<MastodonCustomEmoji> emojis;

  /// Migration target account.
  @override
  final MastodonAccount? moved;

  /// Whether the account has been suspended.
  @override
  final bool? suspended;

  /// Whether the account has been limited.
  @override
  final bool? limited;

  /// Whether the follow/followers lists are hidden.
  @override
  final bool? hideCollections;

  /// Blurhash of the avatar image.
  @override
  final String? avatarBlurhash;

  /// Blurhash of the header image.
  @override
  final String? headerBlurhash;

  /// Alt text describing the avatar image, for accessibility.
  ///
  /// Added in Mastodon 4.6.0.
  @override
  final String? avatarDescription;

  /// Alt text describing the header image, for accessibility.
  ///
  /// Added in Mastodon 4.6.0.
  @override
  final String? headerDescription;

  /// This account's approval policy for being tagged into collections.
  ///
  /// Added in Mastodon 4.6.0.
  @override
  final MastodonFeatureApproval? featureApproval;

  /// Whether this account's featured collections are shown on its profile.
  ///
  /// Added in Mastodon 4.6.0.
  @override
  final bool? showFeatured;

  /// Whether media attachments are shown on this account's profile.
  ///
  /// Added in Mastodon 4.6.0.
  @override
  final bool? showMedia;

  /// Whether media attachments from replies are shown on this account's
  /// profile.
  ///
  /// Added in Mastodon 4.6.0.
  @override
  final bool? showMediaReplies;

  /// Publicly visible roles assigned to the account, for badge display.
  ///
  /// Only roles flagged as highlighted are exposed. Elements carry only
  /// [MastodonRole.id], [MastodonRole.name] and [MastodonRole.color]; the
  /// remaining fields are null. Use [role] for the authenticated user's own
  /// role, which is returned in full.
  @JsonKey(defaultValue: <MastodonRole>[])
  @override
  final List<MastodonRole> roles;

  /// Private information including default posting settings and follow request
  /// count.
  @override
  final MastodonAccountSource? source;

  /// The authenticated user's own role, including permissions.
  ///
  /// Unlike the entries in [roles], this is returned in full regardless of
  /// whether the role is flagged as highlighted.
  @override
  final MastodonRole? role;
}

/// Default posting settings and private information of the authenticated user.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccountSource with _$MastodonAccountSource {
  const MastodonAccountSource({
    this.privacy,
    this.sensitive,
    this.language,
    this.note,
    this.fields,
    this.followRequestsCount,
    this.quotePolicy,
  });

  factory MastodonAccountSource.fromJson(Map<String, dynamic> json) =>
      _$MastodonAccountSourceFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAccountSourceToJson(this);

  /// Default posting visibility.
  @override
  final String? privacy;

  /// Whether to mark posts as sensitive by default.
  @override
  final bool? sensitive;

  /// Default posting language (ISO 639-1 format).
  @override
  final String? language;

  /// Profile bio (plain text format).
  @override
  final String? note;

  /// Profile fields (plain text format).
  @JsonKey(defaultValue: <MastodonField>[])
  @override
  final List<MastodonField>? fields;

  /// Number of pending follow requests.
  @JsonKey(defaultValue: 0)
  @override
  final int? followRequestsCount;

  /// Default quote approval policy.
  @override
  final String? quotePolicy;
}
