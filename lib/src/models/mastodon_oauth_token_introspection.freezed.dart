// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_oauth_token_introspection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonOAuthTokenIntrospection {

 bool get active; String? get scope; String? get clientId; String? get tokenType; int? get issuedAt; int? get expiresAt;
/// Create a copy of MastodonOAuthTokenIntrospection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonOAuthTokenIntrospectionCopyWith<MastodonOAuthTokenIntrospection> get copyWith => _$MastodonOAuthTokenIntrospectionCopyWithImpl<MastodonOAuthTokenIntrospection>(this as MastodonOAuthTokenIntrospection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonOAuthTokenIntrospection&&(identical(other.active, active) || other.active == active)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.issuedAt, issuedAt) || other.issuedAt == issuedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,active,scope,clientId,tokenType,issuedAt,expiresAt);



}

/// @nodoc
abstract mixin class $MastodonOAuthTokenIntrospectionCopyWith<$Res>  {
  factory $MastodonOAuthTokenIntrospectionCopyWith(MastodonOAuthTokenIntrospection value, $Res Function(MastodonOAuthTokenIntrospection) _then) = _$MastodonOAuthTokenIntrospectionCopyWithImpl;
@useResult
$Res call({
 bool active, String? scope, String? clientId, String? tokenType, int? issuedAt, int? expiresAt
});




}
/// @nodoc
class _$MastodonOAuthTokenIntrospectionCopyWithImpl<$Res>
    implements $MastodonOAuthTokenIntrospectionCopyWith<$Res> {
  _$MastodonOAuthTokenIntrospectionCopyWithImpl(this._self, this._then);

  final MastodonOAuthTokenIntrospection _self;
  final $Res Function(MastodonOAuthTokenIntrospection) _then;

/// Create a copy of MastodonOAuthTokenIntrospection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? active = null,Object? scope = freezed,Object? clientId = freezed,Object? tokenType = freezed,Object? issuedAt = freezed,Object? expiresAt = freezed,}) {
  return _then(MastodonOAuthTokenIntrospection(
active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as bool,scope: freezed == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String?,clientId: freezed == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String?,tokenType: freezed == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String?,issuedAt: freezed == issuedAt ? _self.issuedAt : issuedAt // ignore: cast_nullable_to_non_nullable
as int?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonOAuthTokenIntrospection].
extension MastodonOAuthTokenIntrospectionPatterns on MastodonOAuthTokenIntrospection {
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
