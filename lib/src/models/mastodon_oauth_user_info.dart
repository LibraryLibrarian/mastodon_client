import 'package:json_annotation/json_annotation.dart';

part 'mastodon_oauth_user_info.g.dart';

/// OAuth userinfo エンドポイントのレスポンスを表すモデル
///
/// `GET /oauth/userinfo` のレスポンスに対応する
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonOAuthUserInfo {
  /// 各フィールドを指定して [MastodonOAuthUserInfo] を生成する
  const MastodonOAuthUserInfo({
    required this.iss,
    required this.sub,
    required this.name,
    required this.preferredUsername,
    required this.profile,
    required this.picture,
  });

  /// JSON マップから [MastodonOAuthUserInfo] を生成する
  factory MastodonOAuthUserInfo.fromJson(Map<String, dynamic> json) =>
      _$MastodonOAuthUserInfoFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonOAuthUserInfoToJson(this);

  /// トークンを発行したインスタンスの URL
  final String iss;

  /// ユーザーの URI
  final String sub;

  /// ユーザーの表示名
  final String name;

  /// ユーザー名
  final String preferredUsername;

  /// ユーザーのプロフィール URL
  final String profile;

  /// ユーザーのアバター画像 URL
  final String picture;
}
