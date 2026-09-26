import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';

part 'mastodon_web_push_subscription.freezed.dart';
part 'mastodon_web_push_subscription.g.dart';

/// Alert settings per Web Push notification type.
///
/// Each field indicates whether to receive Push notifications for the
/// corresponding notification type.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPushAlerts with _$MastodonPushAlerts {
  const MastodonPushAlerts({
    this.mention = false,
    this.quote = false,
    this.status = false,
    this.reblog = false,
    this.follow = false,
    this.followRequest = false,
    this.favourite = false,
    this.poll = false,
    this.update = false,
    this.severedRelationships = false,
    this.moderationWarning = false,
    this.annualReport = false,
    this.quotedUpdate = false,
    this.addedToCollection = false,
    this.collectionUpdate = false,
    this.adminSignUp = false,
    this.adminReport = false,
  });

  factory MastodonPushAlerts.fromJson(Map<String, dynamic> json) =>
      _$MastodonPushAlertsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPushAlertsToJson(this);

  /// Whether to receive mention notifications.
  @JsonKey(defaultValue: false)
  @override
  final bool mention;

  /// Whether to receive quote notifications.
  @JsonKey(defaultValue: false)
  @override
  final bool quote;

  /// Whether to receive new post notifications from followed users.
  @JsonKey(defaultValue: false)
  @override
  final bool status;

  /// Whether to receive boost notifications.
  @JsonKey(defaultValue: false)
  @override
  final bool reblog;

  /// Whether to receive follow notifications.
  @JsonKey(defaultValue: false)
  @override
  final bool follow;

  /// Whether to receive follow request notifications.
  @JsonKey(defaultValue: false)
  @override
  final bool followRequest;

  /// Whether to receive favourite notifications.
  @JsonKey(defaultValue: false)
  @override
  final bool favourite;

  /// Whether to receive poll ended notifications.
  @JsonKey(defaultValue: false)
  @override
  final bool poll;

  /// Whether to receive status edit notifications.
  @JsonKey(defaultValue: false)
  @override
  final bool update;

  /// Whether to receive relationship severance notifications.
  ///
  /// Added in Mastodon 4.3+.
  @JsonKey(defaultValue: false)
  @override
  final bool severedRelationships;

  /// Whether to receive moderation warning notifications.
  ///
  /// Added in Mastodon 4.3+.
  @JsonKey(defaultValue: false)
  @override
  final bool moderationWarning;

  /// Whether to receive annual report notifications.
  ///
  /// Added in Mastodon 4.4+.
  @JsonKey(defaultValue: false)
  @override
  final bool annualReport;

  /// Whether to receive quoted status update notifications.
  @JsonKey(defaultValue: false)
  @override
  final bool quotedUpdate;

  /// Whether to receive notifications when added to a collection.
  ///
  /// Added in Mastodon 4.6+.
  @JsonKey(defaultValue: false)
  @override
  final bool addedToCollection;

  /// Whether to receive collection update notifications.
  ///
  /// Added in Mastodon 4.6+.
  @JsonKey(defaultValue: false)
  @override
  final bool collectionUpdate;

  /// Admin: whether to receive new sign-up notifications.
  @JsonKey(name: 'admin.sign_up', defaultValue: false)
  @override
  final bool adminSignUp;

  /// Admin: whether to receive report notifications.
  @JsonKey(name: 'admin.report', defaultValue: false)
  @override
  final bool adminReport;
}

/// Mastodon Web Push subscription.
///
/// Retrieved, created, and updated via `/api/v1/push/subscription`.
/// Entity representing Push notification settings.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonWebPushSubscription with _$MastodonWebPushSubscription {
  const MastodonWebPushSubscription({
    this.id,
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
  @JsonKey(fromJson: flexibleIdFromJson)
  @override
  final String? id;

  /// URL for sending notifications.
  @override
  final String endpoint;

  /// Server public key.
  @override
  final String serverKey;

  /// Settings per notification type.
  @override
  final MastodonPushAlerts alerts;

  /// Notification policy (all / followed / follower / none).
  @override
  final String policy;

  /// Whether conforming to the standardized Web Push specification.
  ///
  /// Added in Mastodon 4.4+.
  @override
  final bool? standard;
}
