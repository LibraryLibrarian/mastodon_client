import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_media_attachment.freezed.dart';
part 'mastodon_media_attachment.g.dart';

/// Type of media.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonMediaType { unknown, image, gifv, video, audio }

/// Media attachment on Mastodon.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonMediaAttachment with _$MastodonMediaAttachment {
  const MastodonMediaAttachment({
    required this.id,
    required this.type,
    this.url,
    this.previewUrl,
    this.remoteUrl,
    this.description,
    this.blurhash,
  });

  factory MastodonMediaAttachment.fromJson(Map<String, dynamic> json) =>
      _$MastodonMediaAttachmentFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonMediaAttachmentToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'unknown';

  /// Internal ID of the media.
  @override
  final String id;

  /// Type of the media.
  @JsonKey(readValue: _readType, unknownEnumValue: MastodonMediaType.unknown)
  @override
  final MastodonMediaType type;

  /// URL of the media. May be null during asynchronous processing.
  @override
  final String? url;

  /// URL of the thumbnail image.
  @override
  final String? previewUrl;

  /// Original URL on the remote instance.
  @override
  final String? remoteUrl;

  /// Alt text (for screen readers).
  @override
  final String? description;

  /// Blurhash string.
  @override
  final String? blurhash;
}
