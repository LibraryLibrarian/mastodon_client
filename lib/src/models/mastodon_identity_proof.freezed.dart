// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_identity_proof.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonIdentityProof {

 String get provider; String get providerUsername; String get updatedAt; String get proofUrl; String get profileUrl;
/// Create a copy of MastodonIdentityProof
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonIdentityProofCopyWith<MastodonIdentityProof> get copyWith => _$MastodonIdentityProofCopyWithImpl<MastodonIdentityProof>(this as MastodonIdentityProof, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonIdentityProof&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.providerUsername, providerUsername) || other.providerUsername == providerUsername)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.proofUrl, proofUrl) || other.proofUrl == proofUrl)&&(identical(other.profileUrl, profileUrl) || other.profileUrl == profileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,providerUsername,updatedAt,proofUrl,profileUrl);

@override
String toString() {
  return 'MastodonIdentityProof(provider: $provider, providerUsername: $providerUsername, updatedAt: $updatedAt, proofUrl: $proofUrl, profileUrl: $profileUrl)';
}


}

/// @nodoc
abstract mixin class $MastodonIdentityProofCopyWith<$Res>  {
  factory $MastodonIdentityProofCopyWith(MastodonIdentityProof value, $Res Function(MastodonIdentityProof) _then) = _$MastodonIdentityProofCopyWithImpl;
@useResult
$Res call({
 String provider, String providerUsername, String updatedAt, String proofUrl, String profileUrl
});




}
/// @nodoc
class _$MastodonIdentityProofCopyWithImpl<$Res>
    implements $MastodonIdentityProofCopyWith<$Res> {
  _$MastodonIdentityProofCopyWithImpl(this._self, this._then);

  final MastodonIdentityProof _self;
  final $Res Function(MastodonIdentityProof) _then;

/// Create a copy of MastodonIdentityProof
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? providerUsername = null,Object? updatedAt = null,Object? proofUrl = null,Object? profileUrl = null,}) {
  return _then(MastodonIdentityProof(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,providerUsername: null == providerUsername ? _self.providerUsername : providerUsername // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,proofUrl: null == proofUrl ? _self.proofUrl : proofUrl // ignore: cast_nullable_to_non_nullable
as String,profileUrl: null == profileUrl ? _self.profileUrl : profileUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonIdentityProof].
extension MastodonIdentityProofPatterns on MastodonIdentityProof {
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
