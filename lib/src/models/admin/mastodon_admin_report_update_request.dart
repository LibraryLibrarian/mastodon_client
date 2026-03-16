/// 管理者向け通報更新リクエスト
///
/// `PUT /api/v1/admin/reports/:id` のリクエストボディ。
class MastodonAdminReportUpdateRequest {
  /// [MastodonAdminReportUpdateRequest] を生成する
  const MastodonAdminReportUpdateRequest({
    this.category,
    this.ruleIds,
  });

  /// 通報カテゴリ（`spam` / `legal` / `violation` / `other`）
  final String? category;

  /// violation カテゴリ時の違反ルール ID リスト
  final List<int>? ruleIds;

  /// リクエストボディ用の JSON マップに変換する
  Map<String, dynamic> toJson() => {
    'category': ?category,
    'rule_ids': ?ruleIds,
  };
}
