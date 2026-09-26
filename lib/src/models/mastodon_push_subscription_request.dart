/// Alert settings per Web Push notification type (for requests).
///
/// Fields set to `null` are not included in the request. Mastodon treats
/// omitted alert types as disabled when creating a subscription. When updating
/// a subscription, the server replaces the whole `data` object, so omitted
/// alert types are also disabled rather than left unchanged.
class MastodonPushAlertSettings {
  const MastodonPushAlertSettings({
    this.mention,
    this.quote,
    this.status,
    this.reblog,
    this.follow,
    this.followRequest,
    this.favourite,
    this.poll,
    this.update,
    this.severedRelationships,
    this.moderationWarning,
    this.annualReport,
    this.quotedUpdate,
    this.addedToCollection,
    this.collectionUpdate,
    this.adminSignUp,
    this.adminReport,
  });

  /// Whether to receive mention notifications.
  final bool? mention;

  /// Whether to receive quote notifications.
  final bool? quote;

  /// Whether to receive new post notifications from followed users.
  final bool? status;

  /// Whether to receive boost notifications.
  final bool? reblog;

  /// Whether to receive follow notifications.
  final bool? follow;

  /// Whether to receive follow request notifications.
  final bool? followRequest;

  /// Whether to receive favourite notifications.
  final bool? favourite;

  /// Whether to receive poll ended notifications.
  final bool? poll;

  /// Whether to receive status edit notifications.
  final bool? update;

  /// Whether to receive relationship severance notifications.
  final bool? severedRelationships;

  /// Whether to receive moderation warning notifications.
  final bool? moderationWarning;

  /// Whether to receive annual report notifications.
  final bool? annualReport;

  /// Whether to receive quoted status update notifications.
  final bool? quotedUpdate;

  /// Whether to receive notifications when added to a collection.
  final bool? addedToCollection;

  /// Whether to receive collection update notifications.
  final bool? collectionUpdate;

  /// Admin: whether to receive new sign-up notifications.
  final bool? adminSignUp;

  /// Admin: whether to receive report notifications.
  final bool? adminReport;

  /// Converts to a JSON map for the request.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (mention != null) json['mention'] = mention;
    if (quote != null) json['quote'] = quote;
    if (status != null) json['status'] = status;
    if (reblog != null) json['reblog'] = reblog;
    if (follow != null) json['follow'] = follow;
    if (followRequest != null) json['follow_request'] = followRequest;
    if (favourite != null) json['favourite'] = favourite;
    if (poll != null) json['poll'] = poll;
    if (update != null) json['update'] = update;
    if (severedRelationships != null) {
      json['severed_relationships'] = severedRelationships;
    }
    if (moderationWarning != null) {
      json['moderation_warning'] = moderationWarning;
    }
    if (annualReport != null) json['annual_report'] = annualReport;
    if (quotedUpdate != null) json['quoted_update'] = quotedUpdate;
    if (addedToCollection != null) {
      json['added_to_collection'] = addedToCollection;
    }
    if (collectionUpdate != null) {
      json['collection_update'] = collectionUpdate;
    }
    if (adminSignUp != null) json['admin.sign_up'] = adminSignUp;
    if (adminReport != null) json['admin.report'] = adminReport;
    return json;
  }
}

/// Web Push subscription creation request.
///
/// Used with `POST /api/v1/push/subscription`.
class MastodonPushSubscriptionRequest {
  const MastodonPushSubscriptionRequest({
    required this.endpoint,
    required this.p256dh,
    required this.auth,
    this.standard,
    this.alerts,
    this.policy,
  });

  /// URL for sending notifications.
  final String endpoint;

  /// User agent public key (Base64url-encoded P-256 ECDH public key).
  final String p256dh;

  /// Authentication secret (Base64url-encoded).
  final String auth;

  /// Whether to conform to the standard Web Push specification.
  final bool? standard;

  /// Settings per notification type.
  final MastodonPushAlertSettings? alerts;

  /// Notification policy (all / followed / follower / none).
  final String? policy;

  /// Converts to a JSON map for the request.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'subscription': <String, dynamic>{
        'endpoint': endpoint,
        'keys': <String, dynamic>{'p256dh': p256dh, 'auth': auth},
      },
    };
    if (standard != null) {
      (json['subscription'] as Map<String, dynamic>)['standard'] = standard;
    }
    if (alerts != null) {
      json['data'] = <String, dynamic>{'alerts': alerts!.toJson()};
    }
    if (policy != null) {
      final data = json['data'] as Map<String, dynamic>? ?? <String, dynamic>{};
      data['policy'] = policy;
      json['data'] = data;
    }
    return json;
  }
}

/// Web Push subscription update request.
///
/// Used with `PUT /api/v1/push/subscription`.
///
/// The server replaces the whole `data` portion (alert settings and policy) of
/// the subscription. Omitted alert types become disabled, and omitting [policy]
/// resets it to `all`.
class MastodonPushSubscriptionUpdateRequest {
  const MastodonPushSubscriptionUpdateRequest({this.alerts, this.policy});

  /// Settings per notification type.
  final MastodonPushAlertSettings? alerts;

  /// Notification policy (all / followed / follower / none).
  final String? policy;

  /// Converts to a JSON map for the request.
  ///
  /// Throws an [ArgumentError] when both [alerts] and [policy] are `null`,
  /// because an empty update would clear the subscription's existing data.
  ///
  /// To explicitly disable every alert and reset the policy to `all`, pass an
  /// empty [MastodonPushAlertSettings] as [alerts].
  Map<String, dynamic> toJson() {
    if (alerts == null && policy == null) {
      throw ArgumentError(
        'At least one of alerts or policy must be provided for an update.',
      );
    }

    return <String, dynamic>{
      'data': <String, dynamic>{
        if (alerts != null) 'alerts': alerts!.toJson(),
        if (policy != null) 'policy': policy,
      },
    };
  }
}
