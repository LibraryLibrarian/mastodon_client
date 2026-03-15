import 'package:json_annotation/json_annotation.dart';

part 'mastodon_oauth_server_metadata.g.dart';

/// OAuth 認可サーバーメタデータを表すモデル
///
/// `GET /.well-known/oauth-authorization-server` のレスポンスに対応する
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonOAuthServerMetadata {
  /// 各フィールドを指定して [MastodonOAuthServerMetadata] を生成する
  const MastodonOAuthServerMetadata({
    required this.issuer,
    required this.serviceDocumentation,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.appRegistrationEndpoint,
    required this.revocationEndpoint,
    required this.userinfoEndpoint,
    required this.scopesSupported,
    required this.responseTypesSupported,
    required this.responseModesSupported,
    required this.codeChallengeMethodsSupported,
    required this.grantTypesSupported,
    required this.tokenEndpointAuthMethodsSupported,
  });

  /// JSON マップから [MastodonOAuthServerMetadata] を生成する
  factory MastodonOAuthServerMetadata.fromJson(Map<String, dynamic> json) =>
      _$MastodonOAuthServerMetadataFromJson(json);

  /// 認可サーバーの識別子 URL
  final String issuer;

  /// サービスドキュメントの URL
  final String serviceDocumentation;

  /// 認可エンドポイントの URL
  final String authorizationEndpoint;

  /// トークンエンドポイントの URL
  final String tokenEndpoint;

  /// アプリケーション登録エンドポイントの URL
  final String appRegistrationEndpoint;

  /// トークン失効エンドポイントの URL
  final String revocationEndpoint;

  /// ユーザー情報エンドポイントの URL
  final String userinfoEndpoint;

  /// サポートされるスコープの一覧
  final List<String> scopesSupported;

  /// サポートされるレスポンスタイプの一覧
  final List<String> responseTypesSupported;

  /// サポートされるレスポンスモードの一覧
  final List<String> responseModesSupported;

  /// サポートされるコードチャレンジ方式の一覧
  final List<String> codeChallengeMethodsSupported;

  /// サポートされるグラントタイプの一覧
  final List<String> grantTypesSupported;

  /// サポートされるトークンエンドポイント認証方式の一覧
  final List<String> tokenEndpointAuthMethodsSupported;
}
