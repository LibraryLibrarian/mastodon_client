/// OAuth アクセストークン
class MastodonToken {
  /// 各フィールドを指定して [MastodonToken] を生成する
  const MastodonToken({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.createdAt,
  });

  /// JSON マップから [MastodonToken] を生成する
  factory MastodonToken.fromJson(Map<String, dynamic> json) {
    return MastodonToken(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      scope: json['scope'] as String,
      createdAt: json['created_at'] as int,
    );
  }

  /// 認可に使用する OAuth トークン文字列
  final String accessToken;

  /// OAuth トークンの種別（Mastodon では `Bearer`）
  final String tokenType;

  /// このトークンに付与されたスコープ（スペース区切り）
  final String scope;

  /// トークンが生成された日時（UNIX タイムスタンプ）
  final int createdAt;
}
