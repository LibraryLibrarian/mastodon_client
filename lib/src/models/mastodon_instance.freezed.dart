// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_instance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonTimelineLiveFeeds {

 MastodonTimelineAccessLevel get local; MastodonTimelineAccessLevel get remote;
/// Create a copy of MastodonTimelineLiveFeeds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonTimelineLiveFeedsCopyWith<MastodonTimelineLiveFeeds> get copyWith => _$MastodonTimelineLiveFeedsCopyWithImpl<MastodonTimelineLiveFeeds>(this as MastodonTimelineLiveFeeds, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonTimelineLiveFeeds&&(identical(other.local, local) || other.local == local)&&(identical(other.remote, remote) || other.remote == remote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,local,remote);



}

/// @nodoc
abstract mixin class $MastodonTimelineLiveFeedsCopyWith<$Res>  {
  factory $MastodonTimelineLiveFeedsCopyWith(MastodonTimelineLiveFeeds value, $Res Function(MastodonTimelineLiveFeeds) _then) = _$MastodonTimelineLiveFeedsCopyWithImpl;
@useResult
$Res call({
 MastodonTimelineAccessLevel local, MastodonTimelineAccessLevel remote
});




}
/// @nodoc
class _$MastodonTimelineLiveFeedsCopyWithImpl<$Res>
    implements $MastodonTimelineLiveFeedsCopyWith<$Res> {
  _$MastodonTimelineLiveFeedsCopyWithImpl(this._self, this._then);

  final MastodonTimelineLiveFeeds _self;
  final $Res Function(MastodonTimelineLiveFeeds) _then;

/// Create a copy of MastodonTimelineLiveFeeds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? local = null,Object? remote = null,}) {
  return _then(MastodonTimelineLiveFeeds(
local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as MastodonTimelineAccessLevel,remote: null == remote ? _self.remote : remote // ignore: cast_nullable_to_non_nullable
as MastodonTimelineAccessLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonTimelineLiveFeeds].
extension MastodonTimelineLiveFeedsPatterns on MastodonTimelineLiveFeeds {
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
mixin _$MastodonTimelineHashtagFeeds {

 MastodonTimelineAccessLevel get local; MastodonTimelineAccessLevel get remote;
/// Create a copy of MastodonTimelineHashtagFeeds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonTimelineHashtagFeedsCopyWith<MastodonTimelineHashtagFeeds> get copyWith => _$MastodonTimelineHashtagFeedsCopyWithImpl<MastodonTimelineHashtagFeeds>(this as MastodonTimelineHashtagFeeds, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonTimelineHashtagFeeds&&(identical(other.local, local) || other.local == local)&&(identical(other.remote, remote) || other.remote == remote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,local,remote);



}

/// @nodoc
abstract mixin class $MastodonTimelineHashtagFeedsCopyWith<$Res>  {
  factory $MastodonTimelineHashtagFeedsCopyWith(MastodonTimelineHashtagFeeds value, $Res Function(MastodonTimelineHashtagFeeds) _then) = _$MastodonTimelineHashtagFeedsCopyWithImpl;
@useResult
$Res call({
 MastodonTimelineAccessLevel local, MastodonTimelineAccessLevel remote
});




}
/// @nodoc
class _$MastodonTimelineHashtagFeedsCopyWithImpl<$Res>
    implements $MastodonTimelineHashtagFeedsCopyWith<$Res> {
  _$MastodonTimelineHashtagFeedsCopyWithImpl(this._self, this._then);

  final MastodonTimelineHashtagFeeds _self;
  final $Res Function(MastodonTimelineHashtagFeeds) _then;

/// Create a copy of MastodonTimelineHashtagFeeds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? local = null,Object? remote = null,}) {
  return _then(MastodonTimelineHashtagFeeds(
local: null == local ? _self.local : local // ignore: cast_nullable_to_non_nullable
as MastodonTimelineAccessLevel,remote: null == remote ? _self.remote : remote // ignore: cast_nullable_to_non_nullable
as MastodonTimelineAccessLevel,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonTimelineHashtagFeeds].
extension MastodonTimelineHashtagFeedsPatterns on MastodonTimelineHashtagFeeds {
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
mixin _$MastodonTimelinesAccess {

 MastodonTimelineLiveFeeds? get liveFeeds; MastodonTimelineHashtagFeeds? get hashtagFeeds; MastodonTimelineLiveFeeds? get trendingLinkFeeds;
/// Create a copy of MastodonTimelinesAccess
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonTimelinesAccessCopyWith<MastodonTimelinesAccess> get copyWith => _$MastodonTimelinesAccessCopyWithImpl<MastodonTimelinesAccess>(this as MastodonTimelinesAccess, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonTimelinesAccess&&(identical(other.liveFeeds, liveFeeds) || other.liveFeeds == liveFeeds)&&(identical(other.hashtagFeeds, hashtagFeeds) || other.hashtagFeeds == hashtagFeeds)&&(identical(other.trendingLinkFeeds, trendingLinkFeeds) || other.trendingLinkFeeds == trendingLinkFeeds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,liveFeeds,hashtagFeeds,trendingLinkFeeds);



}

/// @nodoc
abstract mixin class $MastodonTimelinesAccessCopyWith<$Res>  {
  factory $MastodonTimelinesAccessCopyWith(MastodonTimelinesAccess value, $Res Function(MastodonTimelinesAccess) _then) = _$MastodonTimelinesAccessCopyWithImpl;
@useResult
$Res call({
 MastodonTimelineLiveFeeds? liveFeeds, MastodonTimelineHashtagFeeds? hashtagFeeds, MastodonTimelineLiveFeeds? trendingLinkFeeds
});




}
/// @nodoc
class _$MastodonTimelinesAccessCopyWithImpl<$Res>
    implements $MastodonTimelinesAccessCopyWith<$Res> {
  _$MastodonTimelinesAccessCopyWithImpl(this._self, this._then);

  final MastodonTimelinesAccess _self;
  final $Res Function(MastodonTimelinesAccess) _then;

/// Create a copy of MastodonTimelinesAccess
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? liveFeeds = freezed,Object? hashtagFeeds = freezed,Object? trendingLinkFeeds = freezed,}) {
  return _then(MastodonTimelinesAccess(
liveFeeds: freezed == liveFeeds ? _self.liveFeeds : liveFeeds // ignore: cast_nullable_to_non_nullable
as MastodonTimelineLiveFeeds?,hashtagFeeds: freezed == hashtagFeeds ? _self.hashtagFeeds : hashtagFeeds // ignore: cast_nullable_to_non_nullable
as MastodonTimelineHashtagFeeds?,trendingLinkFeeds: freezed == trendingLinkFeeds ? _self.trendingLinkFeeds : trendingLinkFeeds // ignore: cast_nullable_to_non_nullable
as MastodonTimelineLiveFeeds?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonTimelinesAccess].
extension MastodonTimelinesAccessPatterns on MastodonTimelinesAccess {
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
mixin _$MastodonInstanceUrls {

 String? get streaming; String? get status; String? get about; String? get privacyPolicy; String? get termsOfService;
/// Create a copy of MastodonInstanceUrls
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceUrlsCopyWith<MastodonInstanceUrls> get copyWith => _$MastodonInstanceUrlsCopyWithImpl<MastodonInstanceUrls>(this as MastodonInstanceUrls, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceUrls&&(identical(other.streaming, streaming) || other.streaming == streaming)&&(identical(other.status, status) || other.status == status)&&(identical(other.about, about) || other.about == about)&&(identical(other.privacyPolicy, privacyPolicy) || other.privacyPolicy == privacyPolicy)&&(identical(other.termsOfService, termsOfService) || other.termsOfService == termsOfService));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streaming,status,about,privacyPolicy,termsOfService);



}

/// @nodoc
abstract mixin class $MastodonInstanceUrlsCopyWith<$Res>  {
  factory $MastodonInstanceUrlsCopyWith(MastodonInstanceUrls value, $Res Function(MastodonInstanceUrls) _then) = _$MastodonInstanceUrlsCopyWithImpl;
@useResult
$Res call({
 String? streaming, String? status, String? about, String? privacyPolicy, String? termsOfService
});




}
/// @nodoc
class _$MastodonInstanceUrlsCopyWithImpl<$Res>
    implements $MastodonInstanceUrlsCopyWith<$Res> {
  _$MastodonInstanceUrlsCopyWithImpl(this._self, this._then);

  final MastodonInstanceUrls _self;
  final $Res Function(MastodonInstanceUrls) _then;

/// Create a copy of MastodonInstanceUrls
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streaming = freezed,Object? status = freezed,Object? about = freezed,Object? privacyPolicy = freezed,Object? termsOfService = freezed,}) {
  return _then(MastodonInstanceUrls(
streaming: freezed == streaming ? _self.streaming : streaming // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,about: freezed == about ? _self.about : about // ignore: cast_nullable_to_non_nullable
as String?,privacyPolicy: freezed == privacyPolicy ? _self.privacyPolicy : privacyPolicy // ignore: cast_nullable_to_non_nullable
as String?,termsOfService: freezed == termsOfService ? _self.termsOfService : termsOfService // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceUrls].
extension MastodonInstanceUrlsPatterns on MastodonInstanceUrls {
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
mixin _$MastodonStatusesConfiguration {

 int get maxCharacters; int get maxMediaAttachments; int get charactersReservedPerUrl;
/// Create a copy of MastodonStatusesConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonStatusesConfigurationCopyWith<MastodonStatusesConfiguration> get copyWith => _$MastodonStatusesConfigurationCopyWithImpl<MastodonStatusesConfiguration>(this as MastodonStatusesConfiguration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonStatusesConfiguration&&(identical(other.maxCharacters, maxCharacters) || other.maxCharacters == maxCharacters)&&(identical(other.maxMediaAttachments, maxMediaAttachments) || other.maxMediaAttachments == maxMediaAttachments)&&(identical(other.charactersReservedPerUrl, charactersReservedPerUrl) || other.charactersReservedPerUrl == charactersReservedPerUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxCharacters,maxMediaAttachments,charactersReservedPerUrl);



}

/// @nodoc
abstract mixin class $MastodonStatusesConfigurationCopyWith<$Res>  {
  factory $MastodonStatusesConfigurationCopyWith(MastodonStatusesConfiguration value, $Res Function(MastodonStatusesConfiguration) _then) = _$MastodonStatusesConfigurationCopyWithImpl;
@useResult
$Res call({
 int maxCharacters, int maxMediaAttachments, int charactersReservedPerUrl
});




}
/// @nodoc
class _$MastodonStatusesConfigurationCopyWithImpl<$Res>
    implements $MastodonStatusesConfigurationCopyWith<$Res> {
  _$MastodonStatusesConfigurationCopyWithImpl(this._self, this._then);

  final MastodonStatusesConfiguration _self;
  final $Res Function(MastodonStatusesConfiguration) _then;

/// Create a copy of MastodonStatusesConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxCharacters = null,Object? maxMediaAttachments = null,Object? charactersReservedPerUrl = null,}) {
  return _then(MastodonStatusesConfiguration(
maxCharacters: null == maxCharacters ? _self.maxCharacters : maxCharacters // ignore: cast_nullable_to_non_nullable
as int,maxMediaAttachments: null == maxMediaAttachments ? _self.maxMediaAttachments : maxMediaAttachments // ignore: cast_nullable_to_non_nullable
as int,charactersReservedPerUrl: null == charactersReservedPerUrl ? _self.charactersReservedPerUrl : charactersReservedPerUrl // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonStatusesConfiguration].
extension MastodonStatusesConfigurationPatterns on MastodonStatusesConfiguration {
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
mixin _$MastodonMediaConfiguration {

 List<String> get supportedMimeTypes; int? get descriptionLimit; int? get imageSizeLimit; int? get imageMatrixLimit; int? get videoSizeLimit; int? get videoFrameRateLimit; int? get videoMatrixLimit;
/// Create a copy of MastodonMediaConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonMediaConfigurationCopyWith<MastodonMediaConfiguration> get copyWith => _$MastodonMediaConfigurationCopyWithImpl<MastodonMediaConfiguration>(this as MastodonMediaConfiguration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonMediaConfiguration&&const DeepCollectionEquality().equals(other.supportedMimeTypes, supportedMimeTypes)&&(identical(other.descriptionLimit, descriptionLimit) || other.descriptionLimit == descriptionLimit)&&(identical(other.imageSizeLimit, imageSizeLimit) || other.imageSizeLimit == imageSizeLimit)&&(identical(other.imageMatrixLimit, imageMatrixLimit) || other.imageMatrixLimit == imageMatrixLimit)&&(identical(other.videoSizeLimit, videoSizeLimit) || other.videoSizeLimit == videoSizeLimit)&&(identical(other.videoFrameRateLimit, videoFrameRateLimit) || other.videoFrameRateLimit == videoFrameRateLimit)&&(identical(other.videoMatrixLimit, videoMatrixLimit) || other.videoMatrixLimit == videoMatrixLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(supportedMimeTypes),descriptionLimit,imageSizeLimit,imageMatrixLimit,videoSizeLimit,videoFrameRateLimit,videoMatrixLimit);



}

/// @nodoc
abstract mixin class $MastodonMediaConfigurationCopyWith<$Res>  {
  factory $MastodonMediaConfigurationCopyWith(MastodonMediaConfiguration value, $Res Function(MastodonMediaConfiguration) _then) = _$MastodonMediaConfigurationCopyWithImpl;
@useResult
$Res call({
 List<String> supportedMimeTypes, int? descriptionLimit, int? imageSizeLimit, int? imageMatrixLimit, int? videoSizeLimit, int? videoFrameRateLimit, int? videoMatrixLimit
});




}
/// @nodoc
class _$MastodonMediaConfigurationCopyWithImpl<$Res>
    implements $MastodonMediaConfigurationCopyWith<$Res> {
  _$MastodonMediaConfigurationCopyWithImpl(this._self, this._then);

  final MastodonMediaConfiguration _self;
  final $Res Function(MastodonMediaConfiguration) _then;

/// Create a copy of MastodonMediaConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? supportedMimeTypes = null,Object? descriptionLimit = freezed,Object? imageSizeLimit = freezed,Object? imageMatrixLimit = freezed,Object? videoSizeLimit = freezed,Object? videoFrameRateLimit = freezed,Object? videoMatrixLimit = freezed,}) {
  return _then(MastodonMediaConfiguration(
supportedMimeTypes: null == supportedMimeTypes ? _self.supportedMimeTypes : supportedMimeTypes // ignore: cast_nullable_to_non_nullable
as List<String>,descriptionLimit: freezed == descriptionLimit ? _self.descriptionLimit : descriptionLimit // ignore: cast_nullable_to_non_nullable
as int?,imageSizeLimit: freezed == imageSizeLimit ? _self.imageSizeLimit : imageSizeLimit // ignore: cast_nullable_to_non_nullable
as int?,imageMatrixLimit: freezed == imageMatrixLimit ? _self.imageMatrixLimit : imageMatrixLimit // ignore: cast_nullable_to_non_nullable
as int?,videoSizeLimit: freezed == videoSizeLimit ? _self.videoSizeLimit : videoSizeLimit // ignore: cast_nullable_to_non_nullable
as int?,videoFrameRateLimit: freezed == videoFrameRateLimit ? _self.videoFrameRateLimit : videoFrameRateLimit // ignore: cast_nullable_to_non_nullable
as int?,videoMatrixLimit: freezed == videoMatrixLimit ? _self.videoMatrixLimit : videoMatrixLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonMediaConfiguration].
extension MastodonMediaConfigurationPatterns on MastodonMediaConfiguration {
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
mixin _$MastodonPollsConfiguration {

 int get maxOptions; int get maxCharactersPerOption; int get minExpiration; int get maxExpiration;
/// Create a copy of MastodonPollsConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonPollsConfigurationCopyWith<MastodonPollsConfiguration> get copyWith => _$MastodonPollsConfigurationCopyWithImpl<MastodonPollsConfiguration>(this as MastodonPollsConfiguration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonPollsConfiguration&&(identical(other.maxOptions, maxOptions) || other.maxOptions == maxOptions)&&(identical(other.maxCharactersPerOption, maxCharactersPerOption) || other.maxCharactersPerOption == maxCharactersPerOption)&&(identical(other.minExpiration, minExpiration) || other.minExpiration == minExpiration)&&(identical(other.maxExpiration, maxExpiration) || other.maxExpiration == maxExpiration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxOptions,maxCharactersPerOption,minExpiration,maxExpiration);



}

/// @nodoc
abstract mixin class $MastodonPollsConfigurationCopyWith<$Res>  {
  factory $MastodonPollsConfigurationCopyWith(MastodonPollsConfiguration value, $Res Function(MastodonPollsConfiguration) _then) = _$MastodonPollsConfigurationCopyWithImpl;
@useResult
$Res call({
 int maxOptions, int maxCharactersPerOption, int minExpiration, int maxExpiration
});




}
/// @nodoc
class _$MastodonPollsConfigurationCopyWithImpl<$Res>
    implements $MastodonPollsConfigurationCopyWith<$Res> {
  _$MastodonPollsConfigurationCopyWithImpl(this._self, this._then);

  final MastodonPollsConfiguration _self;
  final $Res Function(MastodonPollsConfiguration) _then;

/// Create a copy of MastodonPollsConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxOptions = null,Object? maxCharactersPerOption = null,Object? minExpiration = null,Object? maxExpiration = null,}) {
  return _then(MastodonPollsConfiguration(
maxOptions: null == maxOptions ? _self.maxOptions : maxOptions // ignore: cast_nullable_to_non_nullable
as int,maxCharactersPerOption: null == maxCharactersPerOption ? _self.maxCharactersPerOption : maxCharactersPerOption // ignore: cast_nullable_to_non_nullable
as int,minExpiration: null == minExpiration ? _self.minExpiration : minExpiration // ignore: cast_nullable_to_non_nullable
as int,maxExpiration: null == maxExpiration ? _self.maxExpiration : maxExpiration // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonPollsConfiguration].
extension MastodonPollsConfigurationPatterns on MastodonPollsConfiguration {
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
mixin _$MastodonAccountsConfiguration {

 int get maxDisplayNameLength; int get maxNoteLength; int get maxAvatarDescriptionLength; int get maxHeaderDescriptionLength; int get maxFeaturedTags; int get maxPinnedStatuses; int get maxProfileFields; int get profileFieldNameLimit; int get profileFieldValueLimit;
/// Create a copy of MastodonAccountsConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAccountsConfigurationCopyWith<MastodonAccountsConfiguration> get copyWith => _$MastodonAccountsConfigurationCopyWithImpl<MastodonAccountsConfiguration>(this as MastodonAccountsConfiguration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAccountsConfiguration&&(identical(other.maxDisplayNameLength, maxDisplayNameLength) || other.maxDisplayNameLength == maxDisplayNameLength)&&(identical(other.maxNoteLength, maxNoteLength) || other.maxNoteLength == maxNoteLength)&&(identical(other.maxAvatarDescriptionLength, maxAvatarDescriptionLength) || other.maxAvatarDescriptionLength == maxAvatarDescriptionLength)&&(identical(other.maxHeaderDescriptionLength, maxHeaderDescriptionLength) || other.maxHeaderDescriptionLength == maxHeaderDescriptionLength)&&(identical(other.maxFeaturedTags, maxFeaturedTags) || other.maxFeaturedTags == maxFeaturedTags)&&(identical(other.maxPinnedStatuses, maxPinnedStatuses) || other.maxPinnedStatuses == maxPinnedStatuses)&&(identical(other.maxProfileFields, maxProfileFields) || other.maxProfileFields == maxProfileFields)&&(identical(other.profileFieldNameLimit, profileFieldNameLimit) || other.profileFieldNameLimit == profileFieldNameLimit)&&(identical(other.profileFieldValueLimit, profileFieldValueLimit) || other.profileFieldValueLimit == profileFieldValueLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxDisplayNameLength,maxNoteLength,maxAvatarDescriptionLength,maxHeaderDescriptionLength,maxFeaturedTags,maxPinnedStatuses,maxProfileFields,profileFieldNameLimit,profileFieldValueLimit);



}

/// @nodoc
abstract mixin class $MastodonAccountsConfigurationCopyWith<$Res>  {
  factory $MastodonAccountsConfigurationCopyWith(MastodonAccountsConfiguration value, $Res Function(MastodonAccountsConfiguration) _then) = _$MastodonAccountsConfigurationCopyWithImpl;
@useResult
$Res call({
 int maxDisplayNameLength, int maxNoteLength, int maxAvatarDescriptionLength, int maxHeaderDescriptionLength, int maxFeaturedTags, int maxPinnedStatuses, int maxProfileFields, int profileFieldNameLimit, int profileFieldValueLimit
});




}
/// @nodoc
class _$MastodonAccountsConfigurationCopyWithImpl<$Res>
    implements $MastodonAccountsConfigurationCopyWith<$Res> {
  _$MastodonAccountsConfigurationCopyWithImpl(this._self, this._then);

  final MastodonAccountsConfiguration _self;
  final $Res Function(MastodonAccountsConfiguration) _then;

/// Create a copy of MastodonAccountsConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxDisplayNameLength = null,Object? maxNoteLength = null,Object? maxAvatarDescriptionLength = null,Object? maxHeaderDescriptionLength = null,Object? maxFeaturedTags = null,Object? maxPinnedStatuses = null,Object? maxProfileFields = null,Object? profileFieldNameLimit = null,Object? profileFieldValueLimit = null,}) {
  return _then(MastodonAccountsConfiguration(
maxDisplayNameLength: null == maxDisplayNameLength ? _self.maxDisplayNameLength : maxDisplayNameLength // ignore: cast_nullable_to_non_nullable
as int,maxNoteLength: null == maxNoteLength ? _self.maxNoteLength : maxNoteLength // ignore: cast_nullable_to_non_nullable
as int,maxAvatarDescriptionLength: null == maxAvatarDescriptionLength ? _self.maxAvatarDescriptionLength : maxAvatarDescriptionLength // ignore: cast_nullable_to_non_nullable
as int,maxHeaderDescriptionLength: null == maxHeaderDescriptionLength ? _self.maxHeaderDescriptionLength : maxHeaderDescriptionLength // ignore: cast_nullable_to_non_nullable
as int,maxFeaturedTags: null == maxFeaturedTags ? _self.maxFeaturedTags : maxFeaturedTags // ignore: cast_nullable_to_non_nullable
as int,maxPinnedStatuses: null == maxPinnedStatuses ? _self.maxPinnedStatuses : maxPinnedStatuses // ignore: cast_nullable_to_non_nullable
as int,maxProfileFields: null == maxProfileFields ? _self.maxProfileFields : maxProfileFields // ignore: cast_nullable_to_non_nullable
as int,profileFieldNameLimit: null == profileFieldNameLimit ? _self.profileFieldNameLimit : profileFieldNameLimit // ignore: cast_nullable_to_non_nullable
as int,profileFieldValueLimit: null == profileFieldValueLimit ? _self.profileFieldValueLimit : profileFieldValueLimit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAccountsConfiguration].
extension MastodonAccountsConfigurationPatterns on MastodonAccountsConfiguration {
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
mixin _$MastodonInstanceConfiguration {

 MastodonInstanceUrls get urls; MastodonStatusesConfiguration? get statuses; MastodonMediaConfiguration? get mediaAttachments; MastodonPollsConfiguration? get polls; MastodonAccountsConfiguration? get accounts; MastodonTimelinesAccess? get timelinesAccess; bool? get translationEnabled; bool? get limitedFederation; String? get vapidPublicKey;
/// Create a copy of MastodonInstanceConfiguration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceConfigurationCopyWith<MastodonInstanceConfiguration> get copyWith => _$MastodonInstanceConfigurationCopyWithImpl<MastodonInstanceConfiguration>(this as MastodonInstanceConfiguration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceConfiguration&&(identical(other.urls, urls) || other.urls == urls)&&(identical(other.statuses, statuses) || other.statuses == statuses)&&(identical(other.mediaAttachments, mediaAttachments) || other.mediaAttachments == mediaAttachments)&&(identical(other.polls, polls) || other.polls == polls)&&(identical(other.accounts, accounts) || other.accounts == accounts)&&(identical(other.timelinesAccess, timelinesAccess) || other.timelinesAccess == timelinesAccess)&&(identical(other.translationEnabled, translationEnabled) || other.translationEnabled == translationEnabled)&&(identical(other.limitedFederation, limitedFederation) || other.limitedFederation == limitedFederation)&&(identical(other.vapidPublicKey, vapidPublicKey) || other.vapidPublicKey == vapidPublicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,urls,statuses,mediaAttachments,polls,accounts,timelinesAccess,translationEnabled,limitedFederation,vapidPublicKey);



}

/// @nodoc
abstract mixin class $MastodonInstanceConfigurationCopyWith<$Res>  {
  factory $MastodonInstanceConfigurationCopyWith(MastodonInstanceConfiguration value, $Res Function(MastodonInstanceConfiguration) _then) = _$MastodonInstanceConfigurationCopyWithImpl;
@useResult
$Res call({
 MastodonInstanceUrls urls, MastodonStatusesConfiguration? statuses, MastodonMediaConfiguration? mediaAttachments, MastodonPollsConfiguration? polls, MastodonAccountsConfiguration? accounts, MastodonTimelinesAccess? timelinesAccess, bool? translationEnabled, bool? limitedFederation, String? vapidPublicKey
});




}
/// @nodoc
class _$MastodonInstanceConfigurationCopyWithImpl<$Res>
    implements $MastodonInstanceConfigurationCopyWith<$Res> {
  _$MastodonInstanceConfigurationCopyWithImpl(this._self, this._then);

  final MastodonInstanceConfiguration _self;
  final $Res Function(MastodonInstanceConfiguration) _then;

/// Create a copy of MastodonInstanceConfiguration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? urls = null,Object? statuses = freezed,Object? mediaAttachments = freezed,Object? polls = freezed,Object? accounts = freezed,Object? timelinesAccess = freezed,Object? translationEnabled = freezed,Object? limitedFederation = freezed,Object? vapidPublicKey = freezed,}) {
  return _then(MastodonInstanceConfiguration(
urls: null == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as MastodonInstanceUrls,statuses: freezed == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as MastodonStatusesConfiguration?,mediaAttachments: freezed == mediaAttachments ? _self.mediaAttachments : mediaAttachments // ignore: cast_nullable_to_non_nullable
as MastodonMediaConfiguration?,polls: freezed == polls ? _self.polls : polls // ignore: cast_nullable_to_non_nullable
as MastodonPollsConfiguration?,accounts: freezed == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as MastodonAccountsConfiguration?,timelinesAccess: freezed == timelinesAccess ? _self.timelinesAccess : timelinesAccess // ignore: cast_nullable_to_non_nullable
as MastodonTimelinesAccess?,translationEnabled: freezed == translationEnabled ? _self.translationEnabled : translationEnabled // ignore: cast_nullable_to_non_nullable
as bool?,limitedFederation: freezed == limitedFederation ? _self.limitedFederation : limitedFederation // ignore: cast_nullable_to_non_nullable
as bool?,vapidPublicKey: freezed == vapidPublicKey ? _self.vapidPublicKey : vapidPublicKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceConfiguration].
extension MastodonInstanceConfigurationPatterns on MastodonInstanceConfiguration {
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
mixin _$MastodonInstanceThumbnail {

 String get url; String? get blurhash; MastodonInstanceThumbnailVersions? get versions;
/// Create a copy of MastodonInstanceThumbnail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceThumbnailCopyWith<MastodonInstanceThumbnail> get copyWith => _$MastodonInstanceThumbnailCopyWithImpl<MastodonInstanceThumbnail>(this as MastodonInstanceThumbnail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceThumbnail&&(identical(other.url, url) || other.url == url)&&(identical(other.blurhash, blurhash) || other.blurhash == blurhash)&&(identical(other.versions, versions) || other.versions == versions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,blurhash,versions);



}

/// @nodoc
abstract mixin class $MastodonInstanceThumbnailCopyWith<$Res>  {
  factory $MastodonInstanceThumbnailCopyWith(MastodonInstanceThumbnail value, $Res Function(MastodonInstanceThumbnail) _then) = _$MastodonInstanceThumbnailCopyWithImpl;
@useResult
$Res call({
 String url, String? blurhash, MastodonInstanceThumbnailVersions? versions
});




}
/// @nodoc
class _$MastodonInstanceThumbnailCopyWithImpl<$Res>
    implements $MastodonInstanceThumbnailCopyWith<$Res> {
  _$MastodonInstanceThumbnailCopyWithImpl(this._self, this._then);

  final MastodonInstanceThumbnail _self;
  final $Res Function(MastodonInstanceThumbnail) _then;

/// Create a copy of MastodonInstanceThumbnail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? blurhash = freezed,Object? versions = freezed,}) {
  return _then(MastodonInstanceThumbnail(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,blurhash: freezed == blurhash ? _self.blurhash : blurhash // ignore: cast_nullable_to_non_nullable
as String?,versions: freezed == versions ? _self.versions : versions // ignore: cast_nullable_to_non_nullable
as MastodonInstanceThumbnailVersions?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceThumbnail].
extension MastodonInstanceThumbnailPatterns on MastodonInstanceThumbnail {
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
mixin _$MastodonInstanceThumbnailVersions {

 String? get at1x; String? get at2x;
/// Create a copy of MastodonInstanceThumbnailVersions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceThumbnailVersionsCopyWith<MastodonInstanceThumbnailVersions> get copyWith => _$MastodonInstanceThumbnailVersionsCopyWithImpl<MastodonInstanceThumbnailVersions>(this as MastodonInstanceThumbnailVersions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceThumbnailVersions&&(identical(other.at1x, at1x) || other.at1x == at1x)&&(identical(other.at2x, at2x) || other.at2x == at2x));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,at1x,at2x);



}

/// @nodoc
abstract mixin class $MastodonInstanceThumbnailVersionsCopyWith<$Res>  {
  factory $MastodonInstanceThumbnailVersionsCopyWith(MastodonInstanceThumbnailVersions value, $Res Function(MastodonInstanceThumbnailVersions) _then) = _$MastodonInstanceThumbnailVersionsCopyWithImpl;
@useResult
$Res call({
 String? at1x, String? at2x
});




}
/// @nodoc
class _$MastodonInstanceThumbnailVersionsCopyWithImpl<$Res>
    implements $MastodonInstanceThumbnailVersionsCopyWith<$Res> {
  _$MastodonInstanceThumbnailVersionsCopyWithImpl(this._self, this._then);

  final MastodonInstanceThumbnailVersions _self;
  final $Res Function(MastodonInstanceThumbnailVersions) _then;

/// Create a copy of MastodonInstanceThumbnailVersions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? at1x = freezed,Object? at2x = freezed,}) {
  return _then(MastodonInstanceThumbnailVersions(
at1x: freezed == at1x ? _self.at1x : at1x // ignore: cast_nullable_to_non_nullable
as String?,at2x: freezed == at2x ? _self.at2x : at2x // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceThumbnailVersions].
extension MastodonInstanceThumbnailVersionsPatterns on MastodonInstanceThumbnailVersions {
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
mixin _$MastodonInstanceUsage {

 int get activeMonth;
/// Create a copy of MastodonInstanceUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceUsageCopyWith<MastodonInstanceUsage> get copyWith => _$MastodonInstanceUsageCopyWithImpl<MastodonInstanceUsage>(this as MastodonInstanceUsage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceUsage&&(identical(other.activeMonth, activeMonth) || other.activeMonth == activeMonth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeMonth);



}

/// @nodoc
abstract mixin class $MastodonInstanceUsageCopyWith<$Res>  {
  factory $MastodonInstanceUsageCopyWith(MastodonInstanceUsage value, $Res Function(MastodonInstanceUsage) _then) = _$MastodonInstanceUsageCopyWithImpl;
@useResult
$Res call({
 int activeMonth
});




}
/// @nodoc
class _$MastodonInstanceUsageCopyWithImpl<$Res>
    implements $MastodonInstanceUsageCopyWith<$Res> {
  _$MastodonInstanceUsageCopyWithImpl(this._self, this._then);

  final MastodonInstanceUsage _self;
  final $Res Function(MastodonInstanceUsage) _then;

/// Create a copy of MastodonInstanceUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeMonth = null,}) {
  return _then(MastodonInstanceUsage(
activeMonth: null == activeMonth ? _self.activeMonth : activeMonth // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceUsage].
extension MastodonInstanceUsagePatterns on MastodonInstanceUsage {
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
mixin _$MastodonInstanceRegistrations {

 bool get enabled; bool get approvalRequired; String? get message; String? get url; int? get minAge; bool? get reasonRequired;
/// Create a copy of MastodonInstanceRegistrations
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceRegistrationsCopyWith<MastodonInstanceRegistrations> get copyWith => _$MastodonInstanceRegistrationsCopyWithImpl<MastodonInstanceRegistrations>(this as MastodonInstanceRegistrations, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceRegistrations&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.approvalRequired, approvalRequired) || other.approvalRequired == approvalRequired)&&(identical(other.message, message) || other.message == message)&&(identical(other.url, url) || other.url == url)&&(identical(other.minAge, minAge) || other.minAge == minAge)&&(identical(other.reasonRequired, reasonRequired) || other.reasonRequired == reasonRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,approvalRequired,message,url,minAge,reasonRequired);



}

/// @nodoc
abstract mixin class $MastodonInstanceRegistrationsCopyWith<$Res>  {
  factory $MastodonInstanceRegistrationsCopyWith(MastodonInstanceRegistrations value, $Res Function(MastodonInstanceRegistrations) _then) = _$MastodonInstanceRegistrationsCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool approvalRequired, String? message, String? url, int? minAge, bool? reasonRequired
});




}
/// @nodoc
class _$MastodonInstanceRegistrationsCopyWithImpl<$Res>
    implements $MastodonInstanceRegistrationsCopyWith<$Res> {
  _$MastodonInstanceRegistrationsCopyWithImpl(this._self, this._then);

  final MastodonInstanceRegistrations _self;
  final $Res Function(MastodonInstanceRegistrations) _then;

/// Create a copy of MastodonInstanceRegistrations
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? approvalRequired = null,Object? message = freezed,Object? url = freezed,Object? minAge = freezed,Object? reasonRequired = freezed,}) {
  return _then(MastodonInstanceRegistrations(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,approvalRequired: null == approvalRequired ? _self.approvalRequired : approvalRequired // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,minAge: freezed == minAge ? _self.minAge : minAge // ignore: cast_nullable_to_non_nullable
as int?,reasonRequired: freezed == reasonRequired ? _self.reasonRequired : reasonRequired // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceRegistrations].
extension MastodonInstanceRegistrationsPatterns on MastodonInstanceRegistrations {
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
mixin _$MastodonInstanceContact {

 String? get email; MastodonAccount? get account;
/// Create a copy of MastodonInstanceContact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceContactCopyWith<MastodonInstanceContact> get copyWith => _$MastodonInstanceContactCopyWithImpl<MastodonInstanceContact>(this as MastodonInstanceContact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceContact&&(identical(other.email, email) || other.email == email)&&(identical(other.account, account) || other.account == account));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,account);



}

/// @nodoc
abstract mixin class $MastodonInstanceContactCopyWith<$Res>  {
  factory $MastodonInstanceContactCopyWith(MastodonInstanceContact value, $Res Function(MastodonInstanceContact) _then) = _$MastodonInstanceContactCopyWithImpl;
@useResult
$Res call({
 String? email, MastodonAccount? account
});




}
/// @nodoc
class _$MastodonInstanceContactCopyWithImpl<$Res>
    implements $MastodonInstanceContactCopyWith<$Res> {
  _$MastodonInstanceContactCopyWithImpl(this._self, this._then);

  final MastodonInstanceContact _self;
  final $Res Function(MastodonInstanceContact) _then;

/// Create a copy of MastodonInstanceContact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = freezed,Object? account = freezed,}) {
  return _then(MastodonInstanceContact(
email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MastodonAccount?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceContact].
extension MastodonInstanceContactPatterns on MastodonInstanceContact {
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
mixin _$MastodonInstanceRule {

 String get id; String get text; String? get hint; Map<String, MastodonInstanceRuleTranslation>? get translations;
/// Create a copy of MastodonInstanceRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceRuleCopyWith<MastodonInstanceRule> get copyWith => _$MastodonInstanceRuleCopyWithImpl<MastodonInstanceRule>(this as MastodonInstanceRule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceRule&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.hint, hint) || other.hint == hint)&&const DeepCollectionEquality().equals(other.translations, translations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,hint,const DeepCollectionEquality().hash(translations));



}

/// @nodoc
abstract mixin class $MastodonInstanceRuleCopyWith<$Res>  {
  factory $MastodonInstanceRuleCopyWith(MastodonInstanceRule value, $Res Function(MastodonInstanceRule) _then) = _$MastodonInstanceRuleCopyWithImpl;
@useResult
$Res call({
 String id, String text, String? hint, Map<String, MastodonInstanceRuleTranslation>? translations
});




}
/// @nodoc
class _$MastodonInstanceRuleCopyWithImpl<$Res>
    implements $MastodonInstanceRuleCopyWith<$Res> {
  _$MastodonInstanceRuleCopyWithImpl(this._self, this._then);

  final MastodonInstanceRule _self;
  final $Res Function(MastodonInstanceRule) _then;

/// Create a copy of MastodonInstanceRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? hint = freezed,Object? translations = freezed,}) {
  return _then(MastodonInstanceRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,translations: freezed == translations ? _self.translations : translations // ignore: cast_nullable_to_non_nullable
as Map<String, MastodonInstanceRuleTranslation>?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceRule].
extension MastodonInstanceRulePatterns on MastodonInstanceRule {
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
mixin _$MastodonInstanceRuleTranslation {

 String get text; String? get hint;
/// Create a copy of MastodonInstanceRuleTranslation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceRuleTranslationCopyWith<MastodonInstanceRuleTranslation> get copyWith => _$MastodonInstanceRuleTranslationCopyWithImpl<MastodonInstanceRuleTranslation>(this as MastodonInstanceRuleTranslation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceRuleTranslation&&(identical(other.text, text) || other.text == text)&&(identical(other.hint, hint) || other.hint == hint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,hint);



}

/// @nodoc
abstract mixin class $MastodonInstanceRuleTranslationCopyWith<$Res>  {
  factory $MastodonInstanceRuleTranslationCopyWith(MastodonInstanceRuleTranslation value, $Res Function(MastodonInstanceRuleTranslation) _then) = _$MastodonInstanceRuleTranslationCopyWithImpl;
@useResult
$Res call({
 String text, String? hint
});




}
/// @nodoc
class _$MastodonInstanceRuleTranslationCopyWithImpl<$Res>
    implements $MastodonInstanceRuleTranslationCopyWith<$Res> {
  _$MastodonInstanceRuleTranslationCopyWithImpl(this._self, this._then);

  final MastodonInstanceRuleTranslation _self;
  final $Res Function(MastodonInstanceRuleTranslation) _then;

/// Create a copy of MastodonInstanceRuleTranslation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? hint = freezed,}) {
  return _then(MastodonInstanceRuleTranslation(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceRuleTranslation].
extension MastodonInstanceRuleTranslationPatterns on MastodonInstanceRuleTranslation {
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
mixin _$MastodonInstance {

 String get domain; String get title; String get version; String? get sourceUrl; String? get description; List<MastodonInstanceIcon>? get icon; MastodonInstanceThumbnail? get thumbnail; MastodonInstanceUsage? get usage; MastodonInstanceConfiguration get configuration; MastodonInstanceContact? get contact; MastodonInstanceRegistrations? get registrations; List<String>? get languages; List<MastodonInstanceRule> get rules; int? get apiVersionMastodon; int? get wrapstodon;
/// Create a copy of MastodonInstance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceCopyWith<MastodonInstance> get copyWith => _$MastodonInstanceCopyWithImpl<MastodonInstance>(this as MastodonInstance, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstance&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.title, title) || other.title == title)&&(identical(other.version, version) || other.version == version)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.icon, icon)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.usage, usage) || other.usage == usage)&&(identical(other.configuration, configuration) || other.configuration == configuration)&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.registrations, registrations) || other.registrations == registrations)&&const DeepCollectionEquality().equals(other.languages, languages)&&const DeepCollectionEquality().equals(other.rules, rules)&&(identical(other.apiVersionMastodon, apiVersionMastodon) || other.apiVersionMastodon == apiVersionMastodon)&&(identical(other.wrapstodon, wrapstodon) || other.wrapstodon == wrapstodon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,domain,title,version,sourceUrl,description,const DeepCollectionEquality().hash(icon),thumbnail,usage,configuration,contact,registrations,const DeepCollectionEquality().hash(languages),const DeepCollectionEquality().hash(rules),apiVersionMastodon,wrapstodon);



}

/// @nodoc
abstract mixin class $MastodonInstanceCopyWith<$Res>  {
  factory $MastodonInstanceCopyWith(MastodonInstance value, $Res Function(MastodonInstance) _then) = _$MastodonInstanceCopyWithImpl;
@useResult
$Res call({
 String domain, String title, String version, MastodonInstanceConfiguration configuration, List<MastodonInstanceRule> rules, String? sourceUrl, String? description, List<MastodonInstanceIcon>? icon, MastodonInstanceThumbnail? thumbnail, MastodonInstanceUsage? usage, MastodonInstanceContact? contact, MastodonInstanceRegistrations? registrations, List<String>? languages, int? apiVersionMastodon, int? wrapstodon
});




}
/// @nodoc
class _$MastodonInstanceCopyWithImpl<$Res>
    implements $MastodonInstanceCopyWith<$Res> {
  _$MastodonInstanceCopyWithImpl(this._self, this._then);

  final MastodonInstance _self;
  final $Res Function(MastodonInstance) _then;

/// Create a copy of MastodonInstance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? domain = null,Object? title = null,Object? version = null,Object? configuration = null,Object? rules = null,Object? sourceUrl = freezed,Object? description = freezed,Object? icon = freezed,Object? thumbnail = freezed,Object? usage = freezed,Object? contact = freezed,Object? registrations = freezed,Object? languages = freezed,Object? apiVersionMastodon = freezed,Object? wrapstodon = freezed,}) {
  return _then(MastodonInstance(
domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,configuration: null == configuration ? _self.configuration : configuration // ignore: cast_nullable_to_non_nullable
as MastodonInstanceConfiguration,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<MastodonInstanceRule>,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as List<MastodonInstanceIcon>?,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as MastodonInstanceThumbnail?,usage: freezed == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as MastodonInstanceUsage?,contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as MastodonInstanceContact?,registrations: freezed == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as MastodonInstanceRegistrations?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,apiVersionMastodon: freezed == apiVersionMastodon ? _self.apiVersionMastodon : apiVersionMastodon // ignore: cast_nullable_to_non_nullable
as int?,wrapstodon: freezed == wrapstodon ? _self.wrapstodon : wrapstodon // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstance].
extension MastodonInstancePatterns on MastodonInstance {
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
mixin _$MastodonInstanceIcon {

 String get src; String get size;
/// Create a copy of MastodonInstanceIcon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceIconCopyWith<MastodonInstanceIcon> get copyWith => _$MastodonInstanceIconCopyWithImpl<MastodonInstanceIcon>(this as MastodonInstanceIcon, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceIcon&&(identical(other.src, src) || other.src == src)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,src,size);



}

/// @nodoc
abstract mixin class $MastodonInstanceIconCopyWith<$Res>  {
  factory $MastodonInstanceIconCopyWith(MastodonInstanceIcon value, $Res Function(MastodonInstanceIcon) _then) = _$MastodonInstanceIconCopyWithImpl;
@useResult
$Res call({
 String src, String size
});




}
/// @nodoc
class _$MastodonInstanceIconCopyWithImpl<$Res>
    implements $MastodonInstanceIconCopyWith<$Res> {
  _$MastodonInstanceIconCopyWithImpl(this._self, this._then);

  final MastodonInstanceIcon _self;
  final $Res Function(MastodonInstanceIcon) _then;

/// Create a copy of MastodonInstanceIcon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? src = null,Object? size = null,}) {
  return _then(MastodonInstanceIcon(
src: null == src ? _self.src : src // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceIcon].
extension MastodonInstanceIconPatterns on MastodonInstanceIcon {
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
