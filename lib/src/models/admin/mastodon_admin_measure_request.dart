/// Request for fetching admin measure data.
///
/// Request body for `POST /api/v1/admin/measures`.
class MastodonAdminMeasureRequest {
  /// Creates a [MastodonAdminMeasureRequest].
  const MastodonAdminMeasureRequest({
    required this.keys,
    required this.startAt,
    required this.endAt,
    this.tagAccountsId,
    this.tagUsesId,
    this.tagServersId,
    this.instanceAccountsDomain,
    this.instanceMediaAttachmentsDomain,
    this.instanceReportsDomain,
    this.instanceStatusesDomain,
    this.instanceFollowsDomain,
    this.instanceFollowersDomain,
  });

  /// List of measure keys to fetch.
  ///
  /// Valid values: `active_users`, `new_users`, `interactions`,
  /// `opened_reports`, `resolved_reports`, `tag_accounts`, `tag_uses`,
  /// `tag_servers`, `instance_accounts`, `instance_media_attachments`,
  /// `instance_reports`, `instance_statuses`, `instance_follows`,
  /// `instance_followers`
  final List<String> keys;

  /// Start date (time portion is ignored).
  final DateTime startAt;

  /// End date (time portion is ignored).
  final DateTime endAt;

  /// Tag ID required for the `tag_accounts` key.
  final String? tagAccountsId;

  /// Tag ID required for the `tag_uses` key.
  final String? tagUsesId;

  /// Tag ID required for the `tag_servers` key.
  final String? tagServersId;

  /// Domain required for the `instance_accounts` key.
  final String? instanceAccountsDomain;

  /// Domain required for the `instance_media_attachments` key.
  final String? instanceMediaAttachmentsDomain;

  /// Domain required for the `instance_reports` key.
  final String? instanceReportsDomain;

  /// Domain required for the `instance_statuses` key.
  final String? instanceStatusesDomain;

  /// Domain required for the `instance_follows` key.
  final String? instanceFollowsDomain;

  /// Domain required for the `instance_followers` key.
  final String? instanceFollowersDomain;

  /// Converts to a JSON map for the request body.
  Map<String, dynamic> toJson() => {
    'keys': keys,
    'start_at': startAt.toIso8601String(),
    'end_at': endAt.toIso8601String(),
    if (tagAccountsId != null) 'tag_accounts': {'id': tagAccountsId},
    if (tagUsesId != null) 'tag_uses': {'id': tagUsesId},
    if (tagServersId != null) 'tag_servers': {'id': tagServersId},
    if (instanceAccountsDomain != null)
      'instance_accounts': {'domain': instanceAccountsDomain},
    if (instanceMediaAttachmentsDomain != null)
      'instance_media_attachments': {'domain': instanceMediaAttachmentsDomain},
    if (instanceReportsDomain != null)
      'instance_reports': {'domain': instanceReportsDomain},
    if (instanceStatusesDomain != null)
      'instance_statuses': {'domain': instanceStatusesDomain},
    if (instanceFollowsDomain != null)
      'instance_follows': {'domain': instanceFollowsDomain},
    if (instanceFollowersDomain != null)
      'instance_followers': {'domain': instanceFollowersDomain},
  };
}
