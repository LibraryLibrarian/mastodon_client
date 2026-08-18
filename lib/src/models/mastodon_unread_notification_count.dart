import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_unread_notification_count.freezed.dart';
part 'mastodon_unread_notification_count.g.dart';

/// Unread notification count (Mastodon 4.3+).
///
/// `GET /api/v1/notifications/unread_count`
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonUnreadNotificationCount with _$MastodonUnreadNotificationCount {
  const MastodonUnreadNotificationCount({required this.count});

  factory MastodonUnreadNotificationCount.fromJson(Map<String, dynamic> json) =>
      _$MastodonUnreadNotificationCountFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonUnreadNotificationCountToJson(this);

  /// Number of unread notifications.
  @JsonKey(defaultValue: 0)
  @override
  final int count;
}
