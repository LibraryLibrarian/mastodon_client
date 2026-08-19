import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_oauth_token_introspection.freezed.dart';
part 'mastodon_oauth_token_introspection.g.dart';

/// RFC 7662 token introspection response.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonOAuthTokenIntrospection with _$MastodonOAuthTokenIntrospection {
  const MastodonOAuthTokenIntrospection({
    required this.active,
    this.scope,
    this.clientId,
    this.tokenType,
    this.issuedAt,
    this.expiresAt,
  });

  factory MastodonOAuthTokenIntrospection.fromJson(Map<String, dynamic> json) =>
      _$MastodonOAuthTokenIntrospectionFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MastodonOAuthTokenIntrospectionToJson(this);

  @JsonKey(defaultValue: false)
  @override
  final bool active;

  @override
  final String? scope;

  @override
  final String? clientId;

  @override
  final String? tokenType;

  @JsonKey(name: 'iat')
  @override
  final int? issuedAt;

  @JsonKey(name: 'exp')
  @override
  final int? expiresAt;
}
