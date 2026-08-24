// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_weekly_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonWeeklyActivity {

 String get week; String get statuses; String get logins; String get registrations;
/// Create a copy of MastodonWeeklyActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonWeeklyActivityCopyWith<MastodonWeeklyActivity> get copyWith => _$MastodonWeeklyActivityCopyWithImpl<MastodonWeeklyActivity>(this as MastodonWeeklyActivity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonWeeklyActivity&&(identical(other.week, week) || other.week == week)&&(identical(other.statuses, statuses) || other.statuses == statuses)&&(identical(other.logins, logins) || other.logins == logins)&&(identical(other.registrations, registrations) || other.registrations == registrations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,week,statuses,logins,registrations);



}

/// @nodoc
abstract mixin class $MastodonWeeklyActivityCopyWith<$Res>  {
  factory $MastodonWeeklyActivityCopyWith(MastodonWeeklyActivity value, $Res Function(MastodonWeeklyActivity) _then) = _$MastodonWeeklyActivityCopyWithImpl;
@useResult
$Res call({
 String week, String statuses, String logins, String registrations
});




}
/// @nodoc
class _$MastodonWeeklyActivityCopyWithImpl<$Res>
    implements $MastodonWeeklyActivityCopyWith<$Res> {
  _$MastodonWeeklyActivityCopyWithImpl(this._self, this._then);

  final MastodonWeeklyActivity _self;
  final $Res Function(MastodonWeeklyActivity) _then;

/// Create a copy of MastodonWeeklyActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? week = null,Object? statuses = null,Object? logins = null,Object? registrations = null,}) {
  return _then(MastodonWeeklyActivity(
week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as String,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as String,logins: null == logins ? _self.logins : logins // ignore: cast_nullable_to_non_nullable
as String,registrations: null == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonWeeklyActivity].
extension MastodonWeeklyActivityPatterns on MastodonWeeklyActivity {
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
