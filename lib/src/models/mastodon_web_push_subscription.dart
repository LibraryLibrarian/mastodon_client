import 'package:json_annotation/json_annotation.dart';

part 'mastodon_web_push_subscription.g.dart';

/// Alert settings per Web Push notification type.
///
/// Each field indicates whether to receive Push notifications for the
/// corresponding notification type.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPushAlerts {
  const MastodonPushAlerts({
    required this.mention,
    required this.quote,
    required this.status,
    required this.reblog,
    required this.follow,
    required this.followRequest,
    required this.favourite,
    required this.poll,
    required this.update,
    required this.quotedUpdate,
    required this.adminSignUp,
    required this.adminReport,
  });

  factory MastodonPushAlerts.fromJson(Map<String, dynamic> json) =>
      _$MastodonPushAlertsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPushAlertsToJson(this);

  /// Whether to receive mention notifications.
  @JsonKey(defaultValue: false)
  final bool mention;

  /// Whether to receive quote notifications.
  @JsonKey(defaultValue: false)
  final bool quote;

  /// Whether to receive new post notifications from followed users.
  @JsonKey(defaultValue: false)
  final bool status;

  /// Whether to receive boost notifications.
  @JsonKey(defaultValue: false)
  final bool reblog;

  /// Whether to receive follow notifications.
  @JsonKey(defaultValue: false)
  final bool follow;

  /// Whether to receive follow request notifications.
  @JsonKey(defaultValue: false)
  final bool followRequest;

  /// Whether to receive favourite notifications.
  @JsonKey(defaultValue: false)
  final bool favourite;

  /// Whether to receive poll ended notifications.
  @JsonKey(defaultValue: false)
  final bool poll;

  /// Whether to receive status edit notifications.
  @JsonKey(defaultValue: false)
  final bool update;

  /// Whether to receive quoted status update notifications.
  @JsonKey(defaultValue: false)
  final bool quotedUpdate;

  /// Admin: whether to receive new sign-up notifications.
  @JsonKey(name: 'admin.sign_up', defaultValue: false)
  final bool adminSignUp;

  /// Admin: whether to receive report notifications.
  @JsonKey(name: 'admin.report', defaultValue: false)
  final bool adminReport;
}

/// Mastodon Web Push subscription.
///
/// Retrieved, created, and updated via `/api/v1/push/subscription`.
/// Entity representing Push notification settings.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonWebPushSubscription {
  const MastodonWebPushSubscription({
    required this.id,
    required this.endpoint,
    required this.serverKey,
    required this.alerts,
    required this.policy,
    this.standard,
  });

  factory MastodonWebPushSubscription.fromJson(Map<String, dynamic> json) =>
      _$MastodonWebPushSubscriptionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonWebPushSubscriptionToJson(this);

  /// Subscription ID.
  final String id;

  /// URL for sending notifications.
  final String endpoint;

  /// Server public key.
  final String serverKey;

  /// Settings per notification type.
  final MastodonPushAlerts alerts;

  /// Notification policy (all / followed / follower / none).
  final String policy;

  /// Whether conforming to the standardized Web Push specification.
  ///
  /// Added in Mastodon 4.4+.
  final bool? standard;
}
