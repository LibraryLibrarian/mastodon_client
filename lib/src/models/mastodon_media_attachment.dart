import 'package:json_annotation/json_annotation.dart';

part 'mastodon_media_attachment.g.dart';

/// メディアの種別
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonMediaType {
  unknown,
  image,
  gifv,
  video,
  audio,
}

/// Mastodon のメディア添付ファイル
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonMediaAttachment {
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

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonMediaAttachmentToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'unknown';

  /// メディアの内部ID
  final String id;

  /// メディアの種別
  @JsonKey(readValue: _readType, unknownEnumValue: MastodonMediaType.unknown)
  final MastodonMediaType type;

  /// メディアのURL 非同期処理中の場合はnullになることがある
  final String? url;

  /// サムネイル画像のURL
  final String? previewUrl;

  /// リモートインスタンスの元URL
  final String? remoteUrl;

  /// 代替テキスト（スクリーンリーダー用）
  final String? description;

  /// blurhash文字列
  final String? blurhash;
}
