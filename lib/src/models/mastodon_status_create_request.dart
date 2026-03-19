import 'mastodon_status.dart';

/// Poll parameters for status creation.
class MastodonPollCreateRequest {
  /// Creates poll parameters for status creation.
  const MastodonPollCreateRequest({
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

  /// Whether to hide total vote counts until the poll ends.
  final bool hideTotals;
}

/// Parameters for a status creation request.
class MastodonStatusCreateRequest {
  /// Creates parameters for a status creation request.
  const MastodonStatusCreateRequest({
    this.status,
    this.mediaIds,
    this.inReplyToId,
    this.visibility = MastodonVisibility.public,
    this.sensitive = false,
    this.spoilerText,
    this.poll,
    this.quotedStatusId,
    this.quoteApprovalPolicy,
    this.language,
    this.scheduledAt,
  });

  /// Body text of the status.
  final String? status;

  /// List of attached media IDs.
  final List<String>? mediaIds;

  /// ID of the status being replied to.
  final String? inReplyToId;

  /// Visibility of the status.
  final MastodonVisibility visibility;

  /// Whether to mark as sensitive content.
  final bool sensitive;

  /// Content warning (CW) text.
  final String? spoilerText;

  /// Poll parameters.
  final MastodonPollCreateRequest? poll;

  /// ID of the status being quoted (standard Mastodon FEP-044f).
  ///
  /// Included as `quoted_status_id` in the request.
  final String? quotedStatusId;

  /// Quote approval policy (standard Mastodon FEP-044f).
  ///
  /// Included as `quote_approval_policy` in the request.
  final String? quoteApprovalPolicy;

  /// Posting language code (ISO 639-1 format).
  final String? language;

  /// Scheduled publication timestamp (ISO 8601 format).
  ///
  /// When specified, the status is scheduled instead of posted immediately.
  /// Must be at least 5 minutes in the future.
  final String? scheduledAt;

  /// Returns a JSON map for the request body.
  Map<String, dynamic> toJson() {
    final visibilityString = switch (visibility) {
      MastodonVisibility.public => 'public',
      MastodonVisibility.unlisted => 'unlisted',
      MastodonVisibility.private => 'private',
      MastodonVisibility.direct => 'direct',
    };

    final map = <String, dynamic>{
      'visibility': visibilityString,
      'sensitive': sensitive,
    };

    if (status != null) {
      map['status'] = status;
    }
    if (mediaIds != null) {
      map['media_ids'] = mediaIds;
    }
    if (inReplyToId != null) {
      map['in_reply_to_id'] = inReplyToId;
    }
    if (spoilerText != null) {
      map['spoiler_text'] = spoilerText;
    }
    if (poll != null) {
      map['poll'] = <String, dynamic>{
        'options': poll!.options,
        'expires_in': poll!.expiresIn,
        'multiple': poll!.multiple,
        'hide_totals': poll!.hideTotals,
      };
    }
    if (quotedStatusId != null) {
      map['quoted_status_id'] = quotedStatusId;
    }
    if (quoteApprovalPolicy != null) {
      map['quote_approval_policy'] = quoteApprovalPolicy;
    }
    if (language != null) {
      map['language'] = language;
    }
    if (scheduledAt != null) {
      map['scheduled_at'] = scheduledAt;
    }

    return map;
  }
}
