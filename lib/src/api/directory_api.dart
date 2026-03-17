import '../client/mastodon_http_client.dart';
import '../models/mastodon_account.dart';

/// プロフィールディレクトリに関する API クライアント
class DirectoryApi {
  /// [MastodonHttpClient] を受け取り、ディレクトリ API へのアクセスを提供する
  const DirectoryApi(this._http);

  final MastodonHttpClient _http;

  /// プロフィールディレクトリに掲載されているアカウント一覧を取得する
  ///
  /// `GET /api/v1/directory`
  ///
  /// 認証不要。
  ///
  /// - [offset]: 先頭 n 件をスキップする
  /// - [limit]: 取得件数（デフォルト: 40、最大: 80）
  /// - [order]: ソート順。`active`（最近投稿順）または `new`（作成日順）
  /// - [local]: `true` の場合、ローカルアカウントのみを返す
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAccount>> fetch({
    int? offset,
    int? limit,
    String? order,
    bool? local,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/directory',
      queryParameters: <String, dynamic>{
        'offset': ?offset,
        'limit': ?limit,
        'order': ?order,
        'local': ?local,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }
}
