/// Request for creating an admin IP block.
///
/// Request body for `POST /api/v1/admin/ip_blocks`.
/// `severity` is required per the official documentation.
class MastodonAdminIpBlockCreateRequest {
  /// Creates a [MastodonAdminIpBlockCreateRequest].
  const MastodonAdminIpBlockCreateRequest({
    required this.severity,
    this.ip,
    this.comment,
    this.expiresIn,
  });

  /// IP address range to block (CIDR notation).
  final String? ip;

  /// Severity level (`sign_up_requires_approval` / `sign_up_block` / `no_access`).
  final String severity;

  /// Reason for the block.
  final String? comment;

  /// Expiration time in seconds. Omit for permanent.
  final int? expiresIn;

  /// Converts to a JSON map for the request body.
  Map<String, dynamic> toJson() => {
    'ip': ?ip,
    'severity': severity,
    'comment': ?comment,
    'expires_in': ?expiresIn,
  };
}

/// Request for updating an admin IP block.
///
/// Request body for `PUT /api/v1/admin/ip_blocks/:id`.
/// All fields are optional (partial update).
class MastodonAdminIpBlockUpdateRequest {
  /// Creates a [MastodonAdminIpBlockUpdateRequest].
  const MastodonAdminIpBlockUpdateRequest({
    this.ip,
    this.severity,
    this.comment,
    this.expiresIn,
  });

  /// IP address range to block (CIDR notation).
  final String? ip;

  /// Severity level (`sign_up_requires_approval` / `sign_up_block` / `no_access`).
  final String? severity;

  /// Reason for the block.
  final String? comment;

  /// Expiration time in seconds. Omit for permanent.
  final int? expiresIn;

  /// Converts to a JSON map for the request body.
  Map<String, dynamic> toJson() => {
    'ip': ?ip,
    'severity': ?severity,
    'comment': ?comment,
    'expires_in': ?expiresIn,
  };
}
