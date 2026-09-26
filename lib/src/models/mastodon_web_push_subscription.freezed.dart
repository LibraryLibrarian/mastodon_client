// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_web_push_subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonPushAlerts {

 bool get mention; bool get quote; bool get status; bool get reblog; bool get follow; bool get followRequest; bool get favourite; bool get poll; bool get update; bool get severedRelationships; bool get moderationWarning; bool get annualReport; bool get quotedUpdate; bool get addedToCollection; bool get collectionUpdate; bool get adminSignUp; bool get adminReport;
/// Create a copy of MastodonPushAlerts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonPushAlertsCopyWith<MastodonPushAlerts> get copyWith => _$MastodonPushAlertsCopyWithImpl<MastodonPushAlerts>(this as MastodonPushAlerts, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonPushAlerts&&(identical(other.mention, mention) || other.mention == mention)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.status, status) || other.status == status)&&(identical(other.reblog, reblog) || other.reblog == reblog)&&(identical(other.follow, follow) || other.follow == follow)&&(identical(other.followRequest, followRequest) || other.followRequest == followRequest)&&(identical(other.favourite, favourite) || other.favourite == favourite)&&(identical(other.poll, poll) || other.poll == poll)&&(identical(other.update, update) || other.update == update)&&(identical(other.severedRelationships, severedRelationships) || other.severedRelationships == severedRelationships)&&(identical(other.moderationWarning, moderationWarning) || other.moderationWarning == moderationWarning)&&(identical(other.annualReport, annualReport) || other.annualReport == annualReport)&&(identical(other.quotedUpdate, quotedUpdate) || other.quotedUpdate == quotedUpdate)&&(identical(other.addedToCollection, addedToCollection) || other.addedToCollection == addedToCollection)&&(identical(other.collectionUpdate, collectionUpdate) || other.collectionUpdate == collectionUpdate)&&(identical(other.adminSignUp, adminSignUp) || other.adminSignUp == adminSignUp)&&(identical(other.adminReport, adminReport) || other.adminReport == adminReport));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mention,quote,status,reblog,follow,followRequest,favourite,poll,update,severedRelationships,moderationWarning,annualReport,quotedUpdate,addedToCollection,collectionUpdate,adminSignUp,adminReport);



}

/// @nodoc
abstract mixin class $MastodonPushAlertsCopyWith<$Res>  {
  factory $MastodonPushAlertsCopyWith(MastodonPushAlerts value, $Res Function(MastodonPushAlerts) _then) = _$MastodonPushAlertsCopyWithImpl;
@useResult
$Res call({
 bool mention, bool quote, bool status, bool reblog, bool follow, bool followRequest, bool favourite, bool poll, bool update, bool severedRelationships, bool moderationWarning, bool annualReport, bool quotedUpdate, bool addedToCollection, bool collectionUpdate, bool adminSignUp, bool adminReport
});




}
/// @nodoc
class _$MastodonPushAlertsCopyWithImpl<$Res>
    implements $MastodonPushAlertsCopyWith<$Res> {
  _$MastodonPushAlertsCopyWithImpl(this._self, this._then);

  final MastodonPushAlerts _self;
  final $Res Function(MastodonPushAlerts) _then;

/// Create a copy of MastodonPushAlerts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mention = null,Object? quote = null,Object? status = null,Object? reblog = null,Object? follow = null,Object? followRequest = null,Object? favourite = null,Object? poll = null,Object? update = null,Object? severedRelationships = null,Object? moderationWarning = null,Object? annualReport = null,Object? quotedUpdate = null,Object? addedToCollection = null,Object? collectionUpdate = null,Object? adminSignUp = null,Object? adminReport = null,}) {
  return _then(MastodonPushAlerts(
mention: null == mention ? _self.mention : mention // ignore: cast_nullable_to_non_nullable
as bool,quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as bool,reblog: null == reblog ? _self.reblog : reblog // ignore: cast_nullable_to_non_nullable
as bool,follow: null == follow ? _self.follow : follow // ignore: cast_nullable_to_non_nullable
as bool,followRequest: null == followRequest ? _self.followRequest : followRequest // ignore: cast_nullable_to_non_nullable
as bool,favourite: null == favourite ? _self.favourite : favourite // ignore: cast_nullable_to_non_nullable
as bool,poll: null == poll ? _self.poll : poll // ignore: cast_nullable_to_non_nullable
as bool,update: null == update ? _self.update : update // ignore: cast_nullable_to_non_nullable
as bool,severedRelationships: null == severedRelationships ? _self.severedRelationships : severedRelationships // ignore: cast_nullable_to_non_nullable
as bool,moderationWarning: null == moderationWarning ? _self.moderationWarning : moderationWarning // ignore: cast_nullable_to_non_nullable
as bool,annualReport: null == annualReport ? _self.annualReport : annualReport // ignore: cast_nullable_to_non_nullable
as bool,quotedUpdate: null == quotedUpdate ? _self.quotedUpdate : quotedUpdate // ignore: cast_nullable_to_non_nullable
as bool,addedToCollection: null == addedToCollection ? _self.addedToCollection : addedToCollection // ignore: cast_nullable_to_non_nullable
as bool,collectionUpdate: null == collectionUpdate ? _self.collectionUpdate : collectionUpdate // ignore: cast_nullable_to_non_nullable
as bool,adminSignUp: null == adminSignUp ? _self.adminSignUp : adminSignUp // ignore: cast_nullable_to_non_nullable
as bool,adminReport: null == adminReport ? _self.adminReport : adminReport // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonPushAlerts].
extension MastodonPushAlertsPatterns on MastodonPushAlerts {
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
mixin _$MastodonWebPushSubscription {

 String? get id; String get endpoint; String get serverKey; MastodonPushAlerts get alerts; String get policy; bool? get standard;
/// Create a copy of MastodonWebPushSubscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonWebPushSubscriptionCopyWith<MastodonWebPushSubscription> get copyWith => _$MastodonWebPushSubscriptionCopyWithImpl<MastodonWebPushSubscription>(this as MastodonWebPushSubscription, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonWebPushSubscription&&(identical(other.id, id) || other.id == id)&&(identical(other.endpoint, endpoint) || other.endpoint == endpoint)&&(identical(other.serverKey, serverKey) || other.serverKey == serverKey)&&(identical(other.alerts, alerts) || other.alerts == alerts)&&(identical(other.policy, policy) || other.policy == policy)&&(identical(other.standard, standard) || other.standard == standard));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,endpoint,serverKey,alerts,policy,standard);



}

/// @nodoc
abstract mixin class $MastodonWebPushSubscriptionCopyWith<$Res>  {
  factory $MastodonWebPushSubscriptionCopyWith(MastodonWebPushSubscription value, $Res Function(MastodonWebPushSubscription) _then) = _$MastodonWebPushSubscriptionCopyWithImpl;
@useResult
$Res call({
 String? id, String endpoint, String serverKey, MastodonPushAlerts alerts, String policy, bool? standard
});




}
/// @nodoc
class _$MastodonWebPushSubscriptionCopyWithImpl<$Res>
    implements $MastodonWebPushSubscriptionCopyWith<$Res> {
  _$MastodonWebPushSubscriptionCopyWithImpl(this._self, this._then);

  final MastodonWebPushSubscription _self;
  final $Res Function(MastodonWebPushSubscription) _then;

/// Create a copy of MastodonWebPushSubscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? endpoint = null,Object? serverKey = null,Object? alerts = null,Object? policy = null,Object? standard = freezed,}) {
  return _then(MastodonWebPushSubscription(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,endpoint: null == endpoint ? _self.endpoint : endpoint // ignore: cast_nullable_to_non_nullable
as String,serverKey: null == serverKey ? _self.serverKey : serverKey // ignore: cast_nullable_to_non_nullable
as String,alerts: null == alerts ? _self.alerts : alerts // ignore: cast_nullable_to_non_nullable
as MastodonPushAlerts,policy: null == policy ? _self.policy : policy // ignore: cast_nullable_to_non_nullable
as String,standard: freezed == standard ? _self.standard : standard // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonWebPushSubscription].
extension MastodonWebPushSubscriptionPatterns on MastodonWebPushSubscription {
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
