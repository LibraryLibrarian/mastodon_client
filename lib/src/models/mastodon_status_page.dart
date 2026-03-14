import 'mastodon_status.dart';

/// お気に入り・ブックマークなどの投稿一覧と次ページカーソルをまとめた結果
class MastodonStatusPage {
  /// [statuses] に取得した投稿一覧、[nextMaxId] に次ページカーソルを指定する
  const MastodonStatusPage({required this.statuses, this.nextMaxId});

  /// 取得した投稿の一覧
  final List<MastodonStatus> statuses;

  /// 次ページ取得に使用する `max_id` カーソル。次ページが存在しない場合は `null`
  final String? nextMaxId;
}
