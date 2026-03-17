/// `Link` レスポンスヘッダーのパースユーティリティ
///
/// Mastodon API のページネーションで使用される `Link` ヘッダーから
/// `max_id`（次ページ）および `min_id` / `since_id`（前ページ）の
/// カーソル値を取り出す。
library;

/// `Link` ヘッダーから `rel="next"` の `max_id` クエリパラメーターを取り出す
///
/// 次ページが存在しない場合、または解析できない場合は `null` を返す。
String? parseNextMaxId(String? linkHeader) {
  return _extractQueryParam(linkHeader, 'next', 'max_id');
}

/// `Link` ヘッダーから `rel="prev"` の前方向カーソル値を取り出す
///
/// エンドポイントによって `min_id` または `since_id` が使われるため、
/// `min_id` を優先的に探し、見つからない場合は `since_id` にフォールバックする。
/// 前ページが存在しない場合、または解析できない場合は `null` を返す。
String? parsePrevMinId(String? linkHeader) {
  return _extractQueryParam(linkHeader, 'prev', 'min_id') ??
      _extractQueryParam(linkHeader, 'prev', 'since_id');
}

String? _extractQueryParam(String? linkHeader, String rel, String param) {
  if (linkHeader == null) return null;
  for (final segment in linkHeader.split(',')) {
    final trimmed = segment.trim();
    if (!trimmed.contains('rel="$rel"')) continue;
    final start = trimmed.indexOf('<');
    final end = trimmed.indexOf('>');
    if (start == -1 || end == -1 || end <= start + 1) continue;
    final url = trimmed.substring(start + 1, end);
    final value = Uri.tryParse(url)?.queryParameters[param];
    if (value != null && value.isNotEmpty) return value;
  }
  return null;
}
