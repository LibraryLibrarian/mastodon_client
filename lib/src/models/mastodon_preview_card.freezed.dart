// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_preview_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonPreviewCard {

 String get url; String get title; String get description; String? get language; MastodonPreviewCardType get type; String get authorName; String get authorUrl; String get providerName; String get providerUrl; String get html; int get width; int get height; String? get image; String get imageDescription; String get embedUrl; String? get blurhash; DateTime? get publishedAt; bool? get missingAttribution; List<MastodonPreviewCardAuthor> get authors;
/// Create a copy of MastodonPreviewCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonPreviewCardCopyWith<MastodonPreviewCard> get copyWith => _$MastodonPreviewCardCopyWithImpl<MastodonPreviewCard>(this as MastodonPreviewCard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonPreviewCard&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.language, language) || other.language == language)&&(identical(other.type, type) || other.type == type)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorUrl, authorUrl) || other.authorUrl == authorUrl)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.providerUrl, providerUrl) || other.providerUrl == providerUrl)&&(identical(other.html, html) || other.html == html)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.image, image) || other.image == image)&&(identical(other.imageDescription, imageDescription) || other.imageDescription == imageDescription)&&(identical(other.embedUrl, embedUrl) || other.embedUrl == embedUrl)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.missingAttribution, missingAttribution) || other.missingAttribution == missingAttribution)&&const DeepCollectionEquality().equals(other.authors, authors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,url,title,description,language,type,authorName,authorUrl,providerName,providerUrl,html,width,height,image,imageDescription,embedUrl,blurhash,publishedAt,missingAttribution,const DeepCollectionEquality().hash(authors)]);



}

/// @nodoc
abstract mixin class $MastodonPreviewCardCopyWith<$Res>  {
  factory $MastodonPreviewCardCopyWith(MastodonPreviewCard value, $Res Function(MastodonPreviewCard) _then) = _$MastodonPreviewCardCopyWithImpl;
@useResult
$Res call({
 String url, String title, String description, MastodonPreviewCardType type, String authorName, String authorUrl, String providerName, String providerUrl, String html, int width, int height, String embedUrl, List<MastodonPreviewCardAuthor> authors, String? language, String? image, String imageDescription, String? blurhash, DateTime? publishedAt, bool? missingAttribution
});




}
/// @nodoc
class _$MastodonPreviewCardCopyWithImpl<$Res>
    implements $MastodonPreviewCardCopyWith<$Res> {
  _$MastodonPreviewCardCopyWithImpl(this._self, this._then);

  final MastodonPreviewCard _self;
  final $Res Function(MastodonPreviewCard) _then;

/// Create a copy of MastodonPreviewCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? title = null,Object? description = null,Object? type = null,Object? authorName = null,Object? authorUrl = null,Object? providerName = null,Object? providerUrl = null,Object? html = null,Object? width = null,Object? height = null,Object? embedUrl = null,Object? authors = null,Object? language = freezed,Object? image = freezed,Object? imageDescription = null,Object? blurhash = freezed,Object? publishedAt = freezed,Object? missingAttribution = freezed,}) {
  return _then(MastodonPreviewCard(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MastodonPreviewCardType,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorUrl: null == authorUrl ? _self.authorUrl : authorUrl // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,providerUrl: null == providerUrl ? _self.providerUrl : providerUrl // ignore: cast_nullable_to_non_nullable
as String,html: null == html ? _self.html : html // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,embedUrl: null == embedUrl ? _self.embedUrl : embedUrl // ignore: cast_nullable_to_non_nullable
as String,authors: null == authors ? _self.authors : authors // ignore: cast_nullable_to_non_nullable
as List<MastodonPreviewCardAuthor>,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,imageDescription: null == imageDescription ? _self.imageDescription : imageDescription // ignore: cast_nullable_to_non_nullable
as String,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,missingAttribution: freezed == missingAttribution ? _self.missingAttribution : missingAttribution // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonPreviewCard].
extension MastodonPreviewCardPatterns on MastodonPreviewCard {
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
mixin _$MastodonPreviewCardAuthor {

 String get name; String? get url; String? get account;
/// Create a copy of MastodonPreviewCardAuthor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonPreviewCardAuthorCopyWith<MastodonPreviewCardAuthor> get copyWith => _$MastodonPreviewCardAuthorCopyWithImpl<MastodonPreviewCardAuthor>(this as MastodonPreviewCardAuthor, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonPreviewCardAuthor&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.account, account) || other.account == account));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url,account);



}

/// @nodoc
abstract mixin class $MastodonPreviewCardAuthorCopyWith<$Res>  {
  factory $MastodonPreviewCardAuthorCopyWith(MastodonPreviewCardAuthor value, $Res Function(MastodonPreviewCardAuthor) _then) = _$MastodonPreviewCardAuthorCopyWithImpl;
@useResult
$Res call({
 String name, String? url, String? account
});




}
/// @nodoc
class _$MastodonPreviewCardAuthorCopyWithImpl<$Res>
    implements $MastodonPreviewCardAuthorCopyWith<$Res> {
  _$MastodonPreviewCardAuthorCopyWithImpl(this._self, this._then);

  final MastodonPreviewCardAuthor _self;
  final $Res Function(MastodonPreviewCardAuthor) _then;

/// Create a copy of MastodonPreviewCardAuthor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = freezed,Object? account = freezed,}) {
  return _then(MastodonPreviewCardAuthor(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonPreviewCardAuthor].
extension MastodonPreviewCardAuthorPatterns on MastodonPreviewCardAuthor {
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
