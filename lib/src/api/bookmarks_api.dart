import '../client/mastodon_http_client.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_status_page.dart';

/// ブックマークした投稿の一覧取得に関するAPI
class BookmarksApi {
  /// [MastodonHttpClient] を受け取り、ブックマークAPIへのアクセスを提供する
  const BookmarksApi(this._http);

  final MastodonHttpClient _http;

  /// 認証済みユーザーがブックマークした投稿の一覧を取得する
  ///
  /// `GET /api/v1/bookmarks`
  ///
  /// - [limit]: 最大取得件数（デフォルト: 20、上限: 40）
  /// - [maxId]: このIDより古い結果を返す（ページネーション用カーソル）
  /// - [sinceId]: このIDより新しい結果を返す
  /// - [minId]: このIDより新しい結果を返す（逆順）
  ///
  /// レスポンスの `Link` ヘッダーから次ページの `max_id` を解析し、
  /// [MastodonStatusPage.nextMaxId] に格納する。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonStatusPage> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/bookmarks',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    final statuses = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
    final nextMaxId = _parseNextMaxId(
      response.headers.map['link']?.join(','),
    );
    return MastodonStatusPage(statuses: statuses, nextMaxId: nextMaxId);
  }

  /// `Link` レスポンスヘッダーから `rel="next"` の `max_id` クエリパラメーターを
  /// 取り出す
  ///
  /// 次ページが存在しない場合、または解析できない場合は `null` を返す。
  String? _parseNextMaxId(String? linkHeader) {
    if (linkHeader == null) return null;
    for (final segment in linkHeader.split(',')) {
      final trimmed = segment.trim();
      if (!trimmed.contains('rel="next"')) continue;
      final start = trimmed.indexOf('<');
      final end = trimmed.indexOf('>');
      if (start == -1 || end == -1 || end <= start + 1) continue;
      final url = trimmed.substring(start + 1, end);
      final maxId = Uri.tryParse(url)?.queryParameters['max_id'];
      if (maxId != null && maxId.isNotEmpty) return maxId;
    }
    return null;
  }
}
