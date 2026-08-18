import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_notification.dart';
import 'mastodon_report.dart';

part 'mastodon_notification_group.freezed.dart';
part 'mastodon_notification_group.g.dart';

/// Grouped notification.
///
/// Model representing a notification group returned by `/api/v2/notifications`.
/// Notifications of the same type and target are grouped for efficient display.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationGroup with _$MastodonNotificationGroup {
  const MastodonNotificationGroup({
    required this.groupKey,
    required this.notificationsCount,
    required this.type,
    this.mostRecentNotificationId,
    this.pageMinId,
    this.pageMaxId,
    this.latestPageNotificationAt,
    required this.sampleAccountIds,
    this.statusId,
    this.report,
    this.event,
    this.moderationWarning,
  });

  factory MastodonNotificationGroup.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationGroupFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonNotificationGroupToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'unknown';

  /// Group identifier.
  @override
  final String groupKey;

  /// Number of notifications in the group.
  @JsonKey(defaultValue: 0)
  @override
  final int notificationsCount;

  /// Type of the notification.
  @JsonKey(
    readValue: _readType,
    unknownEnumValue: MastodonNotificationType.unknown,
  )
  @override
  final MastodonNotificationType type;

  /// ID of the most recent notification in the group.
  @JsonKey(fromJson: flexibleIdFromJson)
  @override
  final String? mostRecentNotificationId;

  /// ID of the oldest notification in the current page.
  @override
  final String? pageMinId;

  /// ID of the newest notification in the current page.
  @override
  final String? pageMaxId;

  /// Timestamp of the newest notification in the current page.
  @SafeDateTimeConverter()
  @override
  final DateTime? latestPageNotificationAt;

  /// Sample account IDs that triggered the notifications.
  @JsonKey(defaultValue: <String>[])
  @override
  final List<String> sampleAccountIds;

  /// ID of the associated status (null depending on the type).
  @override
  final String? statusId;

  /// Associated report (non-null only for admin notifications).
  @override
  final MastodonReport? report;

  /// Details of the relationship severance event.
  ///
  /// Non-null only for [MastodonNotificationType.severedRelationships].
  @override
  final MastodonRelationshipSeveranceEvent? event;

  /// Details of the moderation warning.
  ///
  /// Non-null only for [MastodonNotificationType.moderationWarning].
  @override
  final MastodonAccountWarning? moderationWarning;
}
