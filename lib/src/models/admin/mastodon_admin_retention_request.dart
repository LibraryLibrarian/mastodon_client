/// 管理者向けリテンションデータ取得リクエスト
///
/// `POST /api/v1/admin/retention` のリクエストボディ。
class MastodonAdminRetentionRequest {
  /// [MastodonAdminRetentionRequest] を生成する
  const MastodonAdminRetentionRequest({
    required this.startAt,
    required this.endAt,
    required this.frequency,
  });

  /// 開始日時（時刻部分は無視される）
  final DateTime startAt;

  /// 終了日時（時刻部分は無視される）
  final DateTime endAt;

  /// データの粒度（`day` または `month`）
  final String frequency;

  /// リクエストボディ用の JSON マップに変換する
  Map<String, dynamic> toJson() => {
    'start_at': startAt.toIso8601String(),
    'end_at': endAt.toIso8601String(),
    'frequency': frequency,
  };
}
