import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_custom_emoji.dart';

part 'mastodon_account.freezed.dart';
part 'mastodon_account.g.dart';

/// Mastodon account (user) model.
///
/// Corresponds to responses from `/api/v1/accounts/:id`,
/// `/api/v1/accounts/verify_credentials`, etc.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccount with _$MastodonAccount {
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
  });

  factory MastodonAccount.fromJson(Map<String, dynamic> json) =>
      _$MastodonAccountFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAccountToJson(this);

  /// Internal ID of the account.
  @override
  final String id;

  /// Username within the instance (without `@` or host portion).
  @override
  final String username;

  /// Fully qualified account name.
  /// Local users have only `username`, remote users have `username@host`.
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

  /// URL of the account's profile page.
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

  /// URL of the header (banner) image (animated version).
  @JsonKey(name: 'header', defaultValue: '')
  @override
  final String headerUrl;

  /// URL of the header (banner) image (static version).
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
  ///
  /// Returned for local accounts only.
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

  /// List of custom fields on the profile.
  @JsonKey(defaultValue: <MastodonField>[])
  @override
  final List<MastodonField> fields;

  /// List of custom emojis used in the profile or display name.
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  @override
  final List<MastodonCustomEmoji> emojis;

  /// Migration target account. Non-null only if the account has migrated.
  @override
  final MastodonAccount? moved;

  /// Whether the account has been suspended by an administrator.
  @override
  final bool? suspended;

  /// Whether the account has been limited by an administrator.
  @override
  final bool? limited;

  /// Whether the follow/followers lists are hidden.
  ///
  /// Added in Mastodon 4.3.0.
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
  /// Only roles flagged as highlighted are exposed, and only for local
  /// accounts; remote accounts omit the key entirely, yielding an empty list.
  /// Elements carry only [MastodonRole.id], [MastodonRole.name] and
  /// [MastodonRole.color]; the remaining fields are null.
  @JsonKey(defaultValue: <MastodonRole>[])
  @override
  final List<MastodonRole> roles;
}

/// User role information.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonRole with _$MastodonRole {
  const MastodonRole({
    this.id,
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
  @JsonKey(fromJson: flexibleIdFromJson)
  @override
  final String? id;

  /// Role name.
  @override
  final String name;

  /// Permission bitmask (string format).
  @override
  final String? permissions;

  /// Color of the role badge.
  @JsonKey(defaultValue: '')
  @override
  final String? color;

  /// Whether to display the role badge.
  @override
  final bool? highlighted;

  /// Timestamp when the role was created.
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;

  /// Timestamp when the role was updated.
  @SafeDateTimeConverter()
  @override
  final DateTime? updatedAt;
}

/// An account's approval policy for being tagged into collections
/// (Mastodon 4.6.0+).
///
/// [automatic] and [manual] each list the visibility scopes (e.g.
/// `public`, `followers`) for which tagging requests are automatically
/// accepted or require manual approval, respectively.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonFeatureApproval with _$MastodonFeatureApproval {
  const MastodonFeatureApproval({
    required this.automatic,
    required this.manual,
    this.currentUser,
  });

  factory MastodonFeatureApproval.fromJson(Map<String, dynamic> json) =>
      _$MastodonFeatureApprovalFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonFeatureApprovalToJson(this);

  /// Visibility scopes for which tagging requests are automatically
  /// accepted.
  @JsonKey(defaultValue: <String>[])
  @override
  final List<String> automatic;

  /// Visibility scopes for which tagging requests require manual
  /// approval.
  @JsonKey(defaultValue: <String>[])
  @override
  final List<String> manual;

  /// The approval status for the currently authenticated user
  /// (e.g. `automatic`, `manual`, `denied`), if applicable.
  @override
  final String? currentUser;
}

/// Profile field of a Mastodon account.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonField with _$MastodonField {
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
  @override
  final String name;

  /// Value of the field (may contain HTML).
  @override
  final String value;

  /// Timestamp when link verification was performed. Non-null only if verified.
  @SafeDateTimeConverter()
  @override
  final DateTime? verifiedAt;
}
