import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_notification_policy.freezed.dart';
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
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationPolicySummary
    with _$MastodonNotificationPolicySummary {
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
  @override
  final int pendingRequestsCount;

  /// Total number of pending filtered notifications.
  @JsonKey(defaultValue: 0)
  @override
  final int pendingNotificationsCount;
}

/// Mastodon notification policy (Mastodon 4.3+).
///
/// `/api/v2/notifications/policy`
///
/// Holds filtering rules for each notification category.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationPolicy with _$MastodonNotificationPolicy {
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
  @override
  final NotificationFilterAction forNotFollowing;

  /// Action for notifications from accounts that do not follow you.
  @JsonKey(
    name: 'for_not_followers',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  @override
  final NotificationFilterAction forNotFollowers;

  /// Action for notifications from accounts created less than 30 days ago.
  @JsonKey(
    name: 'for_new_accounts',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  @override
  final NotificationFilterAction forNewAccounts;

  /// Action for private mention notifications.
  @JsonKey(
    name: 'for_private_mentions',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  @override
  final NotificationFilterAction forPrivateMentions;

  /// Action for notifications from accounts limited by a moderator.
  @JsonKey(
    name: 'for_limited_accounts',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  @override
  final NotificationFilterAction forLimitedAccounts;

  /// Summary of filtered notifications.
  @override
  final MastodonNotificationPolicySummary? summary;
}

/// Legacy boolean notification policy returned by the v1 endpoint.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationPolicyV1 with _$MastodonNotificationPolicyV1 {
  const MastodonNotificationPolicyV1({
    required this.filterNotFollowing,
    required this.filterNotFollowers,
    required this.filterNewAccounts,
    required this.filterPrivateMentions,
    required this.filterBots,
    this.summary,
  });

  factory MastodonNotificationPolicyV1.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationPolicyV1FromJson(json);

  Map<String, dynamic> toJson() => _$MastodonNotificationPolicyV1ToJson(this);

  @JsonKey(defaultValue: false)
  @override
  final bool filterNotFollowing;

  @JsonKey(defaultValue: false)
  @override
  final bool filterNotFollowers;

  @JsonKey(defaultValue: false)
  @override
  final bool filterNewAccounts;

  @JsonKey(defaultValue: false)
  @override
  final bool filterPrivateMentions;

  @JsonKey(defaultValue: false)
  @override
  final bool filterBots;

  @override
  final MastodonNotificationPolicySummary? summary;
}
