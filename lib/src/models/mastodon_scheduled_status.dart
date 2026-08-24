import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_media_attachment.dart';

part 'mastodon_scheduled_status.freezed.dart';
part 'mastodon_scheduled_status.g.dart';

/// Scheduled status model.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonScheduledStatus with _$MastodonScheduledStatus {
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
  @override
  final String id;

  /// Timestamp when the status is scheduled to be published.
  @SafeDateTimeConverter()
  @override
  final DateTime? scheduledAt;

  /// Parameters specified when scheduling the status.
  @override
  final MastodonScheduledStatusParams? params;

  /// Media to be attached to the status.
  @JsonKey(defaultValue: [])
  @override
  final List<MastodonMediaAttachment> mediaAttachments;
}

/// Parameters of a scheduled status.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonScheduledStatusParams with _$MastodonScheduledStatusParams {
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
  @override
  final String text;

  /// Poll parameters (`null` if no poll).
  @override
  final MastodonScheduledStatusPoll? poll;

  /// Array of MediaAttachment IDs to attach.
  @override
  final List<String>? mediaIds;

  /// Whether to mark as sensitive (content warning).
  @override
  final bool? sensitive;

  /// Content warning text.
  @override
  final String? spoilerText;

  /// Visibility (`public` / `unlisted` / `private` / `direct`).
  @override
  final String? visibility;

  /// ID of the status being replied to.
  ///
  /// Normalizes to `String` regardless of whether the server returns an
  /// integer or string.
  @JsonKey(fromJson: flexibleIdFromJson)
  @override
  final String? inReplyToId;

  /// Posting language (ISO 639-1 code).
  @override
  final String? language;

  /// Idempotency key.
  @override
  final String? idempotency;
}

/// Poll parameters of a scheduled status.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonScheduledStatusPoll with _$MastodonScheduledStatusPoll {
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
  @override
  final List<String> options;

  /// Number of seconds until the poll closes.
  @override
  final int expiresIn;

  /// Whether to allow multiple choices.
  @override
  final bool? multiple;

  /// Whether to hide total vote counts until the poll ends.
  @override
  final bool? hideTotals;
}
