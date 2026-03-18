/// Alert settings per Web Push notification type (for requests).
///
/// Fields set to `null` are not included in the request.
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
    this.quotedUpdate,
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

  /// Whether to receive quoted status update notifications.
  final bool? quotedUpdate;

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
    if (quotedUpdate != null) json['quoted_update'] = quotedUpdate;
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
        'keys': <String, dynamic>{
          'p256dh': p256dh,
          'auth': auth,
        },
      },
    };
    if (standard != null) {
      (json['subscription'] as Map<String, dynamic>)['standard'] = standard;
    }
    if (alerts != null) {
      json['data'] = <String, dynamic>{
        'alerts': alerts!.toJson(),
      };
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
/// Updates only the `data` portion (alert settings and policy) of the
/// subscription.
class MastodonPushSubscriptionUpdateRequest {
  const MastodonPushSubscriptionUpdateRequest({
    this.alerts,
    this.policy,
  });

  /// Settings per notification type.
  final MastodonPushAlertSettings? alerts;

  /// Notification policy (all / followed / follower / none).
  final String? policy;

  /// Converts to a JSON map for the request.
  ///
  /// For PUT requests, `policy` is placed at the top level (unlike
  /// `data[policy]` in POST).
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (alerts != null) {
      data['alerts'] = alerts!.toJson();
    }
    final json = <String, dynamic>{'data': data};
    if (policy != null) {
      json['policy'] = policy;
    }
    return json;
  }
}
