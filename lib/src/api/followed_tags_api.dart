import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_tag.dart';

/// フォロー中のハッシュタグの一覧取得に関するAPI
class FollowedTagsApi {
  /// [MastodonHttpClient] を受け取り、フォロー中タグAPIへのアクセスを提供する
  const FollowedTagsApi(this._http);

  final MastodonHttpClient _http;

  /// 認証済みユーザーがフォローしているハッシュタグの一覧を取得する
  ///
  /// `GET /api/v1/followed_tags`
  ///
  /// - [limit]: 最大取得件数（デフォルト: 100、上限: 200）
  /// - [maxId]: このIDより古い結果を返す（ページネーション用カーソル）
  /// - [sinceId]: このIDより新しい結果を返す
  /// - [minId]: このIDより新しい結果を返す（逆順）
  ///
  /// ページネーションは HTTP `Link` ヘッダーで提供される。
  /// カーソルIDは Tag エンティティの ID ではなく内部的なフォロー関係レコードの ID。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPage<MastodonTag>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/followed_tags',
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
        .map(MastodonTag.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }
}
