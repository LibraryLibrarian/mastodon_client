/// Request for performing an admin account action.
///
/// Request body for `POST /api/v1/admin/accounts/:id/action`.
class MastodonAdminAccountActionRequest {
  /// Creates a [MastodonAdminAccountActionRequest].
  const MastodonAdminAccountActionRequest({
    required this.type,
    this.reportId,
    this.warningPresetId,
    this.text,
    this.sendEmailNotification,
  });

  /// Type of action (`none` / `sensitive` / `disable` / `silence` / `suspend`).
  final String type;

  /// ID of the associated report.
  final String? reportId;

  /// ID of the warning preset.
  final String? warningPresetId;

  /// Additional explanation text.
  final String? text;

  /// Whether to send an email notification to the user.
  final bool? sendEmailNotification;

  /// Converts to a JSON map for the request body.
  Map<String, dynamic> toJson() => {
    'type': type,
    'report_id': ?reportId,
    'warning_preset_id': ?warningPresetId,
    'text': ?text,
    'send_email_notification': ?sendEmailNotification,
  };
}
