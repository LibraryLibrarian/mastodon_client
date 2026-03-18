import '../client/mastodon_http_client.dart';
import '../models/mastodon_push_subscription_request.dart';
import '../models/mastodon_web_push_subscription.dart';

/// Web Push notification subscription API.
class PushApi {
  const PushApi(this._http);

  final MastodonHttpClient _http;

  /// Creates a new Web Push subscription.
  ///
  /// `POST /api/v1/push/subscription`
  Future<MastodonWebPushSubscription> create(
    MastodonPushSubscriptionRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/push/subscription',
      method: 'POST',
      data: request.toJson(),
    );
    return MastodonWebPushSubscription.fromJson(data!);
  }

  /// Fetches the current Web Push subscription.
  ///
  /// `GET /api/v1/push/subscription`
  Future<MastodonWebPushSubscription> fetch() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/push/subscription',
    );
    return MastodonWebPushSubscription.fromJson(data!);
  }

  /// Updates the current Web Push subscription.
  ///
  /// `PUT /api/v1/push/subscription`
  ///
  /// Updates only the `data` portion of the subscription (alert settings
  /// and policy).
  Future<MastodonWebPushSubscription> update(
    MastodonPushSubscriptionUpdateRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/push/subscription',
      method: 'PUT',
      data: request.toJson(),
    );
    return MastodonWebPushSubscription.fromJson(data!);
  }

  /// Deletes the current Web Push subscription.
  ///
  /// `DELETE /api/v1/push/subscription`
  Future<void> delete() async {
    await _http.send<dynamic>(
      '/api/v1/push/subscription',
      method: 'DELETE',
    );
  }
}
