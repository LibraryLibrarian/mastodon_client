import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_custom_emoji.dart';

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
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCredentialAccount {
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
    this.discoverable,
    this.noindex,
    this.createdAt,
    this.lastStatusAt,
    this.moved,
    this.suspended,
    this.limited,
    this.hideCollections,
    this.avatarBlurhash,
    this.headerBlurhash,
    this.source,
    this.role,
  });

  factory MastodonCredentialAccount.fromJson(Map<String, dynamic> json) =>
      _$MastodonCredentialAccountFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonCredentialAccountToJson(this);

  /// Internal ID of the account.
  final String id;

  /// Username within the instance.
  final String username;

  /// Fully qualified account name.
  final String acct;

  /// Display name.
  @JsonKey(defaultValue: '')
  final String displayName;

  /// Profile bio (HTML format).
  @JsonKey(defaultValue: '')
  final String note;

  /// Profile page URL.
  @JsonKey(defaultValue: '')
  final String url;

  /// URL of the avatar image (animated version).
  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatarUrl;

  /// URL of the avatar image (static version).
  @JsonKey(name: 'avatar_static', defaultValue: '')
  final String avatarStaticUrl;

  /// URL of the header image (animated version).
  @JsonKey(name: 'header', defaultValue: '')
  final String headerUrl;

  /// URL of the header image (static version).
  @JsonKey(name: 'header_static', defaultValue: '')
  final String headerStaticUrl;

  /// Whether follow requests require approval.
  @JsonKey(defaultValue: false)
  final bool locked;

  /// Whether this is a bot account.
  @JsonKey(defaultValue: false)
  final bool bot;

  /// Whether the account opts in to discovery features.
  final bool? discoverable;

  /// Whether the account opts out of search engine indexing.
  final bool? noindex;

  /// Number of followers.
  @JsonKey(defaultValue: 0)
  final int followersCount;

  /// Number of accounts being followed.
  @JsonKey(defaultValue: 0)
  final int followingCount;

  /// Number of statuses posted.
  @JsonKey(defaultValue: 0)
  final int statusesCount;

  /// Timestamp when the account was created.
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// Date of the last posted status.
  @SafeDateTimeConverter()
  final DateTime? lastStatusAt;

  /// List of profile fields.
  @JsonKey(defaultValue: <MastodonField>[])
  final List<MastodonField> fields;

  /// List of custom emojis.
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  final List<MastodonCustomEmoji> emojis;

  /// Migration target account.
  final MastodonAccount? moved;

  /// Whether the account has been suspended.
  final bool? suspended;

  /// Whether the account has been limited.
  final bool? limited;

  /// Whether the follow/followers lists are hidden.
  final bool? hideCollections;

  /// Blurhash of the avatar image.
  final String? avatarBlurhash;

  /// Blurhash of the header image.
  final String? headerBlurhash;

  /// Private information including default posting settings and follow request
  /// count.
  final MastodonAccountSource? source;

  /// User role information.
  final MastodonRole? role;
}

/// Default posting settings and private information of the authenticated user.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccountSource {
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
  final String? privacy;

  /// Whether to mark posts as sensitive by default.
  final bool? sensitive;

  /// Default posting language (ISO 639-1 format).
  final String? language;

  /// Profile bio (plain text format).
  final String? note;

  /// Profile fields (plain text format).
  @JsonKey(defaultValue: <MastodonField>[])
  final List<MastodonField>? fields;

  /// Number of pending follow requests.
  @JsonKey(defaultValue: 0)
  final int? followRequestsCount;

  /// Default quote approval policy.
  final String? quotePolicy;
}

/// User role information.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonRole {
  const MastodonRole({
    required this.id,
    required this.name,
    this.permissions,
    this.color,
    this.highlighted,
    this.createdAt,
    this.updatedAt,
  });

  factory MastodonRole.fromJson(Map<String, dynamic> json) =>
      _$MastodonRoleFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonRoleToJson(this);

  /// Role ID.
  final int id;

  /// Role name.
  final String name;

  /// Permission bitmask (string format).
  final String? permissions;

  /// Color of the role badge.
  @JsonKey(defaultValue: '')
  final String? color;

  /// Whether to display the role badge.
  final bool? highlighted;

  /// Timestamp when the role was created.
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// Timestamp when the role was updated.
  @SafeDateTimeConverter()
  final DateTime? updatedAt;
}
