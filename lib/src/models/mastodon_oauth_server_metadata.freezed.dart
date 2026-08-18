// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_oauth_server_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonOAuthServerMetadata {

 String get issuer; String get serviceDocumentation; String get authorizationEndpoint; String get tokenEndpoint; String get appRegistrationEndpoint; String get revocationEndpoint; String? get userinfoEndpoint; List<String> get scopesSupported; List<String> get responseTypesSupported; List<String> get responseModesSupported; List<String>? get codeChallengeMethodsSupported; List<String> get grantTypesSupported; List<String> get tokenEndpointAuthMethodsSupported;
/// Create a copy of MastodonOAuthServerMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonOAuthServerMetadataCopyWith<MastodonOAuthServerMetadata> get copyWith => _$MastodonOAuthServerMetadataCopyWithImpl<MastodonOAuthServerMetadata>(this as MastodonOAuthServerMetadata, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonOAuthServerMetadata&&(identical(other.issuer, issuer) || other.issuer == issuer)&&(identical(other.serviceDocumentation, serviceDocumentation) || other.serviceDocumentation == serviceDocumentation)&&(identical(other.authorizationEndpoint, authorizationEndpoint) || other.authorizationEndpoint == authorizationEndpoint)&&(identical(other.tokenEndpoint, tokenEndpoint) || other.tokenEndpoint == tokenEndpoint)&&(identical(other.appRegistrationEndpoint, appRegistrationEndpoint) || other.appRegistrationEndpoint == appRegistrationEndpoint)&&(identical(other.revocationEndpoint, revocationEndpoint) || other.revocationEndpoint == revocationEndpoint)&&(identical(other.userinfoEndpoint, userinfoEndpoint) || other.userinfoEndpoint == userinfoEndpoint)&&const DeepCollectionEquality().equals(other.scopesSupported, scopesSupported)&&const DeepCollectionEquality().equals(other.responseTypesSupported, responseTypesSupported)&&const DeepCollectionEquality().equals(other.responseModesSupported, responseModesSupported)&&const DeepCollectionEquality().equals(other.codeChallengeMethodsSupported, codeChallengeMethodsSupported)&&const DeepCollectionEquality().equals(other.grantTypesSupported, grantTypesSupported)&&const DeepCollectionEquality().equals(other.tokenEndpointAuthMethodsSupported, tokenEndpointAuthMethodsSupported));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,issuer,serviceDocumentation,authorizationEndpoint,tokenEndpoint,appRegistrationEndpoint,revocationEndpoint,userinfoEndpoint,const DeepCollectionEquality().hash(scopesSupported),const DeepCollectionEquality().hash(responseTypesSupported),const DeepCollectionEquality().hash(responseModesSupported),const DeepCollectionEquality().hash(codeChallengeMethodsSupported),const DeepCollectionEquality().hash(grantTypesSupported),const DeepCollectionEquality().hash(tokenEndpointAuthMethodsSupported));

@override
String toString() {
  return 'MastodonOAuthServerMetadata(issuer: $issuer, serviceDocumentation: $serviceDocumentation, authorizationEndpoint: $authorizationEndpoint, tokenEndpoint: $tokenEndpoint, appRegistrationEndpoint: $appRegistrationEndpoint, revocationEndpoint: $revocationEndpoint, userinfoEndpoint: $userinfoEndpoint, scopesSupported: $scopesSupported, responseTypesSupported: $responseTypesSupported, responseModesSupported: $responseModesSupported, codeChallengeMethodsSupported: $codeChallengeMethodsSupported, grantTypesSupported: $grantTypesSupported, tokenEndpointAuthMethodsSupported: $tokenEndpointAuthMethodsSupported)';
}


}

/// @nodoc
abstract mixin class $MastodonOAuthServerMetadataCopyWith<$Res>  {
  factory $MastodonOAuthServerMetadataCopyWith(MastodonOAuthServerMetadata value, $Res Function(MastodonOAuthServerMetadata) _then) = _$MastodonOAuthServerMetadataCopyWithImpl;
@useResult
$Res call({
 String issuer, String serviceDocumentation, String authorizationEndpoint, String tokenEndpoint, String appRegistrationEndpoint, String revocationEndpoint, String? userinfoEndpoint, List<String> scopesSupported, List<String> responseTypesSupported, List<String> responseModesSupported, List<String>? codeChallengeMethodsSupported, List<String> grantTypesSupported, List<String> tokenEndpointAuthMethodsSupported
});




}
/// @nodoc
class _$MastodonOAuthServerMetadataCopyWithImpl<$Res>
    implements $MastodonOAuthServerMetadataCopyWith<$Res> {
  _$MastodonOAuthServerMetadataCopyWithImpl(this._self, this._then);

  final MastodonOAuthServerMetadata _self;
  final $Res Function(MastodonOAuthServerMetadata) _then;

/// Create a copy of MastodonOAuthServerMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? issuer = null,Object? serviceDocumentation = null,Object? authorizationEndpoint = null,Object? tokenEndpoint = null,Object? appRegistrationEndpoint = null,Object? revocationEndpoint = null,Object? userinfoEndpoint = freezed,Object? scopesSupported = null,Object? responseTypesSupported = null,Object? responseModesSupported = null,Object? codeChallengeMethodsSupported = freezed,Object? grantTypesSupported = null,Object? tokenEndpointAuthMethodsSupported = null,}) {
  return _then(MastodonOAuthServerMetadata(
issuer: null == issuer ? _self.issuer : issuer // ignore: cast_nullable_to_non_nullable
as String,serviceDocumentation: null == serviceDocumentation ? _self.serviceDocumentation : serviceDocumentation // ignore: cast_nullable_to_non_nullable
as String,authorizationEndpoint: null == authorizationEndpoint ? _self.authorizationEndpoint : authorizationEndpoint // ignore: cast_nullable_to_non_nullable
as String,tokenEndpoint: null == tokenEndpoint ? _self.tokenEndpoint : tokenEndpoint // ignore: cast_nullable_to_non_nullable
as String,appRegistrationEndpoint: null == appRegistrationEndpoint ? _self.appRegistrationEndpoint : appRegistrationEndpoint // ignore: cast_nullable_to_non_nullable
as String,revocationEndpoint: null == revocationEndpoint ? _self.revocationEndpoint : revocationEndpoint // ignore: cast_nullable_to_non_nullable
as String,userinfoEndpoint: freezed == userinfoEndpoint ? _self.userinfoEndpoint : userinfoEndpoint // ignore: cast_nullable_to_non_nullable
as String?,scopesSupported: null == scopesSupported ? _self.scopesSupported : scopesSupported // ignore: cast_nullable_to_non_nullable
as List<String>,responseTypesSupported: null == responseTypesSupported ? _self.responseTypesSupported : responseTypesSupported // ignore: cast_nullable_to_non_nullable
as List<String>,responseModesSupported: null == responseModesSupported ? _self.responseModesSupported : responseModesSupported // ignore: cast_nullable_to_non_nullable
as List<String>,codeChallengeMethodsSupported: freezed == codeChallengeMethodsSupported ? _self.codeChallengeMethodsSupported : codeChallengeMethodsSupported // ignore: cast_nullable_to_non_nullable
as List<String>?,grantTypesSupported: null == grantTypesSupported ? _self.grantTypesSupported : grantTypesSupported // ignore: cast_nullable_to_non_nullable
as List<String>,tokenEndpointAuthMethodsSupported: null == tokenEndpointAuthMethodsSupported ? _self.tokenEndpointAuthMethodsSupported : tokenEndpointAuthMethodsSupported // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonOAuthServerMetadata].
extension MastodonOAuthServerMetadataPatterns on MastodonOAuthServerMetadata {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
