/// Request for updating an admin report.
///
/// Request body for `PUT /api/v1/admin/reports/:id`.
class MastodonAdminReportUpdateRequest {
  /// Creates a [MastodonAdminReportUpdateRequest].
  const MastodonAdminReportUpdateRequest({
    this.category,
    this.ruleIds,
  });

  /// Report category (`spam` / `legal` / `violation` / `other`).
  final String? category;

  /// List of violated rule IDs when the category is `violation`.
  final List<int>? ruleIds;

  /// Converts to a JSON map for the request body.
  Map<String, dynamic> toJson() => {
    'category': ?category,
    'rule_ids': ?ruleIds,
  };
}
