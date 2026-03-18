/// Media attribute parameters for status editing.
class MastodonMediaAttributeRequest {
  /// Creates media attribute parameters for status editing.
  const MastodonMediaAttributeRequest({
    required this.id,
    this.description,
    this.focus,
  });

  /// Internal ID of the media.
  final String id;

  /// Alt text (for screen readers).
  final String? description;

  /// Focal point (`x,y` format, each value from -1.0 to 1.0).
  final String? focus;
}

/// Poll parameters for status editing.
class MastodonPollEditRequest {
  /// Creates poll parameters for status editing.
  const MastodonPollEditRequest({
    required this.options,
    required this.expiresIn,
    this.multiple = false,
    this.hideTotals = false,
  });

  /// List of options.
  final List<String> options;

  /// Poll duration in seconds.
  final int expiresIn;

  /// Whether to allow multiple choices.
  final bool multiple;

  /// Whether to hide total vote counts.
  final bool hideTotals;
}

/// Parameters for a status edit request.
///
/// Corresponds to the request body for `PUT /api/v1/statuses/:id`.
class MastodonStatusEditRequest {
  /// Creates parameters for a status edit request.
  const MastodonStatusEditRequest({
    this.status,
    this.spoilerText,
    this.sensitive,
    this.language,
    this.mediaIds,
    this.mediaAttributes,
    this.poll,
    this.quoteApprovalPolicy,
  });

  /// Body text of the status.
  final String? status;

  /// Content warning (CW) text.
  final String? spoilerText;

  /// Whether to mark as sensitive content.
  final bool? sensitive;

  /// Posting language code (ISO 639-1 format).
  final String? language;

  /// List of attached media IDs.
  final List<String>? mediaIds;

  /// Attributes for each media (description and focal point).
  final List<MastodonMediaAttributeRequest>? mediaAttributes;

  /// Poll parameters.
  final MastodonPollEditRequest? poll;

  /// Quote approval policy (`public` / `followers` / `nobody`).
  final String? quoteApprovalPolicy;

  /// Returns a JSON map for the request body.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (status != null) {
      map['status'] = status;
    }
    if (spoilerText != null) {
      map['spoiler_text'] = spoilerText;
    }
    if (sensitive != null) {
      map['sensitive'] = sensitive;
    }
    if (language != null) {
      map['language'] = language;
    }
    if (mediaIds != null) {
      map['media_ids'] = mediaIds;
    }
    if (mediaAttributes != null) {
      map['media_attributes'] = mediaAttributes!
          .map(
            (a) => <String, dynamic>{
              'id': a.id,
              if (a.description != null) 'description': a.description,
              if (a.focus != null) 'focus': a.focus,
            },
          )
          .toList();
    }
    if (poll != null) {
      map['poll'] = <String, dynamic>{
        'options': poll!.options,
        'expires_in': poll!.expiresIn,
        'multiple': poll!.multiple,
        'hide_totals': poll!.hideTotals,
      };
    }
    if (quoteApprovalPolicy != null) {
      map['quote_approval_policy'] = quoteApprovalPolicy;
    }

    return map;
  }
}
