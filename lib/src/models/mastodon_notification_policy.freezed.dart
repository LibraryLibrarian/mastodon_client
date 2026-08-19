// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_notification_policy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonNotificationPolicySummary {

 int get pendingRequestsCount; int get pendingNotificationsCount;
/// Create a copy of MastodonNotificationPolicySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonNotificationPolicySummaryCopyWith<MastodonNotificationPolicySummary> get copyWith => _$MastodonNotificationPolicySummaryCopyWithImpl<MastodonNotificationPolicySummary>(this as MastodonNotificationPolicySummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonNotificationPolicySummary&&(identical(other.pendingRequestsCount, pendingRequestsCount) || other.pendingRequestsCount == pendingRequestsCount)&&(identical(other.pendingNotificationsCount, pendingNotificationsCount) || other.pendingNotificationsCount == pendingNotificationsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pendingRequestsCount,pendingNotificationsCount);



}

/// @nodoc
abstract mixin class $MastodonNotificationPolicySummaryCopyWith<$Res>  {
  factory $MastodonNotificationPolicySummaryCopyWith(MastodonNotificationPolicySummary value, $Res Function(MastodonNotificationPolicySummary) _then) = _$MastodonNotificationPolicySummaryCopyWithImpl;
@useResult
$Res call({
 int pendingRequestsCount, int pendingNotificationsCount
});




}
/// @nodoc
class _$MastodonNotificationPolicySummaryCopyWithImpl<$Res>
    implements $MastodonNotificationPolicySummaryCopyWith<$Res> {
  _$MastodonNotificationPolicySummaryCopyWithImpl(this._self, this._then);

  final MastodonNotificationPolicySummary _self;
  final $Res Function(MastodonNotificationPolicySummary) _then;

/// Create a copy of MastodonNotificationPolicySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pendingRequestsCount = null,Object? pendingNotificationsCount = null,}) {
  return _then(MastodonNotificationPolicySummary(
pendingRequestsCount: null == pendingRequestsCount ? _self.pendingRequestsCount : pendingRequestsCount // ignore: cast_nullable_to_non_nullable
as int,pendingNotificationsCount: null == pendingNotificationsCount ? _self.pendingNotificationsCount : pendingNotificationsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonNotificationPolicySummary].
extension MastodonNotificationPolicySummaryPatterns on MastodonNotificationPolicySummary {
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
mixin _$MastodonNotificationPolicy {

 NotificationFilterAction get forNotFollowing; NotificationFilterAction get forNotFollowers; NotificationFilterAction get forNewAccounts; NotificationFilterAction get forPrivateMentions; NotificationFilterAction get forLimitedAccounts; MastodonNotificationPolicySummary? get summary;
/// Create a copy of MastodonNotificationPolicy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonNotificationPolicyCopyWith<MastodonNotificationPolicy> get copyWith => _$MastodonNotificationPolicyCopyWithImpl<MastodonNotificationPolicy>(this as MastodonNotificationPolicy, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonNotificationPolicy&&(identical(other.forNotFollowing, forNotFollowing) || other.forNotFollowing == forNotFollowing)&&(identical(other.forNotFollowers, forNotFollowers) || other.forNotFollowers == forNotFollowers)&&(identical(other.forNewAccounts, forNewAccounts) || other.forNewAccounts == forNewAccounts)&&(identical(other.forPrivateMentions, forPrivateMentions) || other.forPrivateMentions == forPrivateMentions)&&(identical(other.forLimitedAccounts, forLimitedAccounts) || other.forLimitedAccounts == forLimitedAccounts)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,forNotFollowing,forNotFollowers,forNewAccounts,forPrivateMentions,forLimitedAccounts,summary);



}

/// @nodoc
abstract mixin class $MastodonNotificationPolicyCopyWith<$Res>  {
  factory $MastodonNotificationPolicyCopyWith(MastodonNotificationPolicy value, $Res Function(MastodonNotificationPolicy) _then) = _$MastodonNotificationPolicyCopyWithImpl;
@useResult
$Res call({
 NotificationFilterAction forNotFollowing, NotificationFilterAction forNotFollowers, NotificationFilterAction forNewAccounts, NotificationFilterAction forPrivateMentions, NotificationFilterAction forLimitedAccounts, MastodonNotificationPolicySummary? summary
});




}
/// @nodoc
class _$MastodonNotificationPolicyCopyWithImpl<$Res>
    implements $MastodonNotificationPolicyCopyWith<$Res> {
  _$MastodonNotificationPolicyCopyWithImpl(this._self, this._then);

  final MastodonNotificationPolicy _self;
  final $Res Function(MastodonNotificationPolicy) _then;

/// Create a copy of MastodonNotificationPolicy
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? forNotFollowing = null,Object? forNotFollowers = null,Object? forNewAccounts = null,Object? forPrivateMentions = null,Object? forLimitedAccounts = null,Object? summary = freezed,}) {
  return _then(MastodonNotificationPolicy(
forNotFollowing: null == forNotFollowing ? _self.forNotFollowing : forNotFollowing // ignore: cast_nullable_to_non_nullable
as NotificationFilterAction,forNotFollowers: null == forNotFollowers ? _self.forNotFollowers : forNotFollowers // ignore: cast_nullable_to_non_nullable
as NotificationFilterAction,forNewAccounts: null == forNewAccounts ? _self.forNewAccounts : forNewAccounts // ignore: cast_nullable_to_non_nullable
as NotificationFilterAction,forPrivateMentions: null == forPrivateMentions ? _self.forPrivateMentions : forPrivateMentions // ignore: cast_nullable_to_non_nullable
as NotificationFilterAction,forLimitedAccounts: null == forLimitedAccounts ? _self.forLimitedAccounts : forLimitedAccounts // ignore: cast_nullable_to_non_nullable
as NotificationFilterAction,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MastodonNotificationPolicySummary?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonNotificationPolicy].
extension MastodonNotificationPolicyPatterns on MastodonNotificationPolicy {
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
mixin _$MastodonNotificationPolicyV1 {

 bool get filterNotFollowing; bool get filterNotFollowers; bool get filterNewAccounts; bool get filterPrivateMentions; bool get filterBots; MastodonNotificationPolicySummary? get summary;
/// Create a copy of MastodonNotificationPolicyV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonNotificationPolicyV1CopyWith<MastodonNotificationPolicyV1> get copyWith => _$MastodonNotificationPolicyV1CopyWithImpl<MastodonNotificationPolicyV1>(this as MastodonNotificationPolicyV1, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonNotificationPolicyV1&&(identical(other.filterNotFollowing, filterNotFollowing) || other.filterNotFollowing == filterNotFollowing)&&(identical(other.filterNotFollowers, filterNotFollowers) || other.filterNotFollowers == filterNotFollowers)&&(identical(other.filterNewAccounts, filterNewAccounts) || other.filterNewAccounts == filterNewAccounts)&&(identical(other.filterPrivateMentions, filterPrivateMentions) || other.filterPrivateMentions == filterPrivateMentions)&&(identical(other.filterBots, filterBots) || other.filterBots == filterBots)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filterNotFollowing,filterNotFollowers,filterNewAccounts,filterPrivateMentions,filterBots,summary);



}

/// @nodoc
abstract mixin class $MastodonNotificationPolicyV1CopyWith<$Res>  {
  factory $MastodonNotificationPolicyV1CopyWith(MastodonNotificationPolicyV1 value, $Res Function(MastodonNotificationPolicyV1) _then) = _$MastodonNotificationPolicyV1CopyWithImpl;
@useResult
$Res call({
 bool filterNotFollowing, bool filterNotFollowers, bool filterNewAccounts, bool filterPrivateMentions, bool filterBots, MastodonNotificationPolicySummary? summary
});




}
/// @nodoc
class _$MastodonNotificationPolicyV1CopyWithImpl<$Res>
    implements $MastodonNotificationPolicyV1CopyWith<$Res> {
  _$MastodonNotificationPolicyV1CopyWithImpl(this._self, this._then);

  final MastodonNotificationPolicyV1 _self;
  final $Res Function(MastodonNotificationPolicyV1) _then;

/// Create a copy of MastodonNotificationPolicyV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filterNotFollowing = null,Object? filterNotFollowers = null,Object? filterNewAccounts = null,Object? filterPrivateMentions = null,Object? filterBots = null,Object? summary = freezed,}) {
  return _then(MastodonNotificationPolicyV1(
filterNotFollowing: null == filterNotFollowing ? _self.filterNotFollowing : filterNotFollowing // ignore: cast_nullable_to_non_nullable
as bool,filterNotFollowers: null == filterNotFollowers ? _self.filterNotFollowers : filterNotFollowers // ignore: cast_nullable_to_non_nullable
as bool,filterNewAccounts: null == filterNewAccounts ? _self.filterNewAccounts : filterNewAccounts // ignore: cast_nullable_to_non_nullable
as bool,filterPrivateMentions: null == filterPrivateMentions ? _self.filterPrivateMentions : filterPrivateMentions // ignore: cast_nullable_to_non_nullable
as bool,filterBots: null == filterBots ? _self.filterBots : filterBots // ignore: cast_nullable_to_non_nullable
as bool,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as MastodonNotificationPolicySummary?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonNotificationPolicyV1].
extension MastodonNotificationPolicyV1Patterns on MastodonNotificationPolicyV1 {
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
