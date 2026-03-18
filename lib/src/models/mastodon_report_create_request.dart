/// Request for creating a report.
class MastodonReportCreateRequest {
  /// Creates a [MastodonReportCreateRequest].
  const MastodonReportCreateRequest({
    required this.accountId,
    this.statusIds,
    this.comment,
    this.forward,
    this.category,
    this.ruleIds,
  });

  /// ID of the account being reported.
  final String accountId;

  /// Status IDs to attach as context.
  final List<String>? statusIds;

  /// Reason for the report (maximum 1000 characters).
  final String? comment;

  /// Whether to forward to the remote administrator.
  final bool? forward;

  /// Report category (spam / legal / violation / other).
  final String? category;

  /// Violated rule IDs for the violation category.
  final List<String>? ruleIds;

  /// Converts to a JSON map for the request body.
  Map<String, dynamic> toJson() => {
    'account_id': accountId,
    'status_ids': ?statusIds,
    'comment': ?comment,
    'forward': ?forward,
    'category': ?category,
    'rule_ids': ?ruleIds,
  };
}
