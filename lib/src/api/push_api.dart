import '../client/mastodon_http_client.dart';
import '../models/mastodon_push_subscription_request.dart';
import '../models/mastodon_web_push_subscription.dart';

/// Web Push 通知サブスクリプションに関する API
class PushApi {
  const PushApi(this._http);

  final MastodonHttpClient _http;

  /// 新しい Web Push サブスクリプションを作成する
  ///
  /// `POST /api/v1/push/subscription`
  ///
  /// - [request]: サブスクリプション登録に必要な情報
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

  /// 現在の Web Push サブスクリプションを取得する
  ///
  /// `GET /api/v1/push/subscription`
  Future<MastodonWebPushSubscription> fetch() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/push/subscription',
    );
    return MastodonWebPushSubscription.fromJson(data!);
  }

  /// 現在の Web Push サブスクリプションを更新する
  ///
  /// `PUT /api/v1/push/subscription`
  ///
  /// サブスクリプションの `data` 部分（アラート設定・ポリシー）のみを更新する。
  ///
  /// - [request]: 更新するアラート設定やポリシー
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

  /// 現在の Web Push サブスクリプションを削除する
  ///
  /// `DELETE /api/v1/push/subscription`
  Future<void> delete() async {
    await _http.send<dynamic>(
      '/api/v1/push/subscription',
      method: 'DELETE',
    );
  }
}
