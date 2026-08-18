// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_notification_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonNotificationGroup {

 String get groupKey; int get notificationsCount; MastodonNotificationType get type; String? get mostRecentNotificationId; String? get pageMinId; String? get pageMaxId; DateTime? get latestPageNotificationAt; List<String> get sampleAccountIds; String? get statusId; MastodonReport? get report; MastodonRelationshipSeveranceEvent? get event; MastodonAccountWarning? get moderationWarning;
/// Create a copy of MastodonNotificationGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonNotificationGroupCopyWith<MastodonNotificationGroup> get copyWith => _$MastodonNotificationGroupCopyWithImpl<MastodonNotificationGroup>(this as MastodonNotificationGroup, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonNotificationGroup&&(identical(other.groupKey, groupKey) || other.groupKey == groupKey)&&(identical(other.notificationsCount, notificationsCount) || other.notificationsCount == notificationsCount)&&(identical(other.type, type) || other.type == type)&&(identical(other.mostRecentNotificationId, mostRecentNotificationId) || other.mostRecentNotificationId == mostRecentNotificationId)&&(identical(other.pageMinId, pageMinId) || other.pageMinId == pageMinId)&&(identical(other.pageMaxId, pageMaxId) || other.pageMaxId == pageMaxId)&&(identical(other.latestPageNotificationAt, latestPageNotificationAt) || other.latestPageNotificationAt == latestPageNotificationAt)&&const DeepCollectionEquality().equals(other.sampleAccountIds, sampleAccountIds)&&(identical(other.statusId, statusId) || other.statusId == statusId)&&(identical(other.report, report) || other.report == report)&&(identical(other.event, event) || other.event == event)&&(identical(other.moderationWarning, moderationWarning) || other.moderationWarning == moderationWarning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupKey,notificationsCount,type,mostRecentNotificationId,pageMinId,pageMaxId,latestPageNotificationAt,const DeepCollectionEquality().hash(sampleAccountIds),statusId,report,event,moderationWarning);



}

/// @nodoc
abstract mixin class $MastodonNotificationGroupCopyWith<$Res>  {
  factory $MastodonNotificationGroupCopyWith(MastodonNotificationGroup value, $Res Function(MastodonNotificationGroup) _then) = _$MastodonNotificationGroupCopyWithImpl;
@useResult
$Res call({
 String groupKey, int notificationsCount, MastodonNotificationType type, String? mostRecentNotificationId, String? pageMinId, String? pageMaxId, DateTime? latestPageNotificationAt, List<String> sampleAccountIds, String? statusId, MastodonReport? report, MastodonRelationshipSeveranceEvent? event, MastodonAccountWarning? moderationWarning
});




}
/// @nodoc
class _$MastodonNotificationGroupCopyWithImpl<$Res>
    implements $MastodonNotificationGroupCopyWith<$Res> {
  _$MastodonNotificationGroupCopyWithImpl(this._self, this._then);

  final MastodonNotificationGroup _self;
  final $Res Function(MastodonNotificationGroup) _then;

/// Create a copy of MastodonNotificationGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupKey = null,Object? notificationsCount = null,Object? type = null,Object? mostRecentNotificationId = freezed,Object? pageMinId = freezed,Object? pageMaxId = freezed,Object? latestPageNotificationAt = freezed,Object? sampleAccountIds = null,Object? statusId = freezed,Object? report = freezed,Object? event = freezed,Object? moderationWarning = freezed,}) {
  return _then(MastodonNotificationGroup(
groupKey: null == groupKey ? _self.groupKey : groupKey // ignore: cast_nullable_to_non_nullable
as String,notificationsCount: null == notificationsCount ? _self.notificationsCount : notificationsCount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MastodonNotificationType,mostRecentNotificationId: freezed == mostRecentNotificationId ? _self.mostRecentNotificationId : mostRecentNotificationId // ignore: cast_nullable_to_non_nullable
as String?,pageMinId: freezed == pageMinId ? _self.pageMinId : pageMinId // ignore: cast_nullable_to_non_nullable
as String?,pageMaxId: freezed == pageMaxId ? _self.pageMaxId : pageMaxId // ignore: cast_nullable_to_non_nullable
as String?,latestPageNotificationAt: freezed == latestPageNotificationAt ? _self.latestPageNotificationAt : latestPageNotificationAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sampleAccountIds: null == sampleAccountIds ? _self.sampleAccountIds : sampleAccountIds // ignore: cast_nullable_to_non_nullable
as List<String>,statusId: freezed == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String?,report: freezed == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as MastodonReport?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as MastodonRelationshipSeveranceEvent?,moderationWarning: freezed == moderationWarning ? _self.moderationWarning : moderationWarning // ignore: cast_nullable_to_non_nullable
as MastodonAccountWarning?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonNotificationGroup].
extension MastodonNotificationGroupPatterns on MastodonNotificationGroup {
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
