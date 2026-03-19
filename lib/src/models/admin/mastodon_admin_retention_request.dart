/// Request for fetching admin retention data.
///
/// Request body for `POST /api/v1/admin/retention`.
class MastodonAdminRetentionRequest {
  /// Creates a [MastodonAdminRetentionRequest].
  const MastodonAdminRetentionRequest({
    required this.startAt,
    required this.endAt,
    required this.frequency,
  });

  /// Start date (time portion is ignored).
  final DateTime startAt;

  /// End date (time portion is ignored).
  final DateTime endAt;

  /// Granularity of the data (`day` or `month`).
  final String frequency;

  /// Converts to a JSON map for the request body.
  Map<String, dynamic> toJson() => {
    'start_at': startAt.toIso8601String(),
    'end_at': endAt.toIso8601String(),
    'frequency': frequency,
  };
}
