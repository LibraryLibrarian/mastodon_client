import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_page.dart';
import 'accounts_api.dart' show AccountsApi;

/// ブロック中アカウントの一覧取得に関する API クライアント
class BlocksApi {
  /// [MastodonHttpClient] を受け取り、ブロック API へのアクセスを提供する
  const BlocksApi(this._http);

  final MastodonHttpClient _http;

  /// ブロック中のアカウント一覧を取得する
  ///
  /// `GET /api/v1/blocks`
  ///
  /// - [limit]: 最大取得件数（デフォルト: 40、上限: 80）
  /// - [maxId]: このIDより古い結果を返す（ページネーション用カーソル）
  /// - [sinceId]: このIDより新しい結果を返す
  /// - [minId]: このIDより新しい結果を返す（逆順）
  ///
  /// レスポンスの `Link` ヘッダーから次ページの `max_id` および前ページの
  /// `min_id` を解析し、[MastodonPage] に格納する。
  ///
  /// ブロックの実行・解除は [AccountsApi] の `block` / `unblock` を使用する。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPage<MastodonAccount>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/blocks',
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
        .map(MastodonAccount.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }
}
