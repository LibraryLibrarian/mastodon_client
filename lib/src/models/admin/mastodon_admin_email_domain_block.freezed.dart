// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_admin_email_domain_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAdminEmailDomainBlock {

 String get id; String get domain; DateTime? get createdAt; List<MastodonAdminEmailDomainBlockHistory> get history;
/// Create a copy of MastodonAdminEmailDomainBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminEmailDomainBlockCopyWith<MastodonAdminEmailDomainBlock> get copyWith => _$MastodonAdminEmailDomainBlockCopyWithImpl<MastodonAdminEmailDomainBlock>(this as MastodonAdminEmailDomainBlock, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminEmailDomainBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.history, history));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,domain,createdAt,const DeepCollectionEquality().hash(history));



}

/// @nodoc
abstract mixin class $MastodonAdminEmailDomainBlockCopyWith<$Res>  {
  factory $MastodonAdminEmailDomainBlockCopyWith(MastodonAdminEmailDomainBlock value, $Res Function(MastodonAdminEmailDomainBlock) _then) = _$MastodonAdminEmailDomainBlockCopyWithImpl;
@useResult
$Res call({
 String id, String domain, DateTime? createdAt, List<MastodonAdminEmailDomainBlockHistory> history
});




}
/// @nodoc
class _$MastodonAdminEmailDomainBlockCopyWithImpl<$Res>
    implements $MastodonAdminEmailDomainBlockCopyWith<$Res> {
  _$MastodonAdminEmailDomainBlockCopyWithImpl(this._self, this._then);

  final MastodonAdminEmailDomainBlock _self;
  final $Res Function(MastodonAdminEmailDomainBlock) _then;

/// Create a copy of MastodonAdminEmailDomainBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? domain = null,Object? createdAt = freezed,Object? history = null,}) {
  return _then(MastodonAdminEmailDomainBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<MastodonAdminEmailDomainBlockHistory>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminEmailDomainBlock].
extension MastodonAdminEmailDomainBlockPatterns on MastodonAdminEmailDomainBlock {
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
mixin _$MastodonAdminEmailDomainBlockHistory {

 String get day; String get accounts; String get uses;
/// Create a copy of MastodonAdminEmailDomainBlockHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminEmailDomainBlockHistoryCopyWith<MastodonAdminEmailDomainBlockHistory> get copyWith => _$MastodonAdminEmailDomainBlockHistoryCopyWithImpl<MastodonAdminEmailDomainBlockHistory>(this as MastodonAdminEmailDomainBlockHistory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminEmailDomainBlockHistory&&(identical(other.day, day) || other.day == day)&&(identical(other.accounts, accounts) || other.accounts == accounts)&&(identical(other.uses, uses) || other.uses == uses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,accounts,uses);



}

/// @nodoc
abstract mixin class $MastodonAdminEmailDomainBlockHistoryCopyWith<$Res>  {
  factory $MastodonAdminEmailDomainBlockHistoryCopyWith(MastodonAdminEmailDomainBlockHistory value, $Res Function(MastodonAdminEmailDomainBlockHistory) _then) = _$MastodonAdminEmailDomainBlockHistoryCopyWithImpl;
@useResult
$Res call({
 String day, String accounts, String uses
});




}
/// @nodoc
class _$MastodonAdminEmailDomainBlockHistoryCopyWithImpl<$Res>
    implements $MastodonAdminEmailDomainBlockHistoryCopyWith<$Res> {
  _$MastodonAdminEmailDomainBlockHistoryCopyWithImpl(this._self, this._then);

  final MastodonAdminEmailDomainBlockHistory _self;
  final $Res Function(MastodonAdminEmailDomainBlockHistory) _then;

/// Create a copy of MastodonAdminEmailDomainBlockHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? accounts = null,Object? uses = null,}) {
  return _then(MastodonAdminEmailDomainBlockHistory(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as String,uses: null == uses ? _self.uses : uses // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminEmailDomainBlockHistory].
extension MastodonAdminEmailDomainBlockHistoryPatterns on MastodonAdminEmailDomainBlockHistory {
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
