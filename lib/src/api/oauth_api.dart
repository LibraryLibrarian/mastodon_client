import '../client/mastodon_http_client.dart';
import '../models/mastodon_oauth_server_metadata.dart';
import '../models/mastodon_oauth_user_info.dart';
import '../models/mastodon_token.dart';

/// OAuth トークン操作に関する API クライアント
///
/// ブラウザリダイレクトを伴う認可フロー（`GET /oauth/authorize`）は
/// プラットフォーム依存のため本ライブラリのスコープ外とする。
/// 認可コードの取得後に [obtainToken] でアクセストークンを取得する。
class OAuthApi {
  /// [MastodonHttpClient] を受け取り、OAuth API へのアクセスを提供する
  const OAuthApi(this._http);

  final MastodonHttpClient _http;

  /// 認可コードまたはクライアント資格情報を使用してアクセストークンを取得する
  ///
  /// `POST /oauth/token`
  ///
  /// - [grantType]: グラントタイプ（必須）。
  ///   `authorization_code` または `client_credentials`
  /// - [clientId]: アプリケーションのクライアント ID（必須）
  /// - [clientSecret]: アプリケーションのクライアントシークレット（必須）
  /// - [redirectUri]: 認可時に使用したリダイレクト URI（必須）
  /// - [code]: 認可コード。`authorization_code` グラントタイプの場合に必須
  /// - [codeVerifier]: PKCE コード検証値。認可時に `code_challenge` を
  ///   指定した場合に必須
  /// - [scope]: スコープ（`client_credentials` グラントタイプの場合のみ有効）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonToken> obtainToken({
    required String grantType,
    required String clientId,
    required String clientSecret,
    required String redirectUri,
    String? code,
    String? codeVerifier,
    String? scope,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/oauth/token',
      method: 'POST',
      contentType: 'application/x-www-form-urlencoded',
      data: <String, dynamic>{
        'grant_type': grantType,
        'client_id': clientId,
        'client_secret': clientSecret,
        'redirect_uri': redirectUri,
        'code': ?code,
        'code_verifier': ?codeVerifier,
        'scope': ?scope,
      },
    );
    return MastodonToken.fromJson(data!);
  }

  /// アクセストークンを失効させる
  ///
  /// `POST /oauth/revoke`
  ///
  /// - [clientId]: アプリケーションのクライアント ID（必須）
  /// - [clientSecret]: アプリケーションのクライアントシークレット（必須）
  /// - [token]: 失効させるトークン文字列（必須）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> revokeToken({
    required String clientId,
    required String clientSecret,
    required String token,
  }) async {
    await _http.send<dynamic>(
      '/oauth/revoke',
      method: 'POST',
      contentType: 'application/x-www-form-urlencoded',
      data: <String, dynamic>{
        'client_id': clientId,
        'client_secret': clientSecret,
        'token': token,
      },
    );
  }

  /// 認証済みユーザーの OpenID Connect ユーザー情報を取得する
  ///
  /// `GET /oauth/userinfo`
  ///
  /// `profile` スコープを持つユーザートークンが必要。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonOAuthUserInfo> fetchUserInfo() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/oauth/userinfo',
    );
    return MastodonOAuthUserInfo.fromJson(data!);
  }

  /// OAuth 認可サーバーメタデータを取得する
  ///
  /// `GET /.well-known/oauth-authorization-server`
  ///
  /// 認証不要。サーバーがサポートするエンドポイントやスコープの情報を返す。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonOAuthServerMetadata> fetchServerMetadata() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/.well-known/oauth-authorization-server',
    );
    return MastodonOAuthServerMetadata.fromJson(data!);
  }
}
