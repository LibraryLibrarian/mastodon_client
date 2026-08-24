// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_partial_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonPartialAccount {

 String get id; String get acct; String get url; String get avatar; String get avatarStatic; bool get locked; bool get bot;
/// Create a copy of MastodonPartialAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonPartialAccountCopyWith<MastodonPartialAccount> get copyWith => _$MastodonPartialAccountCopyWithImpl<MastodonPartialAccount>(this as MastodonPartialAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonPartialAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.acct, acct) || other.acct == acct)&&(identical(other.url, url) || other.url == url)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.avatarStatic, avatarStatic) || other.avatarStatic == avatarStatic)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.bot, bot) || other.bot == bot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,acct,url,avatar,avatarStatic,locked,bot);



}

/// @nodoc
abstract mixin class $MastodonPartialAccountCopyWith<$Res>  {
  factory $MastodonPartialAccountCopyWith(MastodonPartialAccount value, $Res Function(MastodonPartialAccount) _then) = _$MastodonPartialAccountCopyWithImpl;
@useResult
$Res call({
 String id, String acct, String url, String avatar, String avatarStatic, bool locked, bool bot
});




}
/// @nodoc
class _$MastodonPartialAccountCopyWithImpl<$Res>
    implements $MastodonPartialAccountCopyWith<$Res> {
  _$MastodonPartialAccountCopyWithImpl(this._self, this._then);

  final MastodonPartialAccount _self;
  final $Res Function(MastodonPartialAccount) _then;

/// Create a copy of MastodonPartialAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? acct = null,Object? url = null,Object? avatar = null,Object? avatarStatic = null,Object? locked = null,Object? bot = null,}) {
  return _then(MastodonPartialAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,acct: null == acct ? _self.acct : acct // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,avatarStatic: null == avatarStatic ? _self.avatarStatic : avatarStatic // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,bot: null == bot ? _self.bot : bot // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonPartialAccount].
extension MastodonPartialAccountPatterns on MastodonPartialAccount {
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
