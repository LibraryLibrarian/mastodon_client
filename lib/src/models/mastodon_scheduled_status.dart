import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_media_attachment.dart';

part 'mastodon_scheduled_status.g.dart';

/// Scheduled status model.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonScheduledStatus {
  /// Creates a [MastodonScheduledStatus] with the given fields.
  const MastodonScheduledStatus({
    required this.id,
    this.scheduledAt,
    this.params,
    this.mediaAttachments = const [],
  });

  /// Creates a [MastodonScheduledStatus] from a JSON map.
  factory MastodonScheduledStatus.fromJson(Map<String, dynamic> json) =>
      _$MastodonScheduledStatusFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonScheduledStatusToJson(this);

  /// Database ID of the scheduled status.
  final String id;

  /// Timestamp when the status is scheduled to be published.
  @SafeDateTimeConverter()
  final DateTime? scheduledAt;

  /// Parameters specified when scheduling the status.
  final MastodonScheduledStatusParams? params;

  /// Media to be attached to the status.
  @JsonKey(defaultValue: [])
  final List<MastodonMediaAttachment> mediaAttachments;
}

/// Parameters of a scheduled status.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonScheduledStatusParams {
  /// Creates a [MastodonScheduledStatusParams] with the given fields.
  const MastodonScheduledStatusParams({
    required this.text,
    this.poll,
    this.mediaIds,
    this.sensitive,
    this.spoilerText,
    this.visibility,
    this.inReplyToId,
    this.language,
    this.idempotency,
  });

  /// Creates a [MastodonScheduledStatusParams] from a JSON map.
  factory MastodonScheduledStatusParams.fromJson(Map<String, dynamic> json) =>
      _$MastodonScheduledStatusParamsFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonScheduledStatusParamsToJson(this);

  /// Body text of the status.
  @JsonKey(defaultValue: '')
  final String text;

  /// Poll parameters (`null` if no poll).
  final MastodonScheduledStatusPoll? poll;

  /// Array of MediaAttachment IDs to attach.
  final List<String>? mediaIds;

  /// Whether to mark as sensitive (content warning).
  final bool? sensitive;

  /// Content warning text.
  final String? spoilerText;

  /// Visibility (`public` / `unlisted` / `private` / `direct`).
  final String? visibility;

  /// ID of the status being replied to.
  ///
  /// Normalizes to `String` regardless of whether the server returns an
  /// integer or string.
  @JsonKey(fromJson: flexibleIdFromJson)
  final String? inReplyToId;

  /// Posting language (ISO 639-1 code).
  final String? language;

  /// Idempotency key.
  final String? idempotency;
}

/// Poll parameters of a scheduled status.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonScheduledStatusPoll {
  /// Creates a [MastodonScheduledStatusPoll] with the given fields.
  const MastodonScheduledStatusPoll({
    this.options = const [],
    required this.expiresIn,
    this.multiple,
    this.hideTotals,
  });

  /// Creates a [MastodonScheduledStatusPoll] from a JSON map.
  factory MastodonScheduledStatusPoll.fromJson(Map<String, dynamic> json) =>
      _$MastodonScheduledStatusPollFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonScheduledStatusPollToJson(this);

  /// Poll options.
  @JsonKey(defaultValue: [])
  final List<String> options;

  /// Number of seconds until the poll closes.
  final int expiresIn;

  /// Whether to allow multiple choices.
  final bool? multiple;

  /// Whether to hide total vote counts until the poll ends.
  final bool? hideTotals;
}
