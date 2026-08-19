// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_annual_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAnnualReport {

 int get year; Map<String, dynamic> get data; int get schemaVersion; String? get shareUrl; String get accountId;
/// Create a copy of MastodonAnnualReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAnnualReportCopyWith<MastodonAnnualReport> get copyWith => _$MastodonAnnualReportCopyWithImpl<MastodonAnnualReport>(this as MastodonAnnualReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAnnualReport&&(identical(other.year, year) || other.year == year)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.shareUrl, shareUrl) || other.shareUrl == shareUrl)&&(identical(other.accountId, accountId) || other.accountId == accountId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year,const DeepCollectionEquality().hash(data),schemaVersion,shareUrl,accountId);



}

/// @nodoc
abstract mixin class $MastodonAnnualReportCopyWith<$Res>  {
  factory $MastodonAnnualReportCopyWith(MastodonAnnualReport value, $Res Function(MastodonAnnualReport) _then) = _$MastodonAnnualReportCopyWithImpl;
@useResult
$Res call({
 int year, Map<String, dynamic> data, int schemaVersion, String accountId, String? shareUrl
});




}
/// @nodoc
class _$MastodonAnnualReportCopyWithImpl<$Res>
    implements $MastodonAnnualReportCopyWith<$Res> {
  _$MastodonAnnualReportCopyWithImpl(this._self, this._then);

  final MastodonAnnualReport _self;
  final $Res Function(MastodonAnnualReport) _then;

/// Create a copy of MastodonAnnualReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? data = null,Object? schemaVersion = null,Object? accountId = null,Object? shareUrl = freezed,}) {
  return _then(MastodonAnnualReport(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,shareUrl: freezed == shareUrl ? _self.shareUrl : shareUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAnnualReport].
extension MastodonAnnualReportPatterns on MastodonAnnualReport {
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
mixin _$MastodonAnnualReportsResult {

 List<MastodonAnnualReport> get annualReports; List<MastodonAccount> get accounts; List<MastodonStatus> get statuses;
/// Create a copy of MastodonAnnualReportsResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAnnualReportsResultCopyWith<MastodonAnnualReportsResult> get copyWith => _$MastodonAnnualReportsResultCopyWithImpl<MastodonAnnualReportsResult>(this as MastodonAnnualReportsResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAnnualReportsResult&&const DeepCollectionEquality().equals(other.annualReports, annualReports)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.statuses, statuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(annualReports),const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(statuses));



}

/// @nodoc
abstract mixin class $MastodonAnnualReportsResultCopyWith<$Res>  {
  factory $MastodonAnnualReportsResultCopyWith(MastodonAnnualReportsResult value, $Res Function(MastodonAnnualReportsResult) _then) = _$MastodonAnnualReportsResultCopyWithImpl;
@useResult
$Res call({
 List<MastodonAnnualReport> annualReports, List<MastodonAccount> accounts, List<MastodonStatus> statuses
});




}
/// @nodoc
class _$MastodonAnnualReportsResultCopyWithImpl<$Res>
    implements $MastodonAnnualReportsResultCopyWith<$Res> {
  _$MastodonAnnualReportsResultCopyWithImpl(this._self, this._then);

  final MastodonAnnualReportsResult _self;
  final $Res Function(MastodonAnnualReportsResult) _then;

/// Create a copy of MastodonAnnualReportsResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? annualReports = null,Object? accounts = null,Object? statuses = null,}) {
  return _then(MastodonAnnualReportsResult(
annualReports: null == annualReports ? _self.annualReports : annualReports // ignore: cast_nullable_to_non_nullable
as List<MastodonAnnualReport>,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<MastodonAccount>,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<MastodonStatus>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAnnualReportsResult].
extension MastodonAnnualReportsResultPatterns on MastodonAnnualReportsResult {
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
