/// 管理者向けアカウントアクション実行リクエスト
///
/// `POST /api/v1/admin/accounts/:id/action` のリクエストボディ。
class MastodonAdminAccountActionRequest {
  /// [MastodonAdminAccountActionRequest] を生成する
  const MastodonAdminAccountActionRequest({
    required this.type,
    this.reportId,
    this.warningPresetId,
    this.text,
    this.sendEmailNotification,
  });

  /// アクションの種類（`none` / `sensitive` / `disable` / `silence` / `suspend`）
  final String type;

  /// 関連する通報の ID
  final String? reportId;

  /// 警告プリセットの ID
  final String? warningPresetId;

  /// 追加の説明テキスト
  final String? text;

  /// ユーザーにメール通知を送信するかどうか
  final bool? sendEmailNotification;

  /// リクエストボディ用の JSON マップに変換する
  Map<String, dynamic> toJson() => {
    'type': type,
    'report_id': ?reportId,
    'warning_preset_id': ?warningPresetId,
    'text': ?text,
    'send_email_notification': ?sendEmailNotification,
  };
}
