import 'package:json_annotation/json_annotation.dart';

part 'mastodon_unread_notification_count.g.dart';

/// Unread notification count (Mastodon 4.3+).
///
/// `GET /api/v1/notifications/unread_count`
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonUnreadNotificationCount {
  const MastodonUnreadNotificationCount({required this.count});

  factory MastodonUnreadNotificationCount.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonUnreadNotificationCountFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonUnreadNotificationCountToJson(this);

  /// Number of unread notifications.
  @JsonKey(defaultValue: 0)
  final int count;
}
