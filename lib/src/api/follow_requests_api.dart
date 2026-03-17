import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_relationship.dart';

/// フォローリクエストの管理に関する API クライアント
class FollowRequestsApi {
  /// [MastodonHttpClient] を受け取り、フォローリクエスト API へのアクセスを提供する
  const FollowRequestsApi(this._http);

  final MastodonHttpClient _http;

  /// 保留中のフォローリクエスト一覧を取得する
  ///
  /// `GET /api/v1/follow_requests`
  ///
  /// - [limit]: 最大取得件数（デフォルト: 40、上限: 80）
  /// - [maxId]: このIDより古い結果を返す（ページネーション用カーソル）
  /// - [sinceId]: このIDより新しい結果を返す
  ///
  /// レスポンスの `Link` ヘッダーから次ページの `max_id` および前ページの
  /// `min_id` を解析し、[MastodonPage] に格納する。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPage<MastodonAccount>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/follow_requests',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
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

  /// フォローリクエストを承認する
  ///
  /// `POST /api/v1/follow_requests/{accountId}/authorize`
  ///
  /// - [accountId]: 承認するフォローリクエスト元のアカウント ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonRelationship> authorize(String accountId) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/follow_requests/$accountId/authorize',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// フォローリクエストを拒否する
  ///
  /// `POST /api/v1/follow_requests/{accountId}/reject`
  ///
  /// - [accountId]: 拒否するフォローリクエスト元のアカウント ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonRelationship> reject(String accountId) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/follow_requests/$accountId/reject',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }
}
