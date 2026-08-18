// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_admin_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAdminReport {

 String get id; bool get actionTaken; DateTime? get actionTakenAt; String get category; String get comment; bool get forwarded; DateTime? get createdAt; DateTime? get updatedAt; MastodonAdminAccount? get account; MastodonAdminAccount? get targetAccount; MastodonAdminAccount? get assignedAccount; MastodonAdminAccount? get actionTakenByAccount; List<MastodonStatus> get statuses; List<MastodonInstanceRule> get rules;
/// Create a copy of MastodonAdminReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminReportCopyWith<MastodonAdminReport> get copyWith => _$MastodonAdminReportCopyWithImpl<MastodonAdminReport>(this as MastodonAdminReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminReport&&(identical(other.id, id) || other.id == id)&&(identical(other.actionTaken, actionTaken) || other.actionTaken == actionTaken)&&(identical(other.actionTakenAt, actionTakenAt) || other.actionTakenAt == actionTakenAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.forwarded, forwarded) || other.forwarded == forwarded)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.account, account) || other.account == account)&&(identical(other.targetAccount, targetAccount) || other.targetAccount == targetAccount)&&(identical(other.assignedAccount, assignedAccount) || other.assignedAccount == assignedAccount)&&(identical(other.actionTakenByAccount, actionTakenByAccount) || other.actionTakenByAccount == actionTakenByAccount)&&const DeepCollectionEquality().equals(other.statuses, statuses)&&const DeepCollectionEquality().equals(other.rules, rules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,actionTaken,actionTakenAt,category,comment,forwarded,createdAt,updatedAt,account,targetAccount,assignedAccount,actionTakenByAccount,const DeepCollectionEquality().hash(statuses),const DeepCollectionEquality().hash(rules));



}

/// @nodoc
abstract mixin class $MastodonAdminReportCopyWith<$Res>  {
  factory $MastodonAdminReportCopyWith(MastodonAdminReport value, $Res Function(MastodonAdminReport) _then) = _$MastodonAdminReportCopyWithImpl;
@useResult
$Res call({
 String id, bool actionTaken, DateTime? actionTakenAt, String category, String comment, bool forwarded, DateTime? createdAt, DateTime? updatedAt, MastodonAdminAccount? account, MastodonAdminAccount? targetAccount, MastodonAdminAccount? assignedAccount, MastodonAdminAccount? actionTakenByAccount, List<MastodonStatus> statuses, List<MastodonInstanceRule> rules
});




}
/// @nodoc
class _$MastodonAdminReportCopyWithImpl<$Res>
    implements $MastodonAdminReportCopyWith<$Res> {
  _$MastodonAdminReportCopyWithImpl(this._self, this._then);

  final MastodonAdminReport _self;
  final $Res Function(MastodonAdminReport) _then;

/// Create a copy of MastodonAdminReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? actionTaken = null,Object? actionTakenAt = freezed,Object? category = null,Object? comment = null,Object? forwarded = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? account = freezed,Object? targetAccount = freezed,Object? assignedAccount = freezed,Object? actionTakenByAccount = freezed,Object? statuses = null,Object? rules = null,}) {
  return _then(MastodonAdminReport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,actionTaken: null == actionTaken ? _self.actionTaken : actionTaken // ignore: cast_nullable_to_non_nullable
as bool,actionTakenAt: freezed == actionTakenAt ? _self.actionTakenAt : actionTakenAt // ignore: cast_nullable_to_non_nullable
as DateTime?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,forwarded: null == forwarded ? _self.forwarded : forwarded // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MastodonAdminAccount?,targetAccount: freezed == targetAccount ? _self.targetAccount : targetAccount // ignore: cast_nullable_to_non_nullable
as MastodonAdminAccount?,assignedAccount: freezed == assignedAccount ? _self.assignedAccount : assignedAccount // ignore: cast_nullable_to_non_nullable
as MastodonAdminAccount?,actionTakenByAccount: freezed == actionTakenByAccount ? _self.actionTakenByAccount : actionTakenByAccount // ignore: cast_nullable_to_non_nullable
as MastodonAdminAccount?,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<MastodonStatus>,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<MastodonInstanceRule>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminReport].
extension MastodonAdminReportPatterns on MastodonAdminReport {
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
