import 'package:json_annotation/json_annotation.dart';

part 'mastodon_web_push_subscription.g.dart';

/// Web Push 通知のアラート種別ごとの設定
///
/// 各フィールドは、対応する通知タイプの Push 通知を受け取るかどうかを表す
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  /// メンション通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool mention;

  /// 引用通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool quote;

  /// フォロー中ユーザーの新規投稿通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool status;

  /// ブースト通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool reblog;

  /// フォロー通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool follow;

  /// フォローリクエスト通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool followRequest;

  /// お気に入り通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool favourite;

  /// 投票終了通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool poll;

  /// 投稿編集通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool update;

  /// 引用の更新通知を受け取るかどうか
  @JsonKey(defaultValue: false)
  final bool quotedUpdate;

  /// 管理者向け：新規サインアップ通知を受け取るかどうか
  @JsonKey(name: 'admin.sign_up', defaultValue: false)
  final bool adminSignUp;

  /// 管理者向け：通報通知を受け取るかどうか
  @JsonKey(name: 'admin.report', defaultValue: false)
  final bool adminReport;
}

/// Mastodon の Web Push サブスクリプション
///
/// `/api/v1/push/subscription` で取得・作成・更新される
/// Push 通知の受信設定を表すエンティティ
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  /// サブスクリプション ID
  final String id;

  /// 通知送信先 URL
  final String endpoint;

  /// サーバーの公開鍵
  final String serverKey;

  /// 通知種別ごとの設定
  final MastodonPushAlerts alerts;

  /// 通知ポリシー（all / followed / follower / none）
  final String policy;

  /// 標準化された Web Push 仕様に準拠しているかどうか
  ///
  /// Mastodon 4.4+ で追加
  final bool? standard;
}
