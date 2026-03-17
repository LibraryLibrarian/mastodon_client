import '../client/mastodon_http_client.dart';
import '../models/mastodon_application.dart';

/// OAuth アプリケーションの登録・検証に関する API クライアント
class AppsApi {
  /// [MastodonHttpClient] を受け取り、アプリケーション API へのアクセスを提供する
  const AppsApi(this._http);

  final MastodonHttpClient _http;

  /// 新しい OAuth アプリケーションを登録する
  ///
  /// `POST /api/v1/apps`
  ///
  /// - [clientName]: アプリケーション名（必須）
  /// - [redirectUris]: 認可コールバック URI のリスト（必須）。
  ///   OOB フローの場合は `['urn:ietf:wg:oauth:2.0:oob']` を指定する
  /// - [scopes]: スペース区切りのスコープ文字列。省略時は `read`
  /// - [website]: アプリケーションのウェブサイト URL
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonCredentialApplication> create({
    required String clientName,
    required List<String> redirectUris,
    String? scopes,
    String? website,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/apps',
      method: 'POST',
      data: <String, dynamic>{
        'client_name': clientName,
        'redirect_uris': redirectUris,
        'scopes': ?scopes,
        'website': ?website,
      },
    );
    return MastodonCredentialApplication.fromJson(data!);
  }

  /// 現在のアプリケーショントークンの認証情報を検証する
  ///
  /// `GET /api/v1/apps/verify_credentials`
  ///
  /// アプリケーションの情報を返す。トークンが無効な場合は認証エラーとなる。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonApplication> verifyCredentials() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/apps/verify_credentials',
    );
    return MastodonApplication.fromJson(data!);
  }
}
