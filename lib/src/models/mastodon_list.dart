/// ユーザー定義のリスト
class MastodonList {
  /// 各フィールドを指定して [MastodonList] を生成する
  const MastodonList({
    required this.id,
    required this.title,
    required this.repliesPolicy,
    required this.exclusive,
  });

  /// JSON マップから [MastodonList] を生成する
  factory MastodonList.fromJson(Map<String, dynamic> json) {
    return MastodonList(
      id: json['id'] as String,
      title: json['title'] as String,
      repliesPolicy: json['replies_policy'] as String? ?? 'list',
      exclusive: json['exclusive'] as bool? ?? false,
    );
  }

  /// リストの内部 ID
  final String id;

  /// リストのタイトル
  final String title;

  /// リスト内に表示するリプライのポリシー（`followed`・`list`・`none`）
  final String repliesPolicy;

  /// リストメンバーの投稿をホームタイムラインから除外するかどうか
  final bool exclusive;
}
