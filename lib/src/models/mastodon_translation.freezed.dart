// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_translation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonTranslation {

 String get content; String get spoilerText; String get language; String get detectedSourceLanguage; String get provider; List<MastodonTranslationAttachment> get mediaAttachments; MastodonTranslationPoll? get poll;
/// Create a copy of MastodonTranslation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonTranslationCopyWith<MastodonTranslation> get copyWith => _$MastodonTranslationCopyWithImpl<MastodonTranslation>(this as MastodonTranslation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonTranslation&&(identical(other.content, content) || other.content == content)&&(identical(other.spoilerText, spoilerText) || other.spoilerText == spoilerText)&&(identical(other.language, language) || other.language == language)&&(identical(other.detectedSourceLanguage, detectedSourceLanguage) || other.detectedSourceLanguage == detectedSourceLanguage)&&(identical(other.provider, provider) || other.provider == provider)&&const DeepCollectionEquality().equals(other.mediaAttachments, mediaAttachments)&&(identical(other.poll, poll) || other.poll == poll));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,spoilerText,language,detectedSourceLanguage,provider,const DeepCollectionEquality().hash(mediaAttachments),poll);



}

/// @nodoc
abstract mixin class $MastodonTranslationCopyWith<$Res>  {
  factory $MastodonTranslationCopyWith(MastodonTranslation value, $Res Function(MastodonTranslation) _then) = _$MastodonTranslationCopyWithImpl;
@useResult
$Res call({
 String content, String spoilerText, String language, String detectedSourceLanguage, String provider, List<MastodonTranslationAttachment> mediaAttachments, MastodonTranslationPoll? poll
});




}
/// @nodoc
class _$MastodonTranslationCopyWithImpl<$Res>
    implements $MastodonTranslationCopyWith<$Res> {
  _$MastodonTranslationCopyWithImpl(this._self, this._then);

  final MastodonTranslation _self;
  final $Res Function(MastodonTranslation) _then;

/// Create a copy of MastodonTranslation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? spoilerText = null,Object? language = null,Object? detectedSourceLanguage = null,Object? provider = null,Object? mediaAttachments = null,Object? poll = freezed,}) {
  return _then(MastodonTranslation(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,spoilerText: null == spoilerText ? _self.spoilerText : spoilerText // ignore: cast_nullable_to_non_nullable
as String,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,detectedSourceLanguage: null == detectedSourceLanguage ? _self.detectedSourceLanguage : detectedSourceLanguage // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,mediaAttachments: null == mediaAttachments ? _self.mediaAttachments : mediaAttachments // ignore: cast_nullable_to_non_nullable
as List<MastodonTranslationAttachment>,poll: freezed == poll ? _self.poll : poll // ignore: cast_nullable_to_non_nullable
as MastodonTranslationPoll?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonTranslation].
extension MastodonTranslationPatterns on MastodonTranslation {
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
mixin _$MastodonTranslationAttachment {

 String get id; String get description;
/// Create a copy of MastodonTranslationAttachment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonTranslationAttachmentCopyWith<MastodonTranslationAttachment> get copyWith => _$MastodonTranslationAttachmentCopyWithImpl<MastodonTranslationAttachment>(this as MastodonTranslationAttachment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonTranslationAttachment&&(identical(other.id, id) || other.id == id)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,description);



}

/// @nodoc
abstract mixin class $MastodonTranslationAttachmentCopyWith<$Res>  {
  factory $MastodonTranslationAttachmentCopyWith(MastodonTranslationAttachment value, $Res Function(MastodonTranslationAttachment) _then) = _$MastodonTranslationAttachmentCopyWithImpl;
@useResult
$Res call({
 String id, String description
});




}
/// @nodoc
class _$MastodonTranslationAttachmentCopyWithImpl<$Res>
    implements $MastodonTranslationAttachmentCopyWith<$Res> {
  _$MastodonTranslationAttachmentCopyWithImpl(this._self, this._then);

  final MastodonTranslationAttachment _self;
  final $Res Function(MastodonTranslationAttachment) _then;

/// Create a copy of MastodonTranslationAttachment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? description = null,}) {
  return _then(MastodonTranslationAttachment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonTranslationAttachment].
extension MastodonTranslationAttachmentPatterns on MastodonTranslationAttachment {
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
mixin _$MastodonTranslationPoll {

 String get id; List<MastodonTranslationPollOption> get options;
/// Create a copy of MastodonTranslationPoll
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonTranslationPollCopyWith<MastodonTranslationPoll> get copyWith => _$MastodonTranslationPollCopyWithImpl<MastodonTranslationPoll>(this as MastodonTranslationPoll, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonTranslationPoll&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(options));



}

/// @nodoc
abstract mixin class $MastodonTranslationPollCopyWith<$Res>  {
  factory $MastodonTranslationPollCopyWith(MastodonTranslationPoll value, $Res Function(MastodonTranslationPoll) _then) = _$MastodonTranslationPollCopyWithImpl;
@useResult
$Res call({
 String id, List<MastodonTranslationPollOption> options
});




}
/// @nodoc
class _$MastodonTranslationPollCopyWithImpl<$Res>
    implements $MastodonTranslationPollCopyWith<$Res> {
  _$MastodonTranslationPollCopyWithImpl(this._self, this._then);

  final MastodonTranslationPoll _self;
  final $Res Function(MastodonTranslationPoll) _then;

/// Create a copy of MastodonTranslationPoll
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? options = null,}) {
  return _then(MastodonTranslationPoll(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<MastodonTranslationPollOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonTranslationPoll].
extension MastodonTranslationPollPatterns on MastodonTranslationPoll {
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
mixin _$MastodonTranslationPollOption {

 String get title;
/// Create a copy of MastodonTranslationPollOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonTranslationPollOptionCopyWith<MastodonTranslationPollOption> get copyWith => _$MastodonTranslationPollOptionCopyWithImpl<MastodonTranslationPollOption>(this as MastodonTranslationPollOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonTranslationPollOption&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title);



}

/// @nodoc
abstract mixin class $MastodonTranslationPollOptionCopyWith<$Res>  {
  factory $MastodonTranslationPollOptionCopyWith(MastodonTranslationPollOption value, $Res Function(MastodonTranslationPollOption) _then) = _$MastodonTranslationPollOptionCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class _$MastodonTranslationPollOptionCopyWithImpl<$Res>
    implements $MastodonTranslationPollOptionCopyWith<$Res> {
  _$MastodonTranslationPollOptionCopyWithImpl(this._self, this._then);

  final MastodonTranslationPollOption _self;
  final $Res Function(MastodonTranslationPollOption) _then;

/// Create a copy of MastodonTranslationPollOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,}) {
  return _then(MastodonTranslationPollOption(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonTranslationPollOption].
extension MastodonTranslationPollOptionPatterns on MastodonTranslationPollOption {
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
