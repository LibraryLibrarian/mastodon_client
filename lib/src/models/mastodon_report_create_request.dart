/// 通報作成リクエスト
class MastodonReportCreateRequest {
  /// [MastodonReportCreateRequest] を生成する
  const MastodonReportCreateRequest({
    required this.accountId,
    this.statusIds,
    this.comment,
    this.forward,
    this.category,
    this.ruleIds,
  });

  /// 通報対象のアカウントID
  final String accountId;

  /// コンテキストとして添付するステータスID
  final List<String>? statusIds;

  /// 通報理由（最大1000文字）
  final String? comment;

  /// リモート管理者にも転送するか
  final bool? forward;

  /// 通報カテゴリ（spam / legal / violation / other）
  final String? category;

  /// violation カテゴリ時の違反ルールID
  final List<String>? ruleIds;

  /// リクエストボディ用の JSON マップに変換する
  Map<String, dynamic> toJson() => {
    'account_id': accountId,
    'status_ids[]': ?statusIds,
    'comment': ?comment,
    'forward': ?forward,
    'category': ?category,
    'rule_ids[]': ?ruleIds,
  };
}
