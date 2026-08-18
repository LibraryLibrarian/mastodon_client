// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_announcement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAnnouncementReaction {

 String get name; int get count; bool get me; String? get url; String? get staticUrl;
/// Create a copy of MastodonAnnouncementReaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAnnouncementReactionCopyWith<MastodonAnnouncementReaction> get copyWith => _$MastodonAnnouncementReactionCopyWithImpl<MastodonAnnouncementReaction>(this as MastodonAnnouncementReaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAnnouncementReaction&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count)&&(identical(other.me, me) || other.me == me)&&(identical(other.url, url) || other.url == url)&&(identical(other.staticUrl, staticUrl) || other.staticUrl == staticUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count,me,url,staticUrl);



}

/// @nodoc
abstract mixin class $MastodonAnnouncementReactionCopyWith<$Res>  {
  factory $MastodonAnnouncementReactionCopyWith(MastodonAnnouncementReaction value, $Res Function(MastodonAnnouncementReaction) _then) = _$MastodonAnnouncementReactionCopyWithImpl;
@useResult
$Res call({
 String name, int count, bool me, String? url, String? staticUrl
});




}
/// @nodoc
class _$MastodonAnnouncementReactionCopyWithImpl<$Res>
    implements $MastodonAnnouncementReactionCopyWith<$Res> {
  _$MastodonAnnouncementReactionCopyWithImpl(this._self, this._then);

  final MastodonAnnouncementReaction _self;
  final $Res Function(MastodonAnnouncementReaction) _then;

/// Create a copy of MastodonAnnouncementReaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? count = null,Object? me = null,Object? url = freezed,Object? staticUrl = freezed,}) {
  return _then(MastodonAnnouncementReaction(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,me: null == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as bool,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,staticUrl: freezed == staticUrl ? _self.staticUrl : staticUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAnnouncementReaction].
extension MastodonAnnouncementReactionPatterns on MastodonAnnouncementReaction {
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
mixin _$MastodonAnnouncement {

 String get id; String get content; DateTime? get startsAt; DateTime? get endsAt; bool get allDay; DateTime? get publishedAt; DateTime? get updatedAt; bool get read; List<MastodonCustomEmoji> get emojis; List<MastodonAnnouncementReaction> get reactions; List<MastodonTag> get tags; List<MastodonMention> get mentions; List<MastodonAnnouncementStatus> get statuses;
/// Create a copy of MastodonAnnouncement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAnnouncementCopyWith<MastodonAnnouncement> get copyWith => _$MastodonAnnouncementCopyWithImpl<MastodonAnnouncement>(this as MastodonAnnouncement, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAnnouncement&&(identical(other.id, id) || other.id == id)&&(identical(other.content, content) || other.content == content)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.allDay, allDay) || other.allDay == allDay)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.read, read) || other.read == read)&&const DeepCollectionEquality().equals(other.emojis, emojis)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.mentions, mentions)&&const DeepCollectionEquality().equals(other.statuses, statuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,content,startsAt,endsAt,allDay,publishedAt,updatedAt,read,const DeepCollectionEquality().hash(emojis),const DeepCollectionEquality().hash(reactions),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(mentions),const DeepCollectionEquality().hash(statuses));



}

/// @nodoc
abstract mixin class $MastodonAnnouncementCopyWith<$Res>  {
  factory $MastodonAnnouncementCopyWith(MastodonAnnouncement value, $Res Function(MastodonAnnouncement) _then) = _$MastodonAnnouncementCopyWithImpl;
@useResult
$Res call({
 String id, String content, bool allDay, bool read, List<MastodonCustomEmoji> emojis, List<MastodonAnnouncementReaction> reactions, List<MastodonTag> tags, List<MastodonMention> mentions, List<MastodonAnnouncementStatus> statuses, DateTime? startsAt, DateTime? endsAt, DateTime? publishedAt, DateTime? updatedAt
});




}
/// @nodoc
class _$MastodonAnnouncementCopyWithImpl<$Res>
    implements $MastodonAnnouncementCopyWith<$Res> {
  _$MastodonAnnouncementCopyWithImpl(this._self, this._then);

  final MastodonAnnouncement _self;
  final $Res Function(MastodonAnnouncement) _then;

/// Create a copy of MastodonAnnouncement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? content = null,Object? allDay = null,Object? read = null,Object? emojis = null,Object? reactions = null,Object? tags = null,Object? mentions = null,Object? statuses = null,Object? startsAt = freezed,Object? endsAt = freezed,Object? publishedAt = freezed,Object? updatedAt = freezed,}) {
  return _then(MastodonAnnouncement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,allDay: null == allDay ? _self.allDay : allDay // ignore: cast_nullable_to_non_nullable
as bool,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,emojis: null == emojis ? _self.emojis : emojis // ignore: cast_nullable_to_non_nullable
as List<MastodonCustomEmoji>,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as List<MastodonAnnouncementReaction>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<MastodonTag>,mentions: null == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<MastodonMention>,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<MastodonAnnouncementStatus>,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAnnouncement].
extension MastodonAnnouncementPatterns on MastodonAnnouncement {
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
mixin _$MastodonAnnouncementStatus {

 String get id; String get url;
/// Create a copy of MastodonAnnouncementStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAnnouncementStatusCopyWith<MastodonAnnouncementStatus> get copyWith => _$MastodonAnnouncementStatusCopyWithImpl<MastodonAnnouncementStatus>(this as MastodonAnnouncementStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAnnouncementStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,url);



}

/// @nodoc
abstract mixin class $MastodonAnnouncementStatusCopyWith<$Res>  {
  factory $MastodonAnnouncementStatusCopyWith(MastodonAnnouncementStatus value, $Res Function(MastodonAnnouncementStatus) _then) = _$MastodonAnnouncementStatusCopyWithImpl;
@useResult
$Res call({
 String id, String url
});




}
/// @nodoc
class _$MastodonAnnouncementStatusCopyWithImpl<$Res>
    implements $MastodonAnnouncementStatusCopyWith<$Res> {
  _$MastodonAnnouncementStatusCopyWithImpl(this._self, this._then);

  final MastodonAnnouncementStatus _self;
  final $Res Function(MastodonAnnouncementStatus) _then;

/// Create a copy of MastodonAnnouncementStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = null,}) {
  return _then(MastodonAnnouncementStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAnnouncementStatus].
extension MastodonAnnouncementStatusPatterns on MastodonAnnouncementStatus {
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
