// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_custom_emoji.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonCustomEmoji {

 String get shortcode; String get url; String get staticUrl; bool get visibleInPicker; String? get category;
/// Create a copy of MastodonCustomEmoji
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonCustomEmojiCopyWith<MastodonCustomEmoji> get copyWith => _$MastodonCustomEmojiCopyWithImpl<MastodonCustomEmoji>(this as MastodonCustomEmoji, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonCustomEmoji&&(identical(other.shortcode, shortcode) || other.shortcode == shortcode)&&(identical(other.url, url) || other.url == url)&&(identical(other.staticUrl, staticUrl) || other.staticUrl == staticUrl)&&(identical(other.visibleInPicker, visibleInPicker) || other.visibleInPicker == visibleInPicker)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shortcode,url,staticUrl,visibleInPicker,category);

@override
String toString() {
  return 'MastodonCustomEmoji(shortcode: $shortcode, url: $url, staticUrl: $staticUrl, visibleInPicker: $visibleInPicker, category: $category)';
}


}

/// @nodoc
abstract mixin class $MastodonCustomEmojiCopyWith<$Res>  {
  factory $MastodonCustomEmojiCopyWith(MastodonCustomEmoji value, $Res Function(MastodonCustomEmoji) _then) = _$MastodonCustomEmojiCopyWithImpl;
@useResult
$Res call({
 String shortcode, String url, String staticUrl, bool visibleInPicker, String? category
});




}
/// @nodoc
class _$MastodonCustomEmojiCopyWithImpl<$Res>
    implements $MastodonCustomEmojiCopyWith<$Res> {
  _$MastodonCustomEmojiCopyWithImpl(this._self, this._then);

  final MastodonCustomEmoji _self;
  final $Res Function(MastodonCustomEmoji) _then;

/// Create a copy of MastodonCustomEmoji
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shortcode = null,Object? url = null,Object? staticUrl = null,Object? visibleInPicker = null,Object? category = freezed,}) {
  return _then(MastodonCustomEmoji(
shortcode: null == shortcode ? _self.shortcode : shortcode // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,staticUrl: null == staticUrl ? _self.staticUrl : staticUrl // ignore: cast_nullable_to_non_nullable
as String,visibleInPicker: null == visibleInPicker ? _self.visibleInPicker : visibleInPicker // ignore: cast_nullable_to_non_nullable
as bool,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonCustomEmoji].
extension MastodonCustomEmojiPatterns on MastodonCustomEmoji {
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
