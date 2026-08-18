// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_oembed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonOEmbed {

 String get type; String get version; String? get title; String? get authorName; String? get authorUrl; String? get providerName; String? get providerUrl; int get cacheAge; String get html; int get width; int? get height;
/// Create a copy of MastodonOEmbed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonOEmbedCopyWith<MastodonOEmbed> get copyWith => _$MastodonOEmbedCopyWithImpl<MastodonOEmbed>(this as MastodonOEmbed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonOEmbed&&(identical(other.type, type) || other.type == type)&&(identical(other.version, version) || other.version == version)&&(identical(other.title, title) || other.title == title)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorUrl, authorUrl) || other.authorUrl == authorUrl)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.providerUrl, providerUrl) || other.providerUrl == providerUrl)&&(identical(other.cacheAge, cacheAge) || other.cacheAge == cacheAge)&&(identical(other.html, html) || other.html == html)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,version,title,authorName,authorUrl,providerName,providerUrl,cacheAge,html,width,height);



}

/// @nodoc
abstract mixin class $MastodonOEmbedCopyWith<$Res>  {
  factory $MastodonOEmbedCopyWith(MastodonOEmbed value, $Res Function(MastodonOEmbed) _then) = _$MastodonOEmbedCopyWithImpl;
@useResult
$Res call({
 String type, String version, String? title, String? authorName, String? authorUrl, String? providerName, String? providerUrl, int cacheAge, String html, int width, int? height
});




}
/// @nodoc
class _$MastodonOEmbedCopyWithImpl<$Res>
    implements $MastodonOEmbedCopyWith<$Res> {
  _$MastodonOEmbedCopyWithImpl(this._self, this._then);

  final MastodonOEmbed _self;
  final $Res Function(MastodonOEmbed) _then;

/// Create a copy of MastodonOEmbed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? version = null,Object? title = freezed,Object? authorName = freezed,Object? authorUrl = freezed,Object? providerName = freezed,Object? providerUrl = freezed,Object? cacheAge = null,Object? html = null,Object? width = null,Object? height = freezed,}) {
  return _then(MastodonOEmbed(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,authorUrl: freezed == authorUrl ? _self.authorUrl : authorUrl // ignore: cast_nullable_to_non_nullable
as String?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,providerUrl: freezed == providerUrl ? _self.providerUrl : providerUrl // ignore: cast_nullable_to_non_nullable
as String?,cacheAge: null == cacheAge ? _self.cacheAge : cacheAge // ignore: cast_nullable_to_non_nullable
as int,html: null == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonOEmbed].
extension MastodonOEmbedPatterns on MastodonOEmbed {
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
