/// 投稿のソース情報
///
/// `GET /api/v1/statuses/:id/source`
///
/// 編集画面で使用するプレーンテキストの投稿内容を保持
class MastodonStatusSource {
  const MastodonStatusSource({
    required this.id,
    required this.text,
    required this.spoilerText,
  });

  factory MastodonStatusSource.fromJson(Map<String, dynamic> json) {
    return MastodonStatusSource(
      id: json['id'] as String,
      text: json['text'] as String,
      spoilerText: json['spoiler_text'] as String? ?? '',
    );
  }

  /// 投稿の内部ID
  final String id;

  /// 投稿本文のプレーンテキスト
  final String text;

  /// コンテンツ警告（CW）のプレーンテキスト
  final String spoilerText;
}
