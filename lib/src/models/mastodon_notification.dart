import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_collection.dart';
import 'mastodon_report.dart';
import 'mastodon_status.dart';

part 'mastodon_notification.freezed.dart';
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

  /// Your annual report is available (Mastodon 4.6+).
  annualReport,

  /// You were added to a collection (Mastodon 4.6+).
  addedToCollection,

  /// A collection involving you was updated (Mastodon 4.6+).
  collectionUpdate,

  /// Unknown or future notification type.
  unknown,
}

/// Generic presentation for a notification type unsupported by the client.
///
/// Returned by Mastodon 4.6+ when `supported_types[]` is supplied and a
/// notification cannot be represented by one of those types.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationFallback with _$MastodonNotificationFallback {
  const MastodonNotificationFallback({
    required this.title,
    required this.summary,
    this.description,
  });

  factory MastodonNotificationFallback.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationFallbackFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonNotificationFallbackToJson(this);

  /// Human-readable notification title. May contain sanitized HTML.
  @JsonKey(defaultValue: '')
  @override
  final String title;

  /// Human-readable notification summary. May contain sanitized HTML.
  @JsonKey(defaultValue: '')
  @override
  final String summary;

  /// Optional longer notification description.
  @override
  final String? description;
}

/// Annual report event embedded in a grouped notification.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAnnualReportEvent with _$MastodonAnnualReportEvent {
  const MastodonAnnualReportEvent({required this.year});

  factory MastodonAnnualReportEvent.fromJson(Map<String, dynamic> json) =>
      _$MastodonAnnualReportEventFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAnnualReportEventToJson(this);

  /// Calendar year represented by the report.
  @override
  final String year;
}

/// Relationship severance event (Mastodon 4.3+).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonRelationshipSeveranceEvent
    with _$MastodonRelationshipSeveranceEvent {
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

  @override
  final String id;

  /// Type of event (`domain_block` / `user_domain_block` / `account_suspension`).
  @override
  final String type;

  /// Whether the account was purged.
  @JsonKey(defaultValue: false)
  @override
  final bool purged;

  /// Name of the severed domain or account.
  @override
  final String targetName;

  /// Number of affected followers.
  @JsonKey(defaultValue: 0)
  @override
  final int followersCount;

  /// Number of affected followings.
  @JsonKey(defaultValue: 0)
  @override
  final int followingCount;

  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;
}

/// Moderation warning (Mastodon 4.3+).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccountWarning with _$MastodonAccountWarning {
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

  @override
  final String id;

  /// Type of warning (`none` / `disable` / `mark_statuses_as_sensitive`, etc.).
  @override
  final String action;

  /// Body text of the warning.
  @JsonKey(defaultValue: '')
  @override
  final String text;

  /// Whether an appeal exists.
  @JsonKey(readValue: _readAppeal, defaultValue: false)
  @override
  final bool appeal;

  /// Timestamp when the notification was created.
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;
}

/// Mastodon notification.
///
/// Corresponds to the response from `/api/v1/notifications`.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotification with _$MastodonNotification {
  const MastodonNotification({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.account,
    this.groupKey,
    this.status,
    this.report,
    this.relationshipSeveranceEvent,
    this.moderationWarning,
    this.collection,
    this.fallback,
    this.filtered = false,
  });

  factory MastodonNotification.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonNotificationToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'unknown';

  /// Internal ID of the notification.
  @override
  final String id;

  /// Type of the notification.
  @JsonKey(
    readValue: _readType,
    unknownEnumValue: MastodonNotificationType.unknown,
  )
  @override
  final MastodonNotificationType type;

  /// Timestamp when the notification was created.
  @override
  final DateTime createdAt;

  /// Account that triggered the notification.
  @override
  final MastodonAccount account;

  /// Key identifying the group this notification belongs to.
  ///
  /// Matches `MastodonNotificationGroup.groupKey`, so it can be used to
  /// correlate a v1 notification with its v2 group. Notifications that were
  /// not grouped receive a synthetic `ungrouped-<id>` key.
  ///
  /// Added in Mastodon 4.3.0.
  @override
  final String? groupKey;

  /// Associated status. Null depending on the notification type.
  @override
  final MastodonStatus? status;

  /// Associated report.
  ///
  /// Non-null only for [MastodonNotificationType.adminReport].
  @override
  final MastodonReport? report;

  /// Details of the relationship severance event.
  ///
  /// Non-null only for [MastodonNotificationType.severedRelationships].
  @JsonKey(name: 'event')
  @override
  final MastodonRelationshipSeveranceEvent? relationshipSeveranceEvent;

  /// Details of the moderation warning. Non-null only for
  /// [MastodonNotificationType.moderationWarning].
  @override
  final MastodonAccountWarning? moderationWarning;

  /// Associated collection for collection-related notifications.
  @override
  final MastodonCollection? collection;

  /// Generic rendering for a notification type not supported by the client.
  @override
  final MastodonNotificationFallback? fallback;

  /// Whether this notification was filtered by a notification policy.
  ///
  /// Added in Mastodon 4.3.0. The server omits this key when it is false.
  @JsonKey(defaultValue: false)
  @override
  final bool filtered;
}
