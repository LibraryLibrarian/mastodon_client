/// Web Push アラート種別ごとの設定（リクエスト用）
///
/// `null` のフィールドはリクエストに含まれない
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

  /// メンション通知を受け取るかどうか
  final bool? mention;

  /// 引用通知を受け取るかどうか
  final bool? quote;

  /// フォロー中ユーザーの新規投稿通知を受け取るかどうか
  final bool? status;

  /// ブースト通知を受け取るかどうか
  final bool? reblog;

  /// フォロー通知を受け取るかどうか
  final bool? follow;

  /// フォローリクエスト通知を受け取るかどうか
  final bool? followRequest;

  /// お気に入り通知を受け取るかどうか
  final bool? favourite;

  /// 投票終了通知を受け取るかどうか
  final bool? poll;

  /// 投稿編集通知を受け取るかどうか
  final bool? update;

  /// 引用の更新通知を受け取るかどうか
  final bool? quotedUpdate;

  /// 管理者向け：新規サインアップ通知を受け取るかどうか
  final bool? adminSignUp;

  /// 管理者向け：通報通知を受け取るかどうか
  final bool? adminReport;

  /// リクエスト用の JSON マップに変換する
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

/// Web Push サブスクリプション登録リクエスト
///
/// `POST /api/v1/push/subscription` で使用する
class MastodonPushSubscriptionRequest {
  const MastodonPushSubscriptionRequest({
    required this.endpoint,
    required this.p256dh,
    required this.auth,
    this.standard,
    this.alerts,
    this.policy,
  });

  /// 通知送信先 URL
  final String endpoint;

  /// ユーザーエージェントの公開鍵（P-256 ECDH 鍵ペアの公開鍵を Base64url エンコードしたもの）
  final String p256dh;

  /// 認証シークレット（Base64url エンコード）
  final String auth;

  /// Web Push 標準仕様に準拠するかどうか
  final bool? standard;

  /// 通知種別ごとの設定
  final MastodonPushAlertSettings? alerts;

  /// 通知ポリシー（all / followed / follower / none）
  final String? policy;

  /// リクエスト用の JSON マップに変換する
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

/// Web Push サブスクリプション更新リクエスト
///
/// `PUT /api/v1/push/subscription` で使用する。
/// サブスクリプションの `data` 部分（アラート設定・ポリシー）のみを更新する
class MastodonPushSubscriptionUpdateRequest {
  const MastodonPushSubscriptionUpdateRequest({
    this.alerts,
    this.policy,
  });

  /// 通知種別ごとの設定
  final MastodonPushAlertSettings? alerts;

  /// 通知ポリシー（all / followed / follower / none）
  final String? policy;

  /// リクエスト用の JSON マップに変換する
  ///
  /// PUT では `policy` はトップレベルに配置する（POST の `data[policy]` とは異なる）。
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
