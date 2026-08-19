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
    this.previewRemoteUrl,
    this.textUrl,
    this.meta,
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

  /// Original thumbnail URL on the remote instance.
  @override
  final String? previewRemoteUrl;

  /// Legacy shortened URL for the media attachment.
  ///
  /// Deprecated by Mastodon in 3.5.0 and always `null` on recent servers.
  @Deprecated('Use url instead.')
  @override
  final String? textUrl;

  /// Media metadata returned by the server.
  ///
  /// Its structure depends on the media type and may contain `original`,
  /// `small`, `focus`, and audio-specific entries.
  @override
  final Map<String, dynamic>? meta;

  /// Alt text (for screen readers).
  @override
  final String? description;

  /// Blurhash string.
  @override
  final String? blurhash;
}
