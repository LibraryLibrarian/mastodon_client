// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_oauth_user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonOAuthUserInfo {

 String get iss; String get sub; String get name; String get preferredUsername; String get profile; String get picture;
/// Create a copy of MastodonOAuthUserInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonOAuthUserInfoCopyWith<MastodonOAuthUserInfo> get copyWith => _$MastodonOAuthUserInfoCopyWithImpl<MastodonOAuthUserInfo>(this as MastodonOAuthUserInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonOAuthUserInfo&&(identical(other.iss, iss) || other.iss == iss)&&(identical(other.sub, sub) || other.sub == sub)&&(identical(other.name, name) || other.name == name)&&(identical(other.preferredUsername, preferredUsername) || other.preferredUsername == preferredUsername)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.picture, picture) || other.picture == picture));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,iss,sub,name,preferredUsername,profile,picture);

@override
String toString() {
  return 'MastodonOAuthUserInfo(iss: $iss, sub: $sub, name: $name, preferredUsername: $preferredUsername, profile: $profile, picture: $picture)';
}


}

/// @nodoc
abstract mixin class $MastodonOAuthUserInfoCopyWith<$Res>  {
  factory $MastodonOAuthUserInfoCopyWith(MastodonOAuthUserInfo value, $Res Function(MastodonOAuthUserInfo) _then) = _$MastodonOAuthUserInfoCopyWithImpl;
@useResult
$Res call({
 String iss, String sub, String name, String preferredUsername, String profile, String picture
});




}
/// @nodoc
class _$MastodonOAuthUserInfoCopyWithImpl<$Res>
    implements $MastodonOAuthUserInfoCopyWith<$Res> {
  _$MastodonOAuthUserInfoCopyWithImpl(this._self, this._then);

  final MastodonOAuthUserInfo _self;
  final $Res Function(MastodonOAuthUserInfo) _then;

/// Create a copy of MastodonOAuthUserInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? iss = null,Object? sub = null,Object? name = null,Object? preferredUsername = null,Object? profile = null,Object? picture = null,}) {
  return _then(MastodonOAuthUserInfo(
iss: null == iss ? _self.iss : iss // ignore: cast_nullable_to_non_nullable
as String,sub: null == sub ? _self.sub : sub // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,preferredUsername: null == preferredUsername ? _self.preferredUsername : preferredUsername // ignore: cast_nullable_to_non_nullable
as String,profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as String,picture: null == picture ? _self.picture : picture // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonOAuthUserInfo].
extension MastodonOAuthUserInfoPatterns on MastodonOAuthUserInfo {
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
