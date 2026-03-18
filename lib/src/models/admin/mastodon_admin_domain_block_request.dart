/// Request for creating or updating an admin domain block.
///
/// Request body for `POST /api/v1/admin/domain_blocks` and
/// `PUT /api/v1/admin/domain_blocks/:id`.
class MastodonAdminDomainBlockRequest {
  /// Creates a [MastodonAdminDomainBlockRequest].
  const MastodonAdminDomainBlockRequest({
    this.domain,
    this.severity,
    this.rejectMedia,
    this.rejectReports,
    this.privateComment,
    this.publicComment,
    this.obfuscate,
  });

  /// Domain to block (required when creating).
  final String? domain;

  /// Severity level (`silence` / `suspend` / `noop`). Default: `silence`.
  final String? severity;

  /// Whether to reject media attachments.
  final bool? rejectMedia;

  /// Whether to reject reports.
  final bool? rejectReports;

  /// Private comment for administrators.
  final String? privateComment;

  /// Public-facing comment.
  final String? publicComment;

  /// Whether to obfuscate the domain name in public displays.
  final bool? obfuscate;

  /// Converts to a JSON map for the request body.
  Map<String, dynamic> toJson() => {
    'domain': ?domain,
    'severity': ?severity,
    'reject_media': ?rejectMedia,
    'reject_reports': ?rejectReports,
    'private_comment': ?privateComment,
    'public_comment': ?publicComment,
    'obfuscate': ?obfuscate,
  };
}
