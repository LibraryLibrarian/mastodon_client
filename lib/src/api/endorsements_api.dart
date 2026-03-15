import '../client/mastodon_http_client.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_account_page.dart';

/// フィーチャー中アカウント（エンドースメント）の一覧取得に関する API クライアント
class EndorsementsApi {
  /// [MastodonHttpClient] を受け取り、エンドースメント API へのアクセスを提供する
  const EndorsementsApi(this._http);

  final MastodonHttpClient _http;

  /// 自分がプロフィールでフィーチャーしているアカウントの一覧を取得する
  ///
  /// `GET /api/v1/endorsements`
  ///
  /// - [limit]: 最大取得件数（デフォルト: 40、上限: 80）
  /// - [maxId]: このIDより古い結果を返す（ページネーション用カーソル）
  /// - [sinceId]: このIDより新しい結果を返す
  ///
  /// レスポンスの `Link` ヘッダーから次ページの `max_id` を解析し、
  /// [MastodonAccountPage.nextMaxId] に格納する。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAccountPage> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/endorsements',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
      },
    );
    final accounts = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
    final nextMaxId = _parseNextMaxId(
      response.headers.map['link']?.join(','),
    );
    return MastodonAccountPage(accounts: accounts, nextMaxId: nextMaxId);
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
