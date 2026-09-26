// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_scheduled_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonScheduledStatus {

 String get id; DateTime? get scheduledAt; MastodonScheduledStatusParams? get params; List<MastodonMediaAttachment> get mediaAttachments;
/// Create a copy of MastodonScheduledStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonScheduledStatusCopyWith<MastodonScheduledStatus> get copyWith => _$MastodonScheduledStatusCopyWithImpl<MastodonScheduledStatus>(this as MastodonScheduledStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonScheduledStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.params, params) || other.params == params)&&const DeepCollectionEquality().equals(other.mediaAttachments, mediaAttachments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scheduledAt,params,const DeepCollectionEquality().hash(mediaAttachments));



}

/// @nodoc
abstract mixin class $MastodonScheduledStatusCopyWith<$Res>  {
  factory $MastodonScheduledStatusCopyWith(MastodonScheduledStatus value, $Res Function(MastodonScheduledStatus) _then) = _$MastodonScheduledStatusCopyWithImpl;
@useResult
$Res call({
 String id, DateTime? scheduledAt, MastodonScheduledStatusParams? params, List<MastodonMediaAttachment> mediaAttachments
});




}
/// @nodoc
class _$MastodonScheduledStatusCopyWithImpl<$Res>
    implements $MastodonScheduledStatusCopyWith<$Res> {
  _$MastodonScheduledStatusCopyWithImpl(this._self, this._then);

  final MastodonScheduledStatus _self;
  final $Res Function(MastodonScheduledStatus) _then;

/// Create a copy of MastodonScheduledStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? scheduledAt = freezed,Object? params = freezed,Object? mediaAttachments = null,}) {
  return _then(MastodonScheduledStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as MastodonScheduledStatusParams?,mediaAttachments: null == mediaAttachments ? _self.mediaAttachments : mediaAttachments // ignore: cast_nullable_to_non_nullable
as List<MastodonMediaAttachment>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonScheduledStatus].
extension MastodonScheduledStatusPatterns on MastodonScheduledStatus {
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
mixin _$MastodonScheduledStatusParams {

 String get text; MastodonScheduledStatusPoll? get poll; List<String>? get mediaIds; bool? get sensitive; String? get spoilerText; String? get visibility; String? get inReplyToId; String? get language; String? get idempotency; String? get quotedStatusId; String? get quoteApprovalPolicy; String? get applicationId; bool? get withRateLimit; List<String>? get allowedMentions; DateTime? get scheduledAt;
/// Create a copy of MastodonScheduledStatusParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonScheduledStatusParamsCopyWith<MastodonScheduledStatusParams> get copyWith => _$MastodonScheduledStatusParamsCopyWithImpl<MastodonScheduledStatusParams>(this as MastodonScheduledStatusParams, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonScheduledStatusParams&&(identical(other.text, text) || other.text == text)&&(identical(other.poll, poll) || other.poll == poll)&&const DeepCollectionEquality().equals(other.mediaIds, mediaIds)&&(identical(other.sensitive, sensitive) || other.sensitive == sensitive)&&(identical(other.spoilerText, spoilerText) || other.spoilerText == spoilerText)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.inReplyToId, inReplyToId) || other.inReplyToId == inReplyToId)&&(identical(other.language, language) || other.language == language)&&(identical(other.idempotency, idempotency) || other.idempotency == idempotency)&&(identical(other.quotedStatusId, quotedStatusId) || other.quotedStatusId == quotedStatusId)&&(identical(other.quoteApprovalPolicy, quoteApprovalPolicy) || other.quoteApprovalPolicy == quoteApprovalPolicy)&&(identical(other.applicationId, applicationId) || other.applicationId == applicationId)&&(identical(other.withRateLimit, withRateLimit) || other.withRateLimit == withRateLimit)&&const DeepCollectionEquality().equals(other.allowedMentions, allowedMentions)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,poll,const DeepCollectionEquality().hash(mediaIds),sensitive,spoilerText,visibility,inReplyToId,language,idempotency,quotedStatusId,quoteApprovalPolicy,applicationId,withRateLimit,const DeepCollectionEquality().hash(allowedMentions),scheduledAt);



}

/// @nodoc
abstract mixin class $MastodonScheduledStatusParamsCopyWith<$Res>  {
  factory $MastodonScheduledStatusParamsCopyWith(MastodonScheduledStatusParams value, $Res Function(MastodonScheduledStatusParams) _then) = _$MastodonScheduledStatusParamsCopyWithImpl;
@useResult
$Res call({
 String text, MastodonScheduledStatusPoll? poll, List<String>? mediaIds, bool? sensitive, String? spoilerText, String? visibility, String? inReplyToId, String? language, String? idempotency, String? quotedStatusId, String? quoteApprovalPolicy, String? applicationId, bool? withRateLimit, List<String>? allowedMentions, DateTime? scheduledAt
});




}
/// @nodoc
class _$MastodonScheduledStatusParamsCopyWithImpl<$Res>
    implements $MastodonScheduledStatusParamsCopyWith<$Res> {
  _$MastodonScheduledStatusParamsCopyWithImpl(this._self, this._then);

  final MastodonScheduledStatusParams _self;
  final $Res Function(MastodonScheduledStatusParams) _then;

/// Create a copy of MastodonScheduledStatusParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? poll = freezed,Object? mediaIds = freezed,Object? sensitive = freezed,Object? spoilerText = freezed,Object? visibility = freezed,Object? inReplyToId = freezed,Object? language = freezed,Object? idempotency = freezed,Object? quotedStatusId = freezed,Object? quoteApprovalPolicy = freezed,Object? applicationId = freezed,Object? withRateLimit = freezed,Object? allowedMentions = freezed,Object? scheduledAt = freezed,}) {
  return _then(MastodonScheduledStatusParams(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,poll: freezed == poll ? _self.poll : poll // ignore: cast_nullable_to_non_nullable
as MastodonScheduledStatusPoll?,mediaIds: freezed == mediaIds ? _self.mediaIds : mediaIds // ignore: cast_nullable_to_non_nullable
as List<String>?,sensitive: freezed == sensitive ? _self.sensitive : sensitive // ignore: cast_nullable_to_non_nullable
as bool?,spoilerText: freezed == spoilerText ? _self.spoilerText : spoilerText // ignore: cast_nullable_to_non_nullable
as String?,visibility: freezed == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as String?,inReplyToId: freezed == inReplyToId ? _self.inReplyToId : inReplyToId // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,idempotency: freezed == idempotency ? _self.idempotency : idempotency // ignore: cast_nullable_to_non_nullable
as String?,quotedStatusId: freezed == quotedStatusId ? _self.quotedStatusId : quotedStatusId // ignore: cast_nullable_to_non_nullable
as String?,quoteApprovalPolicy: freezed == quoteApprovalPolicy ? _self.quoteApprovalPolicy : quoteApprovalPolicy // ignore: cast_nullable_to_non_nullable
as String?,applicationId: freezed == applicationId ? _self.applicationId : applicationId // ignore: cast_nullable_to_non_nullable
as String?,withRateLimit: freezed == withRateLimit ? _self.withRateLimit : withRateLimit // ignore: cast_nullable_to_non_nullable
as bool?,allowedMentions: freezed == allowedMentions ? _self.allowedMentions : allowedMentions // ignore: cast_nullable_to_non_nullable
as List<String>?,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonScheduledStatusParams].
extension MastodonScheduledStatusParamsPatterns on MastodonScheduledStatusParams {
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
mixin _$MastodonScheduledStatusPoll {

 List<String> get options; int get expiresIn; bool? get multiple; bool? get hideTotals;
/// Create a copy of MastodonScheduledStatusPoll
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonScheduledStatusPollCopyWith<MastodonScheduledStatusPoll> get copyWith => _$MastodonScheduledStatusPollCopyWithImpl<MastodonScheduledStatusPoll>(this as MastodonScheduledStatusPoll, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonScheduledStatusPoll&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.multiple, multiple) || other.multiple == multiple)&&(identical(other.hideTotals, hideTotals) || other.hideTotals == hideTotals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(options),expiresIn,multiple,hideTotals);



}

/// @nodoc
abstract mixin class $MastodonScheduledStatusPollCopyWith<$Res>  {
  factory $MastodonScheduledStatusPollCopyWith(MastodonScheduledStatusPoll value, $Res Function(MastodonScheduledStatusPoll) _then) = _$MastodonScheduledStatusPollCopyWithImpl;
@useResult
$Res call({
 List<String> options, int expiresIn, bool? multiple, bool? hideTotals
});




}
/// @nodoc
class _$MastodonScheduledStatusPollCopyWithImpl<$Res>
    implements $MastodonScheduledStatusPollCopyWith<$Res> {
  _$MastodonScheduledStatusPollCopyWithImpl(this._self, this._then);

  final MastodonScheduledStatusPoll _self;
  final $Res Function(MastodonScheduledStatusPoll) _then;

/// Create a copy of MastodonScheduledStatusPoll
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? options = null,Object? expiresIn = null,Object? multiple = freezed,Object? hideTotals = freezed,}) {
  return _then(MastodonScheduledStatusPoll(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int,multiple: freezed == multiple ? _self.multiple : multiple // ignore: cast_nullable_to_non_nullable
as bool?,hideTotals: freezed == hideTotals ? _self.hideTotals : hideTotals // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonScheduledStatusPoll].
extension MastodonScheduledStatusPollPatterns on MastodonScheduledStatusPoll {
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
