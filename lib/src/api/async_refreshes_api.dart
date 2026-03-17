import '../client/mastodon_http_client.dart';
import '../models/mastodon_async_refresh.dart';

/// 非同期リフレッシュのステータス確認に関する API クライアント（実験的）
///
/// Mastodon 4.4.0 で追加された実験的 API。
/// バックグラウンドジョブの進行状況を確認するために使用する。
class AsyncRefreshesApi {
  /// [MastodonHttpClient] を受け取り、非同期リフレッシュ API へのアクセスを提供する
  const AsyncRefreshesApi(this._http);

  final MastodonHttpClient _http;

  /// 非同期リフレッシュ操作のステータスを取得する
  ///
  /// `GET /api/v1_alpha/async_refreshes/{id}`
  ///
  /// 認証必須（`read` スコープ）。
  ///
  /// - [id]: 非同期リフレッシュの識別子。他 API レスポンスの
  ///   `Mastodon-Async-Refresh` ヘッダーから取得される
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAsyncRefresh> fetch(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1_alpha/async_refreshes/$id',
    );
    final inner = data!['async_refresh'] as Map<String, dynamic>;
    return MastodonAsyncRefresh.fromJson(inner);
  }
}
