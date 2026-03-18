import 'package:json_annotation/json_annotation.dart';

part 'mastodon_notification_policy.g.dart';

/// Filtering action for a notification policy.
///
/// Represents the action applied to each notification category.
@JsonEnum(fieldRename: FieldRename.snake)
enum NotificationFilterAction {
  /// Accept the notification.
  accept,

  /// Filter the notification (route to notification requests).
  filter,

  /// Discard the notification.
  drop,
}

/// Summary of a notification policy.
///
/// Holds statistics about filtered notifications.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationPolicySummary {
  const MastodonNotificationPolicySummary({
    required this.pendingRequestsCount,
    required this.pendingNotificationsCount,
  });

  factory MastodonNotificationPolicySummary.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonNotificationPolicySummaryFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonNotificationPolicySummaryToJson(this);

  /// Number of pending notification requests (maximum 100).
  @JsonKey(defaultValue: 0)
  final int pendingRequestsCount;

  /// Total number of pending filtered notifications.
  @JsonKey(defaultValue: 0)
  final int pendingNotificationsCount;
}

/// Mastodon notification policy (Mastodon 4.3+).
///
/// `/api/v2/notifications/policy`
///
/// Holds filtering rules for each notification category.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationPolicy {
  const MastodonNotificationPolicy({
    required this.forNotFollowing,
    required this.forNotFollowers,
    required this.forNewAccounts,
    required this.forPrivateMentions,
    required this.forLimitedAccounts,
    this.summary,
  });

  factory MastodonNotificationPolicy.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationPolicyFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonNotificationPolicyToJson(this);

  /// Action for notifications from accounts you do not follow.
  @JsonKey(
    name: 'for_not_following',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forNotFollowing;

  /// Action for notifications from accounts that do not follow you.
  @JsonKey(
    name: 'for_not_followers',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forNotFollowers;

  /// Action for notifications from accounts created less than 30 days ago.
  @JsonKey(
    name: 'for_new_accounts',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forNewAccounts;

  /// Action for private mention notifications.
  @JsonKey(
    name: 'for_private_mentions',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forPrivateMentions;

  /// Action for notifications from accounts limited by a moderator.
  @JsonKey(
    name: 'for_limited_accounts',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forLimitedAccounts;

  /// Summary of filtered notifications.
  final MastodonNotificationPolicySummary? summary;
}
