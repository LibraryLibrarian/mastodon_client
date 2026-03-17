import '../client/mastodon_http_client.dart';

/// サーバーヘルスチェックに関する API クライアント
class HealthApi {
  /// [MastodonHttpClient] を受け取り、ヘルス API へのアクセスを提供する
  const HealthApi(this._http);

  final MastodonHttpClient _http;

  /// インスタンスの稼働状態を確認する
  ///
  /// `GET /health`
  ///
  /// 認証不要。
  /// ウェブプロセス・データベース・キャッシュの接続が正常であれば `true` を返す。
  /// サーバーが異常応答を返した場合は例外を throw する。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<bool> check() async {
    await _http.send<dynamic>('/health');
    return true;
  }
}
