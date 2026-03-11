/// プレビューカードの種別
enum MastodonPreviewCardType {
  /// リンク型のOEmbed
  link,

  /// 写真型のOEmbed
  photo,

  /// 動画型のOEmbed
  video,

  /// リッチ型のOEmbed
  rich
  ;

  static MastodonPreviewCardType fromString(String? value) {
    return switch (value) {
      'photo' => MastodonPreviewCardType.photo,
      'video' => MastodonPreviewCardType.video,
      'rich' => MastodonPreviewCardType.rich,
      _ => MastodonPreviewCardType.link,
    };
  }
}

/// リンク先のプレビューカード
///
/// `GET /api/v1/statuses/:id/card` のレスポンスに対応する
class MastodonPreviewCard {
  const MastodonPreviewCard({
    required this.url,
    required this.title,
    required this.description,
    required this.type,
    required this.authorName,
    required this.authorUrl,
    required this.providerName,
    required this.providerUrl,
    required this.html,
    required this.width,
    required this.height,
    required this.embedUrl,
    required this.authors,
    this.image,
    this.blurhash,
  });

  factory MastodonPreviewCard.fromJson(Map<String, dynamic> json) {
    return MastodonPreviewCard(
      url: json['url'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      type: MastodonPreviewCardType.fromString(json['type'] as String?),
      authorName: json['author_name'] as String? ?? '',
      authorUrl: json['author_url'] as String? ?? '',
      providerName: json['provider_name'] as String? ?? '',
      providerUrl: json['provider_url'] as String? ?? '',
      html: json['html'] as String? ?? '',
      width: json['width'] as int? ?? 0,
      height: json['height'] as int? ?? 0,
      image: json['image'] as String?,
      embedUrl: json['embed_url'] as String? ?? '',
      blurhash: json['blurhash'] as String?,
      authors:
          (json['authors'] as List<dynamic>?)
              ?.map(
                (a) => MastodonPreviewCardAuthor.fromJson(
                  a as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  /// リンク先のURL
  final String url;

  /// リンク先のタイトル
  final String title;

  /// プレビューの説明文
  final String description;

  /// プレビューカードの種別
  final MastodonPreviewCardType type;

  /// コンテンツ作成者の名前
  ///
  /// Mastodon 4.3.0以降は非推奨。代わりに [authors] を使用する。
  final String authorName;

  /// コンテンツ作成者のURL
  ///
  /// Mastodon 4.3.0以降は非推奨。代わりに [authors] を使用する。
  final String authorUrl;

  /// コンテンツ提供元の名前
  final String providerName;

  /// コンテンツ提供元のURL
  final String providerUrl;

  /// プレビュー生成用のHTML
  final String html;

  /// プレビューの幅（ピクセル）
  final int width;

  /// プレビューの高さ（ピクセル）
  final int height;

  /// プレビューサムネイルのURL。存在しない場合は `null`
  final String? image;

  /// 写真埋め込み用のURL
  final String embedUrl;

  /// サムネイル用のBlurhash文字列。存在しない場合は `null`
  final String? blurhash;

  /// コンテンツ作成者のリスト（Mastodon 4.3.0+）
  final List<MastodonPreviewCardAuthor> authors;
}

/// プレビューカードの作成者情報（Mastodon 4.3.0+）
class MastodonPreviewCardAuthor {
  const MastodonPreviewCardAuthor({required this.name, this.url, this.account});

  factory MastodonPreviewCardAuthor.fromJson(Map<String, dynamic> json) {
    return MastodonPreviewCardAuthor(
      name: json['name'] as String? ?? '',
      url: json['url'] as String?,
      account: json['account'] as String?,
    );
  }

  /// 作成者の名前
  final String name;

  /// 作成者のプロフィールURL
  final String? url;

  /// 作成者のFediverseアカウントURI
  final String? account;
}
