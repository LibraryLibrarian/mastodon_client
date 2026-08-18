// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_trends_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonTrendsLinkHistory {

 String get day; String get accounts; String get uses;
/// Create a copy of MastodonTrendsLinkHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonTrendsLinkHistoryCopyWith<MastodonTrendsLinkHistory> get copyWith => _$MastodonTrendsLinkHistoryCopyWithImpl<MastodonTrendsLinkHistory>(this as MastodonTrendsLinkHistory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonTrendsLinkHistory&&(identical(other.day, day) || other.day == day)&&(identical(other.accounts, accounts) || other.accounts == accounts)&&(identical(other.uses, uses) || other.uses == uses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,day,accounts,uses);



}

/// @nodoc
abstract mixin class $MastodonTrendsLinkHistoryCopyWith<$Res>  {
  factory $MastodonTrendsLinkHistoryCopyWith(MastodonTrendsLinkHistory value, $Res Function(MastodonTrendsLinkHistory) _then) = _$MastodonTrendsLinkHistoryCopyWithImpl;
@useResult
$Res call({
 String day, String accounts, String uses
});




}
/// @nodoc
class _$MastodonTrendsLinkHistoryCopyWithImpl<$Res>
    implements $MastodonTrendsLinkHistoryCopyWith<$Res> {
  _$MastodonTrendsLinkHistoryCopyWithImpl(this._self, this._then);

  final MastodonTrendsLinkHistory _self;
  final $Res Function(MastodonTrendsLinkHistory) _then;

/// Create a copy of MastodonTrendsLinkHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? accounts = null,Object? uses = null,}) {
  return _then(MastodonTrendsLinkHistory(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as String,uses: null == uses ? _self.uses : uses // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonTrendsLinkHistory].
extension MastodonTrendsLinkHistoryPatterns on MastodonTrendsLinkHistory {
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
mixin _$MastodonTrendsLink {

 String get url; String get title; String get description; MastodonPreviewCardType get type; String get authorName; String get authorUrl; String get providerName; String get providerUrl; String get html; int get width; int get height; String? get image; String get embedUrl; String? get blurhash; List<MastodonPreviewCardAuthor> get authors; List<MastodonTrendsLinkHistory> get history;
/// Create a copy of MastodonTrendsLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonTrendsLinkCopyWith<MastodonTrendsLink> get copyWith => _$MastodonTrendsLinkCopyWithImpl<MastodonTrendsLink>(this as MastodonTrendsLink, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonTrendsLink&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorUrl, authorUrl) || other.authorUrl == authorUrl)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.providerUrl, providerUrl) || other.providerUrl == providerUrl)&&(identical(other.html, html) || other.html == html)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.image, image) || other.image == image)&&(identical(other.embedUrl, embedUrl) || other.embedUrl == embedUrl)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&const DeepCollectionEquality().equals(other.authors, authors)&&const DeepCollectionEquality().equals(other.history, history));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,title,description,type,authorName,authorUrl,providerName,providerUrl,html,width,height,image,embedUrl,blurhash,const DeepCollectionEquality().hash(authors),const DeepCollectionEquality().hash(history));



}

/// @nodoc
abstract mixin class $MastodonTrendsLinkCopyWith<$Res>  {
  factory $MastodonTrendsLinkCopyWith(MastodonTrendsLink value, $Res Function(MastodonTrendsLink) _then) = _$MastodonTrendsLinkCopyWithImpl;
@useResult
$Res call({
 String url, String title, String description, MastodonPreviewCardType type, String authorName, String authorUrl, String providerName, String providerUrl, String html, int width, int height, String embedUrl, List<MastodonPreviewCardAuthor> authors, List<MastodonTrendsLinkHistory> history, String? image, String? blurhash
});




}
/// @nodoc
class _$MastodonTrendsLinkCopyWithImpl<$Res>
    implements $MastodonTrendsLinkCopyWith<$Res> {
  _$MastodonTrendsLinkCopyWithImpl(this._self, this._then);

  final MastodonTrendsLink _self;
  final $Res Function(MastodonTrendsLink) _then;

/// Create a copy of MastodonTrendsLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? title = null,Object? description = null,Object? type = null,Object? authorName = null,Object? authorUrl = null,Object? providerName = null,Object? providerUrl = null,Object? html = null,Object? width = null,Object? height = null,Object? embedUrl = null,Object? authors = null,Object? history = null,Object? image = freezed,Object? blurhash = freezed,}) {
  return _then(MastodonTrendsLink(
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
as List<MastodonPreviewCardAuthor>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<MastodonTrendsLinkHistory>,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonTrendsLink].
extension MastodonTrendsLinkPatterns on MastodonTrendsLink {
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
