import 'package:json_annotation/json_annotation.dart';

part 'mastodon_application.g.dart';

/// OAuth アプリケーション情報を表すモデル
///
/// `GET /api/v1/apps/verify_credentials` のレスポンスに対応する
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonApplication {
  /// 各フィールドを指定して [MastodonApplication] を生成する
  const MastodonApplication({
    required this.id,
    required this.name,
    this.website,
    required this.scopes,
    required this.redirectUris,
    @Deprecated('redirectUris を使用してください') this.redirectUri,
    @Deprecated('Push Streaming API で使用されていた VAPID キー') this.vapidKey,
  });

  /// JSON マップから [MastodonApplication] を生成する
  factory MastodonApplication.fromJson(Map<String, dynamic> json) =>
      _$MastodonApplicationFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonApplicationToJson(this);

  /// アプリケーションのデータベース ID
  final String id;

  /// アプリケーション名
  final String name;

  /// アプリケーションのウェブサイト URL
  final String? website;

  /// アプリケーションに付与されたスコープ
  final List<String> scopes;

  /// 登録済みリダイレクト URI のリスト
  final List<String> redirectUris;

  /// リダイレクト URI（非推奨・後方互換用）
  @Deprecated('redirectUris を使用してください')
  final String? redirectUri;

  /// Web Push API 用の VAPID キー（非推奨）
  @Deprecated('Push Streaming API で使用されていた VAPID キー')
  final String? vapidKey;
}

/// OAuth アプリケーション登録時のレスポンスを表すモデル
///
/// `POST /api/v1/apps` のレスポンスに対応する。
/// [MastodonApplication] のフィールドに加え、クライアント認証情報を含む。
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCredentialApplication {
  /// 各フィールドを指定して [MastodonCredentialApplication] を生成する
  const MastodonCredentialApplication({
    required this.id,
    required this.name,
    this.website,
    required this.scopes,
    required this.redirectUris,
    @Deprecated('redirectUris を使用してください') this.redirectUri,
    required this.clientId,
    required this.clientSecret,
    required this.clientSecretExpiresAt,
  });

  /// JSON マップから [MastodonCredentialApplication] を生成する
  factory MastodonCredentialApplication.fromJson(Map<String, dynamic> json) =>
      _$MastodonCredentialApplicationFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonCredentialApplicationToJson(this);

  /// アプリケーションのデータベース ID
  final String id;

  /// アプリケーション名
  final String name;

  /// アプリケーションのウェブサイト URL
  final String? website;

  /// アプリケーションに付与されたスコープ
  final List<String> scopes;

  /// 登録済みリダイレクト URI のリスト
  final List<String> redirectUris;

  /// リダイレクト URI（非推奨・後方互換用）
  @Deprecated('redirectUris を使用してください')
  final String? redirectUri;

  /// OAuth トークン取得に使用するクライアント ID
  final String clientId;

  /// OAuth トークン取得に使用するクライアントシークレット
  final String clientSecret;

  /// クライアントシークレットの有効期限（現在は常に 0）
  final int clientSecretExpiresAt;
}
