// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonNotificationFallback {

 String get title; String get summary; String? get description;
/// Create a copy of MastodonNotificationFallback
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonNotificationFallbackCopyWith<MastodonNotificationFallback> get copyWith => _$MastodonNotificationFallbackCopyWithImpl<MastodonNotificationFallback>(this as MastodonNotificationFallback, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonNotificationFallback&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,summary,description);



}

/// @nodoc
abstract mixin class $MastodonNotificationFallbackCopyWith<$Res>  {
  factory $MastodonNotificationFallbackCopyWith(MastodonNotificationFallback value, $Res Function(MastodonNotificationFallback) _then) = _$MastodonNotificationFallbackCopyWithImpl;
@useResult
$Res call({
 String title, String summary, String? description
});




}
/// @nodoc
class _$MastodonNotificationFallbackCopyWithImpl<$Res>
    implements $MastodonNotificationFallbackCopyWith<$Res> {
  _$MastodonNotificationFallbackCopyWithImpl(this._self, this._then);

  final MastodonNotificationFallback _self;
  final $Res Function(MastodonNotificationFallback) _then;

/// Create a copy of MastodonNotificationFallback
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? summary = null,Object? description = freezed,}) {
  return _then(MastodonNotificationFallback(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonNotificationFallback].
extension MastodonNotificationFallbackPatterns on MastodonNotificationFallback {
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
mixin _$MastodonAnnualReportEvent {

 String get year;
/// Create a copy of MastodonAnnualReportEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAnnualReportEventCopyWith<MastodonAnnualReportEvent> get copyWith => _$MastodonAnnualReportEventCopyWithImpl<MastodonAnnualReportEvent>(this as MastodonAnnualReportEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAnnualReportEvent&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,year);



}

/// @nodoc
abstract mixin class $MastodonAnnualReportEventCopyWith<$Res>  {
  factory $MastodonAnnualReportEventCopyWith(MastodonAnnualReportEvent value, $Res Function(MastodonAnnualReportEvent) _then) = _$MastodonAnnualReportEventCopyWithImpl;
@useResult
$Res call({
 String year
});




}
/// @nodoc
class _$MastodonAnnualReportEventCopyWithImpl<$Res>
    implements $MastodonAnnualReportEventCopyWith<$Res> {
  _$MastodonAnnualReportEventCopyWithImpl(this._self, this._then);

  final MastodonAnnualReportEvent _self;
  final $Res Function(MastodonAnnualReportEvent) _then;

/// Create a copy of MastodonAnnualReportEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,}) {
  return _then(MastodonAnnualReportEvent(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAnnualReportEvent].
extension MastodonAnnualReportEventPatterns on MastodonAnnualReportEvent {
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
mixin _$MastodonRelationshipSeveranceEvent {

 String get id; String get type; bool get purged; String get targetName; int get followersCount; int get followingCount; DateTime? get createdAt;
/// Create a copy of MastodonRelationshipSeveranceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonRelationshipSeveranceEventCopyWith<MastodonRelationshipSeveranceEvent> get copyWith => _$MastodonRelationshipSeveranceEventCopyWithImpl<MastodonRelationshipSeveranceEvent>(this as MastodonRelationshipSeveranceEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonRelationshipSeveranceEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.purged, purged) || other.purged == purged)&&(identical(other.targetName, targetName) || other.targetName == targetName)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,purged,targetName,followersCount,followingCount,createdAt);



}

/// @nodoc
abstract mixin class $MastodonRelationshipSeveranceEventCopyWith<$Res>  {
  factory $MastodonRelationshipSeveranceEventCopyWith(MastodonRelationshipSeveranceEvent value, $Res Function(MastodonRelationshipSeveranceEvent) _then) = _$MastodonRelationshipSeveranceEventCopyWithImpl;
@useResult
$Res call({
 String id, String type, bool purged, String targetName, int followersCount, int followingCount, DateTime? createdAt
});




}
/// @nodoc
class _$MastodonRelationshipSeveranceEventCopyWithImpl<$Res>
    implements $MastodonRelationshipSeveranceEventCopyWith<$Res> {
  _$MastodonRelationshipSeveranceEventCopyWithImpl(this._self, this._then);

  final MastodonRelationshipSeveranceEvent _self;
  final $Res Function(MastodonRelationshipSeveranceEvent) _then;

/// Create a copy of MastodonRelationshipSeveranceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? purged = null,Object? targetName = null,Object? followersCount = null,Object? followingCount = null,Object? createdAt = freezed,}) {
  return _then(MastodonRelationshipSeveranceEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,purged: null == purged ? _self.purged : purged // ignore: cast_nullable_to_non_nullable
as bool,targetName: null == targetName ? _self.targetName : targetName // ignore: cast_nullable_to_non_nullable
as String,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonRelationshipSeveranceEvent].
extension MastodonRelationshipSeveranceEventPatterns on MastodonRelationshipSeveranceEvent {
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
mixin _$MastodonAccountWarning {

 String get id; String get action; String get text; bool get appeal; DateTime? get createdAt;
/// Create a copy of MastodonAccountWarning
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAccountWarningCopyWith<MastodonAccountWarning> get copyWith => _$MastodonAccountWarningCopyWithImpl<MastodonAccountWarning>(this as MastodonAccountWarning, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAccountWarning&&(identical(other.id, id) || other.id == id)&&(identical(other.action, action) || other.action == action)&&(identical(other.text, text) || other.text == text)&&(identical(other.appeal, appeal) || other.appeal == appeal)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,action,text,appeal,createdAt);



}

/// @nodoc
abstract mixin class $MastodonAccountWarningCopyWith<$Res>  {
  factory $MastodonAccountWarningCopyWith(MastodonAccountWarning value, $Res Function(MastodonAccountWarning) _then) = _$MastodonAccountWarningCopyWithImpl;
@useResult
$Res call({
 String id, String action, String text, bool appeal, DateTime? createdAt
});




}
/// @nodoc
class _$MastodonAccountWarningCopyWithImpl<$Res>
    implements $MastodonAccountWarningCopyWith<$Res> {
  _$MastodonAccountWarningCopyWithImpl(this._self, this._then);

  final MastodonAccountWarning _self;
  final $Res Function(MastodonAccountWarning) _then;

/// Create a copy of MastodonAccountWarning
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? action = null,Object? text = null,Object? appeal = null,Object? createdAt = freezed,}) {
  return _then(MastodonAccountWarning(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,appeal: null == appeal ? _self.appeal : appeal // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAccountWarning].
extension MastodonAccountWarningPatterns on MastodonAccountWarning {
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
mixin _$MastodonNotification {

 String get id; MastodonNotificationType get type; DateTime get createdAt; MastodonAccount get account; String? get groupKey; MastodonStatus? get status; MastodonRelationshipSeveranceEvent? get relationshipSeveranceEvent; MastodonAccountWarning? get moderationWarning; MastodonCollection? get collection; MastodonNotificationFallback? get fallback;
/// Create a copy of MastodonNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonNotificationCopyWith<MastodonNotification> get copyWith => _$MastodonNotificationCopyWithImpl<MastodonNotification>(this as MastodonNotification, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.account, account) || other.account == account)&&(identical(other.groupKey, groupKey) || other.groupKey == groupKey)&&(identical(other.status, status) || other.status == status)&&(identical(other.relationshipSeveranceEvent, relationshipSeveranceEvent) || other.relationshipSeveranceEvent == relationshipSeveranceEvent)&&(identical(other.moderationWarning, moderationWarning) || other.moderationWarning == moderationWarning)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.fallback, fallback) || other.fallback == fallback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,createdAt,account,groupKey,status,relationshipSeveranceEvent,moderationWarning,collection,fallback);



}

/// @nodoc
abstract mixin class $MastodonNotificationCopyWith<$Res>  {
  factory $MastodonNotificationCopyWith(MastodonNotification value, $Res Function(MastodonNotification) _then) = _$MastodonNotificationCopyWithImpl;
@useResult
$Res call({
 String id, MastodonNotificationType type, DateTime createdAt, MastodonAccount account, String? groupKey, MastodonStatus? status, MastodonRelationshipSeveranceEvent? relationshipSeveranceEvent, MastodonAccountWarning? moderationWarning, MastodonCollection? collection, MastodonNotificationFallback? fallback
});




}
/// @nodoc
class _$MastodonNotificationCopyWithImpl<$Res>
    implements $MastodonNotificationCopyWith<$Res> {
  _$MastodonNotificationCopyWithImpl(this._self, this._then);

  final MastodonNotification _self;
  final $Res Function(MastodonNotification) _then;

/// Create a copy of MastodonNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? createdAt = null,Object? account = null,Object? groupKey = freezed,Object? status = freezed,Object? relationshipSeveranceEvent = freezed,Object? moderationWarning = freezed,Object? collection = freezed,Object? fallback = freezed,}) {
  return _then(MastodonNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MastodonNotificationType,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MastodonAccount,groupKey: freezed == groupKey ? _self.groupKey : groupKey // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MastodonStatus?,relationshipSeveranceEvent: freezed == relationshipSeveranceEvent ? _self.relationshipSeveranceEvent : relationshipSeveranceEvent // ignore: cast_nullable_to_non_nullable
as MastodonRelationshipSeveranceEvent?,moderationWarning: freezed == moderationWarning ? _self.moderationWarning : moderationWarning // ignore: cast_nullable_to_non_nullable
as MastodonAccountWarning?,collection: freezed == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as MastodonCollection?,fallback: freezed == fallback ? _self.fallback : fallback // ignore: cast_nullable_to_non_nullable
as MastodonNotificationFallback?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonNotification].
extension MastodonNotificationPatterns on MastodonNotification {
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
