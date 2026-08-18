// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_admin_measure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAdminMeasure {

 String get key; String? get unit; String get total; String? get humanValue; String? get previousTotal; List<MastodonAdminMeasureData> get data;
/// Create a copy of MastodonAdminMeasure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminMeasureCopyWith<MastodonAdminMeasure> get copyWith => _$MastodonAdminMeasureCopyWithImpl<MastodonAdminMeasure>(this as MastodonAdminMeasure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminMeasure&&(identical(other.key, key) || other.key == key)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.total, total) || other.total == total)&&(identical(other.humanValue, humanValue) || other.humanValue == humanValue)&&(identical(other.previousTotal, previousTotal) || other.previousTotal == previousTotal)&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,unit,total,humanValue,previousTotal,const DeepCollectionEquality().hash(data));



}

/// @nodoc
abstract mixin class $MastodonAdminMeasureCopyWith<$Res>  {
  factory $MastodonAdminMeasureCopyWith(MastodonAdminMeasure value, $Res Function(MastodonAdminMeasure) _then) = _$MastodonAdminMeasureCopyWithImpl;
@useResult
$Res call({
 String key, String? unit, String total, String? humanValue, String? previousTotal, List<MastodonAdminMeasureData> data
});




}
/// @nodoc
class _$MastodonAdminMeasureCopyWithImpl<$Res>
    implements $MastodonAdminMeasureCopyWith<$Res> {
  _$MastodonAdminMeasureCopyWithImpl(this._self, this._then);

  final MastodonAdminMeasure _self;
  final $Res Function(MastodonAdminMeasure) _then;

/// Create a copy of MastodonAdminMeasure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? unit = freezed,Object? total = null,Object? humanValue = freezed,Object? previousTotal = freezed,Object? data = null,}) {
  return _then(MastodonAdminMeasure(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,unit: freezed == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String?,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,humanValue: freezed == humanValue ? _self.humanValue : humanValue // ignore: cast_nullable_to_non_nullable
as String?,previousTotal: freezed == previousTotal ? _self.previousTotal : previousTotal // ignore: cast_nullable_to_non_nullable
as String?,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<MastodonAdminMeasureData>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminMeasure].
extension MastodonAdminMeasurePatterns on MastodonAdminMeasure {
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
mixin _$MastodonAdminMeasureData {

 String get date; String get value;
/// Create a copy of MastodonAdminMeasureData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminMeasureDataCopyWith<MastodonAdminMeasureData> get copyWith => _$MastodonAdminMeasureDataCopyWithImpl<MastodonAdminMeasureData>(this as MastodonAdminMeasureData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminMeasureData&&(identical(other.date, date) || other.date == date)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,value);



}

/// @nodoc
abstract mixin class $MastodonAdminMeasureDataCopyWith<$Res>  {
  factory $MastodonAdminMeasureDataCopyWith(MastodonAdminMeasureData value, $Res Function(MastodonAdminMeasureData) _then) = _$MastodonAdminMeasureDataCopyWithImpl;
@useResult
$Res call({
 String date, String value
});




}
/// @nodoc
class _$MastodonAdminMeasureDataCopyWithImpl<$Res>
    implements $MastodonAdminMeasureDataCopyWith<$Res> {
  _$MastodonAdminMeasureDataCopyWithImpl(this._self, this._then);

  final MastodonAdminMeasureData _self;
  final $Res Function(MastodonAdminMeasureData) _then;

/// Create a copy of MastodonAdminMeasureData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? value = null,}) {
  return _then(MastodonAdminMeasureData(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminMeasureData].
extension MastodonAdminMeasureDataPatterns on MastodonAdminMeasureData {
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
