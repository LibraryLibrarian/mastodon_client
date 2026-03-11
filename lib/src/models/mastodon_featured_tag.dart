/// アカウントのプロフィールで紹介されているハッシュタグ
class MastodonFeaturedTag {
  /// 各フィールドを指定して [MastodonFeaturedTag] を生成する
  const MastodonFeaturedTag({
    required this.id,
    required this.name,
    required this.url,
    required this.statusesCount,
    this.lastStatusAt,
  });

  /// JSON マップから [MastodonFeaturedTag] を生成する
  factory MastodonFeaturedTag.fromJson(Map<String, dynamic> json) {
    return MastodonFeaturedTag(
      id: json['id'] as String,
      name: json['name'] as String,
      url: json['url'] as String? ?? '',
      statusesCount:
          int.tryParse(
            json['statuses_count']?.toString() ?? '',
          ) ??
          0,
      lastStatusAt: json['last_status_at'] != null
          ? DateTime.tryParse(json['last_status_at'] as String)
          : null,
    );
  }

  /// 紹介タグの内部 ID
  final String id;

  /// 紹介されているハッシュタグの名前
  final String name;

  /// このハッシュタグを含む投稿一覧への URL
  final String url;

  /// このハッシュタグを含む投稿の件数
  final int statusesCount;

  /// このハッシュタグを含む最新投稿の日付
  final DateTime? lastStatusAt;
}
