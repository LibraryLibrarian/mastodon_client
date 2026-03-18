import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_notification.g.dart';

/// Type of notification.
///
/// Covers standard Mastodon notification types.
/// Fedibird-specific types (such as `emoji_reaction`) are treated as [unknown].
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonNotificationType {
  /// Your status was mentioned.
  mention,

  /// A user you follow posted a new status (Mastodon 3.3+).
  status,

  /// Your status was boosted.
  reblog,

  /// You gained a follower.
  follow,

  /// You received a follow request.
  followRequest,

  /// Your status was favourited.
  favourite,

  /// A poll you participated in has ended.
  poll,

  /// A status you interacted with was edited (Mastodon 3.5+).
  update,

  /// Admin: a new user signed up (Mastodon 3.5+).
  @JsonValue('admin.sign_up')
  adminSignUp,

  /// Admin: a new report was filed (Mastodon 4.0+).
  @JsonValue('admin.report')
  adminReport,

  /// A follow relationship was forcibly severed (Mastodon 4.3+).
  severedRelationships,

  /// A moderation warning was received (Mastodon 4.3+).
  moderationWarning,

  /// Your status was quoted (Mastodon 4.5+ / FEP-044f).
  quote,

  /// A quoted status was updated (Mastodon 4.5+ / FEP-044f).
  quotedUpdate,

  /// Unknown or future notification type.
  unknown,
}

/// Relationship severance event (Mastodon 4.3+).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonRelationshipSeveranceEvent {
  const MastodonRelationshipSeveranceEvent({
    required this.id,
    required this.type,
    required this.purged,
    required this.targetName,
    required this.followersCount,
    required this.followingCount,
    this.createdAt,
  });

  factory MastodonRelationshipSeveranceEvent.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonRelationshipSeveranceEventFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonRelationshipSeveranceEventToJson(this);

  final String id;

  /// Type of event (`domain_block` / `user_domain_block` / `account_suspension`).
  final String type;

  /// Whether the account was purged.
  @JsonKey(defaultValue: false)
  final bool purged;

  /// Name of the severed domain or account.
  final String targetName;

  /// Number of affected followers.
  @JsonKey(defaultValue: 0)
  final int followersCount;

  /// Number of affected followings.
  @JsonKey(defaultValue: 0)
  final int followingCount;

  @SafeDateTimeConverter()
  final DateTime? createdAt;
}

/// Moderation warning (Mastodon 4.3+).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccountWarning {
  const MastodonAccountWarning({
    required this.id,
    required this.action,
    required this.text,
    required this.appeal,
    this.createdAt,
  });

  factory MastodonAccountWarning.fromJson(Map<String, dynamic> json) =>
      _$MastodonAccountWarningFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAccountWarningToJson(this);

  static Object? _readAppeal(Map<dynamic, dynamic> json, String key) =>
      json['appeal'] != null;

  final String id;

  /// Type of warning (`none` / `disable` / `mark_statuses_as_sensitive`, etc.).
  final String action;

  /// Body text of the warning.
  @JsonKey(defaultValue: '')
  final String text;

  /// Whether an appeal exists.
  @JsonKey(readValue: _readAppeal, defaultValue: false)
  final bool appeal;

  /// Timestamp when the notification was created.
  @SafeDateTimeConverter()
  final DateTime? createdAt;
}

/// Mastodon notification.
///
/// Corresponds to the response from `/api/v1/notifications`.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotification {
  const MastodonNotification({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.account,
    this.status,
    this.relationshipSeveranceEvent,
    this.moderationWarning,
  });

  factory MastodonNotification.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonNotificationToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'unknown';

  /// Internal ID of the notification.
  final String id;

  /// Type of the notification.
  @JsonKey(
    readValue: _readType,
    unknownEnumValue: MastodonNotificationType.unknown,
  )
  final MastodonNotificationType type;

  /// Timestamp when the notification was created.
  final DateTime createdAt;

  /// Account that triggered the notification.
  final MastodonAccount account;

  /// Associated status. Null depending on the notification type.
  final MastodonStatus? status;

  /// Details of the relationship severance event.
  ///
  /// Non-null only for [MastodonNotificationType.severedRelationships].
  final MastodonRelationshipSeveranceEvent? relationshipSeveranceEvent;

  /// Details of the moderation warning. Non-null only for
  /// [MastodonNotificationType.moderationWarning].
  final MastodonAccountWarning? moderationWarning;
}
