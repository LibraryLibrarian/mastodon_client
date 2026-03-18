import 'package:json_annotation/json_annotation.dart';

part 'mastodon_oauth_user_info.g.dart';

/// OAuth userinfo endpoint response model.
///
/// Corresponds to the response from `GET /oauth/userinfo`.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonOAuthUserInfo {
  /// Creates a [MastodonOAuthUserInfo] with the given fields.
  const MastodonOAuthUserInfo({
    required this.iss,
    required this.sub,
    required this.name,
    required this.preferredUsername,
    required this.profile,
    required this.picture,
  });

  /// Creates a [MastodonOAuthUserInfo] from a JSON map.
  factory MastodonOAuthUserInfo.fromJson(Map<String, dynamic> json) =>
      _$MastodonOAuthUserInfoFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonOAuthUserInfoToJson(this);

  /// URL of the instance that issued the token.
  final String iss;

  /// URI of the user.
  final String sub;

  /// Display name of the user.
  final String name;

  /// Username of the user.
  final String preferredUsername;

  /// URL of the user's profile.
  final String profile;

  /// URL of the user's avatar image.
  final String picture;
}
