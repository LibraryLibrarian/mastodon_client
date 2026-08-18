import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_notification_request.freezed.dart';
part 'mastodon_notification_request.g.dart';

/// Filtered notification request (Mastodon 4.3+).
///
/// `/api/v1/notifications/requests`
///
/// Holds filtered notifications from a specific account.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationRequest with _$MastodonNotificationRequest {
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
  @override
  final String id;

  /// Timestamp when the notification request was created (when the first
  /// filtered notification was created).
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;

  /// Timestamp when the notification request was last updated.
  @SafeDateTimeConverter()
  @override
  final DateTime? updatedAt;

  /// Number of filtered notifications.
  ///
  /// Returned as a string by the API, so it is converted to an integer.
  @JsonKey(fromJson: parseIntFromString)
  @override
  final int notificationsCount;

  /// Account that triggered the notifications.
  @override
  final MastodonAccount account;

  /// Status associated with the most recent filtered notification.
  @override
  final MastodonStatus? lastStatus;
}
