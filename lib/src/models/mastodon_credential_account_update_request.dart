/// Parameters for a profile update request.
///
/// Corresponds to the request body for `PATCH /api/v1/accounts/update_credentials`.
class MastodonCredentialAccountUpdateRequest {
  /// Creates parameters for a profile update request.
  const MastodonCredentialAccountUpdateRequest({
    this.displayName,
    this.note,
    this.avatar,
    this.header,
    this.locked,
    this.bot,
    this.discoverable,
    this.hideCollections,
    this.indexable,
    this.fieldsAttributes,
    this.sourcePrivacy,
    this.sourceSensitive,
    this.sourceLanguage,
    this.sourceQuotePolicy,
    this.attributionDomains,
  });

  /// Display name.
  final String? displayName;

  /// Profile bio.
  final String? note;

  /// Avatar image (Base64-encoded data URI).
  final String? avatar;

  /// Header image (Base64-encoded data URI).
  final String? header;

  /// Whether to require follow approval.
  final bool? locked;

  /// Whether this is a bot account.
  final bool? bot;

  /// Whether to opt in to discovery features.
  final bool? discoverable;

  /// Whether to hide the follow/followers lists.
  final bool? hideCollections;

  /// Whether to allow search engine indexing.
  final bool? indexable;

  /// List of custom profile fields.
  final List<MastodonFieldAttribute>? fieldsAttributes;

  /// Default posting visibility (`public` / `unlisted` / `private` / `direct`).
  final String? sourcePrivacy;

  /// Whether to mark posts as sensitive by default.
  final bool? sourceSensitive;

  /// Default posting language (ISO 639-1 format).
  final String? sourceLanguage;

  /// Default quote approval policy (`public` / `followers` / `nobody`).
  final String? sourceQuotePolicy;

  /// List of attribution domains.
  final List<String>? attributionDomains;

  /// Returns a JSON map for the request body.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (displayName != null) map['display_name'] = displayName;
    if (note != null) map['note'] = note;
    if (avatar != null) map['avatar'] = avatar;
    if (header != null) map['header'] = header;
    if (locked != null) map['locked'] = locked;
    if (bot != null) map['bot'] = bot;
    if (discoverable != null) map['discoverable'] = discoverable;
    if (hideCollections != null) map['hide_collections'] = hideCollections;
    if (indexable != null) map['indexable'] = indexable;
    if (attributionDomains != null) {
      map['attribution_domains'] = attributionDomains;
    }
    if (fieldsAttributes != null) {
      map['fields_attributes'] = fieldsAttributes!
          .map(
            (f) => <String, dynamic>{
              'name': f.name,
              'value': f.value,
            },
          )
          .toList();
    }
    if (sourcePrivacy != null ||
        sourceSensitive != null ||
        sourceLanguage != null ||
        sourceQuotePolicy != null) {
      map['source'] = <String, dynamic>{
        if (sourcePrivacy != null) 'privacy': sourcePrivacy,
        if (sourceSensitive != null) 'sensitive': sourceSensitive,
        if (sourceLanguage != null) 'language': sourceLanguage,
        if (sourceQuotePolicy != null) 'quote_policy': sourceQuotePolicy,
      };
    }

    return map;
  }
}

/// Custom profile field attribute.
class MastodonFieldAttribute {
  /// Creates with the given field name and value.
  const MastodonFieldAttribute({
    required this.name,
    required this.value,
  });

  /// Label name of the field.
  final String name;

  /// Value of the field.
  final String value;
}
