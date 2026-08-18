// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonPollOption {

 String get title; int? get votesCount;
/// Create a copy of MastodonPollOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonPollOptionCopyWith<MastodonPollOption> get copyWith => _$MastodonPollOptionCopyWithImpl<MastodonPollOption>(this as MastodonPollOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonPollOption&&(identical(other.title, title) || other.title == title)&&(identical(other.votesCount, votesCount) || other.votesCount == votesCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,votesCount);



}

/// @nodoc
abstract mixin class $MastodonPollOptionCopyWith<$Res>  {
  factory $MastodonPollOptionCopyWith(MastodonPollOption value, $Res Function(MastodonPollOption) _then) = _$MastodonPollOptionCopyWithImpl;
@useResult
$Res call({
 String title, int? votesCount
});




}
/// @nodoc
class _$MastodonPollOptionCopyWithImpl<$Res>
    implements $MastodonPollOptionCopyWith<$Res> {
  _$MastodonPollOptionCopyWithImpl(this._self, this._then);

  final MastodonPollOption _self;
  final $Res Function(MastodonPollOption) _then;

/// Create a copy of MastodonPollOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? votesCount = freezed,}) {
  return _then(MastodonPollOption(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,votesCount: freezed == votesCount ? _self.votesCount : votesCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonPollOption].
extension MastodonPollOptionPatterns on MastodonPollOption {
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


/// @nodoc
mixin _$MastodonPoll {

 String get id; DateTime? get expiresAt; bool get expired; bool get multiple; int get votesCount; int? get votersCount; List<MastodonPollOption> get options; List<MastodonCustomEmoji> get emojis; bool? get voted; List<int>? get ownVotes;
/// Create a copy of MastodonPoll
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonPollCopyWith<MastodonPoll> get copyWith => _$MastodonPollCopyWithImpl<MastodonPoll>(this as MastodonPoll, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonPoll&&(identical(other.id, id) || other.id == id)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.expired, expired) || other.expired == expired)&&(identical(other.multiple, multiple) || other.multiple == multiple)&&(identical(other.votesCount, votesCount) || other.votesCount == votesCount)&&(identical(other.votersCount, votersCount) || other.votersCount == votersCount)&&const DeepCollectionEquality().equals(other.options, options)&&const DeepCollectionEquality().equals(other.emojis, emojis)&&(identical(other.voted, voted) || other.voted == voted)&&const DeepCollectionEquality().equals(other.ownVotes, ownVotes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,expiresAt,expired,multiple,votesCount,votersCount,const DeepCollectionEquality().hash(options),const DeepCollectionEquality().hash(emojis),voted,const DeepCollectionEquality().hash(ownVotes));



}

/// @nodoc
abstract mixin class $MastodonPollCopyWith<$Res>  {
  factory $MastodonPollCopyWith(MastodonPoll value, $Res Function(MastodonPoll) _then) = _$MastodonPollCopyWithImpl;
@useResult
$Res call({
 String id, bool expired, bool multiple, int votesCount, List<MastodonPollOption> options, List<MastodonCustomEmoji> emojis, DateTime? expiresAt, int? votersCount, bool? voted, List<int>? ownVotes
});




}
/// @nodoc
class _$MastodonPollCopyWithImpl<$Res>
    implements $MastodonPollCopyWith<$Res> {
  _$MastodonPollCopyWithImpl(this._self, this._then);

  final MastodonPoll _self;
  final $Res Function(MastodonPoll) _then;

/// Create a copy of MastodonPoll
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? expired = null,Object? multiple = null,Object? votesCount = null,Object? options = null,Object? emojis = null,Object? expiresAt = freezed,Object? votersCount = freezed,Object? voted = freezed,Object? ownVotes = freezed,}) {
  return _then(MastodonPoll(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,multiple: null == multiple ? _self.multiple : multiple // ignore: cast_nullable_to_non_nullable
as bool,votesCount: null == votesCount ? _self.votesCount : votesCount // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<MastodonPollOption>,emojis: null == emojis ? _self.emojis : emojis // ignore: cast_nullable_to_non_nullable
as List<MastodonCustomEmoji>,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,votersCount: freezed == votersCount ? _self.votersCount : votersCount // ignore: cast_nullable_to_non_nullable
as int?,voted: freezed == voted ? _self.voted : voted // ignore: cast_nullable_to_non_nullable
as bool?,ownVotes: freezed == ownVotes ? _self.ownVotes : ownVotes // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonPoll].
extension MastodonPollPatterns on MastodonPoll {
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
