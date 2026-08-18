// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_status_edit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonStatusEdit {

 String get content; String get spoilerText; bool get sensitive; DateTime get createdAt; MastodonAccount get account; List<MastodonMediaAttachment> get mediaAttachments; List<MastodonCustomEmoji> get emojis; MastodonStatusEditPoll? get poll;
/// Create a copy of MastodonStatusEdit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonStatusEditCopyWith<MastodonStatusEdit> get copyWith => _$MastodonStatusEditCopyWithImpl<MastodonStatusEdit>(this as MastodonStatusEdit, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonStatusEdit&&(identical(other.content, content) || other.content == content)&&(identical(other.spoilerText, spoilerText) || other.spoilerText == spoilerText)&&(identical(other.sensitive, sensitive) || other.sensitive == sensitive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.mediaAttachments, mediaAttachments)&&const DeepCollectionEquality().equals(other.emojis, emojis)&&(identical(other.poll, poll) || other.poll == poll));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,spoilerText,sensitive,createdAt,account,const DeepCollectionEquality().hash(mediaAttachments),const DeepCollectionEquality().hash(emojis),poll);



}

/// @nodoc
abstract mixin class $MastodonStatusEditCopyWith<$Res>  {
  factory $MastodonStatusEditCopyWith(MastodonStatusEdit value, $Res Function(MastodonStatusEdit) _then) = _$MastodonStatusEditCopyWithImpl;
@useResult
$Res call({
 String content, String spoilerText, bool sensitive, DateTime createdAt, MastodonAccount account, List<MastodonMediaAttachment> mediaAttachments, List<MastodonCustomEmoji> emojis, MastodonStatusEditPoll? poll
});




}
/// @nodoc
class _$MastodonStatusEditCopyWithImpl<$Res>
    implements $MastodonStatusEditCopyWith<$Res> {
  _$MastodonStatusEditCopyWithImpl(this._self, this._then);

  final MastodonStatusEdit _self;
  final $Res Function(MastodonStatusEdit) _then;

/// Create a copy of MastodonStatusEdit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? spoilerText = null,Object? sensitive = null,Object? createdAt = null,Object? account = null,Object? mediaAttachments = null,Object? emojis = null,Object? poll = freezed,}) {
  return _then(MastodonStatusEdit(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,spoilerText: null == spoilerText ? _self.spoilerText : spoilerText // ignore: cast_nullable_to_non_nullable
as String,sensitive: null == sensitive ? _self.sensitive : sensitive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MastodonAccount,mediaAttachments: null == mediaAttachments ? _self.mediaAttachments : mediaAttachments // ignore: cast_nullable_to_non_nullable
as List<MastodonMediaAttachment>,emojis: null == emojis ? _self.emojis : emojis // ignore: cast_nullable_to_non_nullable
as List<MastodonCustomEmoji>,poll: freezed == poll ? _self.poll : poll // ignore: cast_nullable_to_non_nullable
as MastodonStatusEditPoll?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonStatusEdit].
extension MastodonStatusEditPatterns on MastodonStatusEdit {
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
mixin _$MastodonStatusEditPoll {

 List<MastodonStatusEditPollOption> get options;
/// Create a copy of MastodonStatusEditPoll
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonStatusEditPollCopyWith<MastodonStatusEditPoll> get copyWith => _$MastodonStatusEditPollCopyWithImpl<MastodonStatusEditPoll>(this as MastodonStatusEditPoll, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonStatusEditPoll&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(options));



}

/// @nodoc
abstract mixin class $MastodonStatusEditPollCopyWith<$Res>  {
  factory $MastodonStatusEditPollCopyWith(MastodonStatusEditPoll value, $Res Function(MastodonStatusEditPoll) _then) = _$MastodonStatusEditPollCopyWithImpl;
@useResult
$Res call({
 List<MastodonStatusEditPollOption> options
});




}
/// @nodoc
class _$MastodonStatusEditPollCopyWithImpl<$Res>
    implements $MastodonStatusEditPollCopyWith<$Res> {
  _$MastodonStatusEditPollCopyWithImpl(this._self, this._then);

  final MastodonStatusEditPoll _self;
  final $Res Function(MastodonStatusEditPoll) _then;

/// Create a copy of MastodonStatusEditPoll
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? options = null,}) {
  return _then(MastodonStatusEditPoll(
options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<MastodonStatusEditPollOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonStatusEditPoll].
extension MastodonStatusEditPollPatterns on MastodonStatusEditPoll {
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
mixin _$MastodonStatusEditPollOption {

 String get title;
/// Create a copy of MastodonStatusEditPollOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonStatusEditPollOptionCopyWith<MastodonStatusEditPollOption> get copyWith => _$MastodonStatusEditPollOptionCopyWithImpl<MastodonStatusEditPollOption>(this as MastodonStatusEditPollOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonStatusEditPollOption&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title);



}

/// @nodoc
abstract mixin class $MastodonStatusEditPollOptionCopyWith<$Res>  {
  factory $MastodonStatusEditPollOptionCopyWith(MastodonStatusEditPollOption value, $Res Function(MastodonStatusEditPollOption) _then) = _$MastodonStatusEditPollOptionCopyWithImpl;
@useResult
$Res call({
 String title
});




}
/// @nodoc
class _$MastodonStatusEditPollOptionCopyWithImpl<$Res>
    implements $MastodonStatusEditPollOptionCopyWith<$Res> {
  _$MastodonStatusEditPollOptionCopyWithImpl(this._self, this._then);

  final MastodonStatusEditPollOption _self;
  final $Res Function(MastodonStatusEditPollOption) _then;

/// Create a copy of MastodonStatusEditPollOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,}) {
  return _then(MastodonStatusEditPollOption(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonStatusEditPollOption].
extension MastodonStatusEditPollOptionPatterns on MastodonStatusEditPollOption {
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
