import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_token.freezed.dart';
part 'mastodon_token.g.dart';

/// OAuth access token.
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonToken with _$MastodonToken {
  /// Creates a [MastodonToken] with the given fields.
  const MastodonToken({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.createdAt,
  });

  /// Creates a [MastodonToken] from a JSON map.
  factory MastodonToken.fromJson(Map<String, dynamic> json) =>
      _$MastodonTokenFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTokenToJson(this);

  /// OAuth token string used for authorization.
  @override
  final String accessToken;

  /// Type of the OAuth token (`Bearer` in Mastodon).
  @override
  final String tokenType;

  /// Scopes granted to this token (space-delimited).
  @override
  final String scope;

  /// Timestamp when the token was generated (UNIX timestamp).
  @override
  final int createdAt;
}
