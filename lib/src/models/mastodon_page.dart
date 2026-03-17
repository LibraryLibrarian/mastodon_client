/// ページネーション対応のリスト結果を表す汎用モデル
///
/// Mastodon API のカーソルベースページネーション（`Link` ヘッダー）から
/// 次ページ・前ページのカーソル値を保持する。
class MastodonPage<T> {
  /// [items] にページ内のアイテム一覧、[nextMaxId] と [prevMinId] に
  /// ページネーションカーソルを指定して生成する
  const MastodonPage({
    required this.items,
    this.nextMaxId,
    this.prevMinId,
  });

  /// ページ内のアイテム一覧
  final List<T> items;

  /// 次ページ取得に使用する `max_id` カーソル。次ページが存在しない場合は `null`
  final String? nextMaxId;

  /// 前ページ取得に使用する `min_id` カーソル。前ページが存在しない場合は `null`
  final String? prevMinId;
}
