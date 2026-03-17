import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_notification.dart';
import 'mastodon_report.dart';

part 'mastodon_notification_group.g.dart';

/// グループ化された通知
///
/// `/api/v2/notifications` のレスポンスで返される通知グループを表すモデル。
/// 同一タイプ・同一対象の通知がグループ化され、効率的に表示できる。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonNotificationGroup {
  const MastodonNotificationGroup({
    required this.groupKey,
    required this.notificationsCount,
    required this.type,
    required this.mostRecentNotificationId,
    this.pageMinId,
    this.pageMaxId,
    this.latestPageNotificationAt,
    required this.sampleAccountIds,
    this.statusId,
    this.report,
    this.event,
    this.moderationWarning,
  });

  factory MastodonNotificationGroup.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationGroupFromJson(json);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'unknown';

  /// グループ識別子
  final String groupKey;

  /// グループ内の通知数
  @JsonKey(defaultValue: 0)
  final int notificationsCount;

  /// 通知の種別
  @JsonKey(
    readValue: _readType,
    unknownEnumValue: MastodonNotificationType.unknown,
  )
  final MastodonNotificationType type;

  /// グループ内の最新通知ID
  final String mostRecentNotificationId;

  /// 現ページ内の最古通知ID
  final String? pageMinId;

  /// 現ページ内の最新通知ID
  final String? pageMaxId;

  /// 現ページ内の最新通知の日時
  @SafeDateTimeConverter()
  final DateTime? latestPageNotificationAt;

  /// 通知をトリガーしたアカウントIDのサンプル
  @JsonKey(defaultValue: <String>[])
  final List<String> sampleAccountIds;

  /// 関連する投稿のID（種別によってはnull）
  final String? statusId;

  /// 関連する通報（管理者向け通知の場合のみ非null）
  final MastodonReport? report;

  /// フォロー関係強制解除イベントの詳細
  ///
  /// [MastodonNotificationType.severedRelationships] の場合のみ非null
  final MastodonRelationshipSeveranceEvent? event;

  /// モデレーション警告の詳細
  ///
  /// [MastodonNotificationType.moderationWarning] の場合のみ非null
  final MastodonAccountWarning? moderationWarning;
}
