import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_oauth_user_info.freezed.dart';
part 'mastodon_oauth_user_info.g.dart';

/// OAuth userinfo endpoint response model.
///
/// Corresponds to the response from `GET /oauth/userinfo`.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonOAuthUserInfo with _$MastodonOAuthUserInfo {
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
  @override
  final String iss;

  /// URI of the user.
  @override
  final String sub;

  /// Display name of the user.
  @override
  final String name;

  /// Username of the user.
  @override
  final String preferredUsername;

  /// URL of the user's profile.
  @override
  final String profile;

  /// URL of the user's avatar image.
  @override
  final String picture;
}
