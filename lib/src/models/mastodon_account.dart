import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_custom_emoji.dart';

part 'mastodon_account.g.dart';

/// Mastodon account (user) model.
///
/// Corresponds to responses from `/api/v1/accounts/:id`,
/// `/api/v1/accounts/verify_credentials`, etc.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccount {
  const MastodonAccount({
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
  });

  factory MastodonAccount.fromJson(Map<String, dynamic> json) =>
      _$MastodonAccountFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAccountToJson(this);

  /// Internal ID of the account.
  final String id;

  /// Username within the instance (without `@` or host portion).
  final String username;

  /// Fully qualified account name.
  /// Local users have only `username`, remote users have `username@host`.
  final String acct;

  /// Display name.
  @JsonKey(defaultValue: '')
  final String displayName;

  /// Profile bio (HTML format).
  @JsonKey(defaultValue: '')
  final String note;

  /// URL of the account's profile page.
  @JsonKey(defaultValue: '')
  final String url;

  /// URL of the avatar image (animated version).
  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatarUrl;

  /// URL of the avatar image (static version).
  @JsonKey(name: 'avatar_static', defaultValue: '')
  final String avatarStaticUrl;

  /// URL of the header (banner) image (animated version).
  @JsonKey(name: 'header', defaultValue: '')
  final String headerUrl;

  /// URL of the header (banner) image (static version).
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

  /// List of custom fields on the profile.
  @JsonKey(defaultValue: <MastodonField>[])
  final List<MastodonField> fields;

  /// List of custom emojis used in the profile or display name.
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  final List<MastodonCustomEmoji> emojis;

  /// Migration target account. Non-null only if the account has migrated.
  final MastodonAccount? moved;

  /// Whether the account has been suspended by an administrator.
  final bool? suspended;

  /// Whether the account has been limited by an administrator.
  final bool? limited;

  /// Whether the follow/followers lists are hidden.
  ///
  /// Added in Mastodon 4.3.0.
  final bool? hideCollections;

  /// Blurhash of the avatar image.
  final String? avatarBlurhash;

  /// Blurhash of the header image.
  final String? headerBlurhash;
}

/// Profile field of a Mastodon account.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonField {
  const MastodonField({
    required this.name,
    required this.value,
    this.verifiedAt,
  });

  factory MastodonField.fromJson(Map<String, dynamic> json) =>
      _$MastodonFieldFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonFieldToJson(this);

  /// Label name of the field.
  final String name;

  /// Value of the field (may contain HTML).
  final String value;

  /// Timestamp when link verification was performed. Non-null only if verified.
  @SafeDateTimeConverter()
  final DateTime? verifiedAt;
}
