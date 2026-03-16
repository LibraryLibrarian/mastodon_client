import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_status.dart';

/// お気に入りした投稿の一覧取得に関するAPI
class FavouritesApi {
  /// [MastodonHttpClient] を受け取り、お気に入りAPIへのアクセスを提供する
  const FavouritesApi(this._http);

  final MastodonHttpClient _http;

  /// 認証済みユーザーがお気に入りした投稿の一覧を取得する
  ///
  /// `GET /api/v1/favourites`
  ///
  /// - [limit]: 最大取得件数（デフォルト: 20、上限: 40）
  /// - [maxId]: このIDより古い結果を返す（ページネーション用カーソル）
  /// - [sinceId]: このIDより新しい結果を返す
  /// - [minId]: このIDより新しい結果を返す（逆順）
  ///
  /// レスポンスの `Link` ヘッダーから次ページの `max_id` および前ページの
  /// `min_id` を解析し、[MastodonPage] に格納する。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPage<MastodonStatus>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/favourites',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }
}
