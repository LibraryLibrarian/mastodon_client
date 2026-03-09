/// メディアの種別
enum MastodonMediaType {
  unknown,
  image,
  gifv,
  video,
  audio
  ;

  static MastodonMediaType fromString(String? value) {
    return switch (value) {
      'image' => MastodonMediaType.image,
      'gifv' => MastodonMediaType.gifv,
      'video' => MastodonMediaType.video,
      'audio' => MastodonMediaType.audio,
      _ => MastodonMediaType.unknown,
    };
  }
}

/// Mastodon のメディア添付ファイル
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

  factory MastodonMediaAttachment.fromJson(Map<String, dynamic> json) {
    return MastodonMediaAttachment(
      id: json['id'] as String,
      type: MastodonMediaType.fromString(json['type'] as String?),
      url: json['url'] as String?,
      previewUrl: json['preview_url'] as String?,
      remoteUrl: json['remote_url'] as String?,
      description: json['description'] as String?,
      blurhash: json['blurhash'] as String?,
    );
  }

  /// メディアの内部ID
  final String id;

  /// メディアの種別
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
