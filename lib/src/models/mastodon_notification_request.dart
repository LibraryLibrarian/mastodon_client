import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_notification_request.g.dart';

/// フィルタリングされた通知のリクエスト（Mastodon 4.3+）
///
/// `/api/v1/notifications/requests`
///
/// 特定のアカウントからフィルタリングされた通知をまとめて保持
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationRequest {
  const MastodonNotificationRequest({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.notificationsCount,
    required this.account,
    this.lastStatus,
  });

  factory MastodonNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationRequestFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonNotificationRequestToJson(this);

  /// 通知リクエストの内部 ID
  final String id;

  /// 通知リクエストの作成日時（最初のフィルタリング通知が作成された時刻）
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// 通知リクエストの最終更新日時
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// フィルタリングされた通知の件数
  ///
  /// API では文字列として返されるため、整数に変換する。
  @JsonKey(fromJson: parseIntFromString)
  final int notificationsCount;

  /// 通知を発生させたアカウント
  final MastodonAccount account;

  /// 最新のフィルタリング済み通知に関連する投稿
  final MastodonStatus? lastStatus;
}
