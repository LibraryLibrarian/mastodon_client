// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonReport {

 String get id; bool get actionTaken; DateTime? get actionTakenAt; String get category; String get comment; bool get forwarded; DateTime? get createdAt; List<String>? get statusIds; List<String>? get ruleIds; MastodonAccount? get targetAccount;
/// Create a copy of MastodonReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonReportCopyWith<MastodonReport> get copyWith => _$MastodonReportCopyWithImpl<MastodonReport>(this as MastodonReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonReport&&(identical(other.id, id) || other.id == id)&&(identical(other.actionTaken, actionTaken) || other.actionTaken == actionTaken)&&(identical(other.actionTakenAt, actionTakenAt) || other.actionTakenAt == actionTakenAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.statusIds, statusIds)&&const DeepCollectionEquality().equals(other.ruleIds, ruleIds)&&(identical(other.targetAccount, targetAccount) || other.targetAccount == targetAccount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,actionTaken,actionTakenAt,category,comment,forwarded,createdAt,const DeepCollectionEquality().hash(statusIds),const DeepCollectionEquality().hash(ruleIds),targetAccount);

@override
String toString() {
  return 'MastodonReport(id: $id, actionTaken: $actionTaken, actionTakenAt: $actionTakenAt, category: $category, comment: $comment, forwarded: $forwarded, createdAt: $createdAt, statusIds: $statusIds, ruleIds: $ruleIds, targetAccount: $targetAccount)';
}


}

/// @nodoc
abstract mixin class $MastodonReportCopyWith<$Res>  {
  factory $MastodonReportCopyWith(MastodonReport value, $Res Function(MastodonReport) _then) = _$MastodonReportCopyWithImpl;
@useResult
$Res call({
 String id, bool actionTaken, DateTime? actionTakenAt, String category, String comment, bool forwarded, DateTime? createdAt, List<String>? statusIds, List<String>? ruleIds, MastodonAccount? targetAccount
});




}
/// @nodoc
class _$MastodonReportCopyWithImpl<$Res>
    implements $MastodonReportCopyWith<$Res> {
  _$MastodonReportCopyWithImpl(this._self, this._then);

  final MastodonReport _self;
  final $Res Function(MastodonReport) _then;

/// Create a copy of MastodonReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? actionTaken = null,Object? actionTakenAt = freezed,Object? category = null,Object? comment = null,Object? forwarded = null,Object? createdAt = freezed,Object? statusIds = freezed,Object? ruleIds = freezed,Object? targetAccount = freezed,}) {
  return _then(MastodonReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,actionTaken: null == actionTaken ? _self.actionTaken : actionTaken // ignore: cast_nullable_to_non_nullable
as bool,actionTakenAt: freezed == actionTakenAt ? _self.actionTakenAt : actionTakenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,statusIds: freezed == statusIds ? _self.statusIds : statusIds // ignore: cast_nullable_to_non_nullable
as List<String>?,ruleIds: freezed == ruleIds ? _self.ruleIds : ruleIds // ignore: cast_nullable_to_non_nullable
as List<String>?,targetAccount: freezed == targetAccount ? _self.targetAccount : targetAccount // ignore: cast_nullable_to_non_nullable
as MastodonAccount?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonReport].
extension MastodonReportPatterns on MastodonReport {
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
