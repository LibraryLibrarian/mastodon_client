import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_notification_request.g.dart';

/// Filtered notification request (Mastodon 4.3+).
///
/// `/api/v1/notifications/requests`
///
/// Holds filtered notifications from a specific account.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationRequest {
  const MastodonNotificationRequest({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.notificationsCount,
    required this.account,
    this.lastStatus,
  });

  factory MastodonNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationRequestFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonNotificationRequestToJson(this);

  /// Internal ID of the notification request.
  final String id;

  /// Timestamp when the notification request was created (when the first
  /// filtered notification was created).
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// Timestamp when the notification request was last updated.
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// Number of filtered notifications.
  ///
  /// Returned as a string by the API, so it is converted to an integer.
  @JsonKey(fromJson: parseIntFromString)
  final int notificationsCount;

  /// Account that triggered the notifications.
  final MastodonAccount account;

  /// Status associated with the most recent filtered notification.
  final MastodonStatus? lastStatus;
}
