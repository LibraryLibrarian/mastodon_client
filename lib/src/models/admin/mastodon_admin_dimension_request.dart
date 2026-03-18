/// Request for fetching admin dimension data.
///
/// Request body for `POST /api/v1/admin/dimensions`.
class MastodonAdminDimensionRequest {
  /// Creates a [MastodonAdminDimensionRequest].
  const MastodonAdminDimensionRequest({
    required this.keys,
    this.startAt,
    this.endAt,
    this.limit,
    this.tagServersId,
    this.tagLanguagesId,
    this.instanceAccountsDomain,
    this.instanceLanguagesDomain,
  });

  /// List of dimension keys to fetch.
  ///
  /// Valid values: `languages`, `sources`, `servers`, `space_usage`,
  /// `software_versions`, `tag_servers`, `tag_languages`,
  /// `instance_accounts`, `instance_languages`
  final List<String> keys;

  /// Start date (time portion is ignored).
  final DateTime? startAt;

  /// End date (time portion is ignored).
  final DateTime? endAt;

  /// Maximum number of results for sources/servers/languages, etc.
  final int? limit;

  /// Tag ID required for the `tag_servers` key.
  final String? tagServersId;

  /// Tag ID required for the `tag_languages` key.
  final String? tagLanguagesId;

  /// Domain required for the `instance_accounts` key.
  final String? instanceAccountsDomain;

  /// Domain required for the `instance_languages` key.
  final String? instanceLanguagesDomain;

  /// Converts to a JSON map for the request body.
  Map<String, dynamic> toJson() => {
    'keys': keys,
    'start_at': ?startAt?.toIso8601String(),
    'end_at': ?endAt?.toIso8601String(),
    'limit': ?limit,
    if (tagServersId != null) 'tag_servers': {'id': tagServersId},
    if (tagLanguagesId != null) 'tag_languages': {'id': tagLanguagesId},
    if (instanceAccountsDomain != null)
      'instance_accounts': {'domain': instanceAccountsDomain},
    if (instanceLanguagesDomain != null)
      'instance_languages': {'domain': instanceLanguagesDomain},
  };
}
