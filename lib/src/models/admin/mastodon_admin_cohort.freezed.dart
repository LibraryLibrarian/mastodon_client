// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_admin_cohort.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAdminCohort {

 DateTime? get period; String get frequency; List<MastodonAdminCohortData> get data;
/// Create a copy of MastodonAdminCohort
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminCohortCopyWith<MastodonAdminCohort> get copyWith => _$MastodonAdminCohortCopyWithImpl<MastodonAdminCohort>(this as MastodonAdminCohort, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminCohort&&(identical(other.period, period) || other.period == period)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,frequency,const DeepCollectionEquality().hash(data));



}

/// @nodoc
abstract mixin class $MastodonAdminCohortCopyWith<$Res>  {
  factory $MastodonAdminCohortCopyWith(MastodonAdminCohort value, $Res Function(MastodonAdminCohort) _then) = _$MastodonAdminCohortCopyWithImpl;
@useResult
$Res call({
 DateTime? period, String frequency, List<MastodonAdminCohortData> data
});




}
/// @nodoc
class _$MastodonAdminCohortCopyWithImpl<$Res>
    implements $MastodonAdminCohortCopyWith<$Res> {
  _$MastodonAdminCohortCopyWithImpl(this._self, this._then);

  final MastodonAdminCohort _self;
  final $Res Function(MastodonAdminCohort) _then;

/// Create a copy of MastodonAdminCohort
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = freezed,Object? frequency = null,Object? data = null,}) {
  return _then(MastodonAdminCohort(
period: freezed == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as DateTime?,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<MastodonAdminCohortData>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminCohort].
extension MastodonAdminCohortPatterns on MastodonAdminCohort {
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
mixin _$MastodonAdminCohortData {

 DateTime? get date; double get rate; String get value;
/// Create a copy of MastodonAdminCohortData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminCohortDataCopyWith<MastodonAdminCohortData> get copyWith => _$MastodonAdminCohortDataCopyWithImpl<MastodonAdminCohortData>(this as MastodonAdminCohortData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminCohortData&&(identical(other.date, date) || other.date == date)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,rate,value);



}

/// @nodoc
abstract mixin class $MastodonAdminCohortDataCopyWith<$Res>  {
  factory $MastodonAdminCohortDataCopyWith(MastodonAdminCohortData value, $Res Function(MastodonAdminCohortData) _then) = _$MastodonAdminCohortDataCopyWithImpl;
@useResult
$Res call({
 DateTime? date, double rate, String value
});




}
/// @nodoc
class _$MastodonAdminCohortDataCopyWithImpl<$Res>
    implements $MastodonAdminCohortDataCopyWith<$Res> {
  _$MastodonAdminCohortDataCopyWithImpl(this._self, this._then);

  final MastodonAdminCohortData _self;
  final $Res Function(MastodonAdminCohortData) _then;

/// Create a copy of MastodonAdminCohortData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? rate = null,Object? value = null,}) {
  return _then(MastodonAdminCohortData(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminCohortData].
extension MastodonAdminCohortDataPatterns on MastodonAdminCohortData {
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
