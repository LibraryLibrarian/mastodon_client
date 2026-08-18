// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonSearchResult {

 List<MastodonAccount> get accounts; List<MastodonStatus> get statuses; List<MastodonTag> get hashtags;
/// Create a copy of MastodonSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonSearchResultCopyWith<MastodonSearchResult> get copyWith => _$MastodonSearchResultCopyWithImpl<MastodonSearchResult>(this as MastodonSearchResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonSearchResult&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.statuses, statuses)&&const DeepCollectionEquality().equals(other.hashtags, hashtags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(statuses),const DeepCollectionEquality().hash(hashtags));



}

/// @nodoc
abstract mixin class $MastodonSearchResultCopyWith<$Res>  {
  factory $MastodonSearchResultCopyWith(MastodonSearchResult value, $Res Function(MastodonSearchResult) _then) = _$MastodonSearchResultCopyWithImpl;
@useResult
$Res call({
 List<MastodonAccount> accounts, List<MastodonStatus> statuses, List<MastodonTag> hashtags
});




}
/// @nodoc
class _$MastodonSearchResultCopyWithImpl<$Res>
    implements $MastodonSearchResultCopyWith<$Res> {
  _$MastodonSearchResultCopyWithImpl(this._self, this._then);

  final MastodonSearchResult _self;
  final $Res Function(MastodonSearchResult) _then;

/// Create a copy of MastodonSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accounts = null,Object? statuses = null,Object? hashtags = null,}) {
  return _then(MastodonSearchResult(
accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<MastodonAccount>,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<MastodonStatus>,hashtags: null == hashtags ? _self.hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<MastodonTag>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonSearchResult].
extension MastodonSearchResultPatterns on MastodonSearchResult {
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
mixin _$MastodonSearchResultV1 {

 List<MastodonAccount> get accounts; List<MastodonStatus> get statuses; List<String> get hashtags;
/// Create a copy of MastodonSearchResultV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonSearchResultV1CopyWith<MastodonSearchResultV1> get copyWith => _$MastodonSearchResultV1CopyWithImpl<MastodonSearchResultV1>(this as MastodonSearchResultV1, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonSearchResultV1&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.statuses, statuses)&&const DeepCollectionEquality().equals(other.hashtags, hashtags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(statuses),const DeepCollectionEquality().hash(hashtags));



}

/// @nodoc
abstract mixin class $MastodonSearchResultV1CopyWith<$Res>  {
  factory $MastodonSearchResultV1CopyWith(MastodonSearchResultV1 value, $Res Function(MastodonSearchResultV1) _then) = _$MastodonSearchResultV1CopyWithImpl;
@useResult
$Res call({
 List<MastodonAccount> accounts, List<MastodonStatus> statuses, List<String> hashtags
});




}
/// @nodoc
class _$MastodonSearchResultV1CopyWithImpl<$Res>
    implements $MastodonSearchResultV1CopyWith<$Res> {
  _$MastodonSearchResultV1CopyWithImpl(this._self, this._then);

  final MastodonSearchResultV1 _self;
  final $Res Function(MastodonSearchResultV1) _then;

/// Create a copy of MastodonSearchResultV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accounts = null,Object? statuses = null,Object? hashtags = null,}) {
  return _then(MastodonSearchResultV1(
accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<MastodonAccount>,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<MastodonStatus>,hashtags: null == hashtags ? _self.hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonSearchResultV1].
extension MastodonSearchResultV1Patterns on MastodonSearchResultV1 {
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
