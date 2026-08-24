// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_instance_v1.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonInstanceV1Urls {

 String? get streamingApi;
/// Create a copy of MastodonInstanceV1Urls
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceV1UrlsCopyWith<MastodonInstanceV1Urls> get copyWith => _$MastodonInstanceV1UrlsCopyWithImpl<MastodonInstanceV1Urls>(this as MastodonInstanceV1Urls, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceV1Urls&&(identical(other.streamingApi, streamingApi) || other.streamingApi == streamingApi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,streamingApi);



}

/// @nodoc
abstract mixin class $MastodonInstanceV1UrlsCopyWith<$Res>  {
  factory $MastodonInstanceV1UrlsCopyWith(MastodonInstanceV1Urls value, $Res Function(MastodonInstanceV1Urls) _then) = _$MastodonInstanceV1UrlsCopyWithImpl;
@useResult
$Res call({
 String? streamingApi
});




}
/// @nodoc
class _$MastodonInstanceV1UrlsCopyWithImpl<$Res>
    implements $MastodonInstanceV1UrlsCopyWith<$Res> {
  _$MastodonInstanceV1UrlsCopyWithImpl(this._self, this._then);

  final MastodonInstanceV1Urls _self;
  final $Res Function(MastodonInstanceV1Urls) _then;

/// Create a copy of MastodonInstanceV1Urls
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? streamingApi = freezed,}) {
  return _then(MastodonInstanceV1Urls(
streamingApi: freezed == streamingApi ? _self.streamingApi : streamingApi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceV1Urls].
extension MastodonInstanceV1UrlsPatterns on MastodonInstanceV1Urls {
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
mixin _$MastodonInstanceV1Stats {

 int get userCount; int get statusCount; int get domainCount;
/// Create a copy of MastodonInstanceV1Stats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceV1StatsCopyWith<MastodonInstanceV1Stats> get copyWith => _$MastodonInstanceV1StatsCopyWithImpl<MastodonInstanceV1Stats>(this as MastodonInstanceV1Stats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceV1Stats&&(identical(other.userCount, userCount) || other.userCount == userCount)&&(identical(other.statusCount, statusCount) || other.statusCount == statusCount)&&(identical(other.domainCount, domainCount) || other.domainCount == domainCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userCount,statusCount,domainCount);



}

/// @nodoc
abstract mixin class $MastodonInstanceV1StatsCopyWith<$Res>  {
  factory $MastodonInstanceV1StatsCopyWith(MastodonInstanceV1Stats value, $Res Function(MastodonInstanceV1Stats) _then) = _$MastodonInstanceV1StatsCopyWithImpl;
@useResult
$Res call({
 int userCount, int statusCount, int domainCount
});




}
/// @nodoc
class _$MastodonInstanceV1StatsCopyWithImpl<$Res>
    implements $MastodonInstanceV1StatsCopyWith<$Res> {
  _$MastodonInstanceV1StatsCopyWithImpl(this._self, this._then);

  final MastodonInstanceV1Stats _self;
  final $Res Function(MastodonInstanceV1Stats) _then;

/// Create a copy of MastodonInstanceV1Stats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userCount = null,Object? statusCount = null,Object? domainCount = null,}) {
  return _then(MastodonInstanceV1Stats(
userCount: null == userCount ? _self.userCount : userCount // ignore: cast_nullable_to_non_nullable
as int,statusCount: null == statusCount ? _self.statusCount : statusCount // ignore: cast_nullable_to_non_nullable
as int,domainCount: null == domainCount ? _self.domainCount : domainCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceV1Stats].
extension MastodonInstanceV1StatsPatterns on MastodonInstanceV1Stats {
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
mixin _$MastodonInstanceV1Configuration {

 MastodonStatusesConfiguration? get statuses; MastodonMediaConfiguration? get mediaAttachments; MastodonPollsConfiguration? get polls;
/// Create a copy of MastodonInstanceV1Configuration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceV1ConfigurationCopyWith<MastodonInstanceV1Configuration> get copyWith => _$MastodonInstanceV1ConfigurationCopyWithImpl<MastodonInstanceV1Configuration>(this as MastodonInstanceV1Configuration, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceV1Configuration&&(identical(other.statuses, statuses) || other.statuses == statuses)&&(identical(other.mediaAttachments, mediaAttachments) || other.mediaAttachments == mediaAttachments)&&(identical(other.polls, polls) || other.polls == polls));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statuses,mediaAttachments,polls);



}

/// @nodoc
abstract mixin class $MastodonInstanceV1ConfigurationCopyWith<$Res>  {
  factory $MastodonInstanceV1ConfigurationCopyWith(MastodonInstanceV1Configuration value, $Res Function(MastodonInstanceV1Configuration) _then) = _$MastodonInstanceV1ConfigurationCopyWithImpl;
@useResult
$Res call({
 MastodonStatusesConfiguration? statuses, MastodonMediaConfiguration? mediaAttachments, MastodonPollsConfiguration? polls
});




}
/// @nodoc
class _$MastodonInstanceV1ConfigurationCopyWithImpl<$Res>
    implements $MastodonInstanceV1ConfigurationCopyWith<$Res> {
  _$MastodonInstanceV1ConfigurationCopyWithImpl(this._self, this._then);

  final MastodonInstanceV1Configuration _self;
  final $Res Function(MastodonInstanceV1Configuration) _then;

/// Create a copy of MastodonInstanceV1Configuration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statuses = freezed,Object? mediaAttachments = freezed,Object? polls = freezed,}) {
  return _then(MastodonInstanceV1Configuration(
statuses: freezed == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as MastodonStatusesConfiguration?,mediaAttachments: freezed == mediaAttachments ? _self.mediaAttachments : mediaAttachments // ignore: cast_nullable_to_non_nullable
as MastodonMediaConfiguration?,polls: freezed == polls ? _self.polls : polls // ignore: cast_nullable_to_non_nullable
as MastodonPollsConfiguration?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceV1Configuration].
extension MastodonInstanceV1ConfigurationPatterns on MastodonInstanceV1Configuration {
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
mixin _$MastodonInstanceV1 {

 String get uri; String get title; String? get shortDescription; String? get description; String? get email; String get version; MastodonInstanceV1Urls? get urls; MastodonInstanceV1Stats? get stats; String? get thumbnail; List<String>? get languages; bool get registrations; bool get approvalRequired; bool get invitesEnabled; MastodonInstanceV1Configuration? get configuration; MastodonAccount? get contactAccount; List<MastodonInstanceRule> get rules;
/// Create a copy of MastodonInstanceV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonInstanceV1CopyWith<MastodonInstanceV1> get copyWith => _$MastodonInstanceV1CopyWithImpl<MastodonInstanceV1>(this as MastodonInstanceV1, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonInstanceV1&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.title, title) || other.title == title)&&(identical(other.shortDescription, shortDescription) || other.shortDescription == shortDescription)&&(identical(other.description, description) || other.description == description)&&(identical(other.email, email) || other.email == email)&&(identical(other.version, version) || other.version == version)&&(identical(other.urls, urls) || other.urls == urls)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.registrations, registrations) || other.registrations == registrations)&&(identical(other.approvalRequired, approvalRequired) || other.approvalRequired == approvalRequired)&&(identical(other.invitesEnabled, invitesEnabled) || other.invitesEnabled == invitesEnabled)&&(identical(other.configuration, configuration) || other.configuration == configuration)&&(identical(other.contactAccount, contactAccount) || other.contactAccount == contactAccount)&&const DeepCollectionEquality().equals(other.rules, rules));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uri,title,shortDescription,description,email,version,urls,stats,thumbnail,const DeepCollectionEquality().hash(languages),registrations,approvalRequired,invitesEnabled,configuration,contactAccount,const DeepCollectionEquality().hash(rules));



}

/// @nodoc
abstract mixin class $MastodonInstanceV1CopyWith<$Res>  {
  factory $MastodonInstanceV1CopyWith(MastodonInstanceV1 value, $Res Function(MastodonInstanceV1) _then) = _$MastodonInstanceV1CopyWithImpl;
@useResult
$Res call({
 String uri, String title, String version, List<MastodonInstanceRule> rules, String? shortDescription, String? description, String? email, MastodonInstanceV1Urls? urls, MastodonInstanceV1Stats? stats, String? thumbnail, List<String>? languages, bool registrations, bool approvalRequired, bool invitesEnabled, MastodonInstanceV1Configuration? configuration, MastodonAccount? contactAccount
});




}
/// @nodoc
class _$MastodonInstanceV1CopyWithImpl<$Res>
    implements $MastodonInstanceV1CopyWith<$Res> {
  _$MastodonInstanceV1CopyWithImpl(this._self, this._then);

  final MastodonInstanceV1 _self;
  final $Res Function(MastodonInstanceV1) _then;

/// Create a copy of MastodonInstanceV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uri = null,Object? title = null,Object? version = null,Object? rules = null,Object? shortDescription = freezed,Object? description = freezed,Object? email = freezed,Object? urls = freezed,Object? stats = freezed,Object? thumbnail = freezed,Object? languages = freezed,Object? registrations = null,Object? approvalRequired = null,Object? invitesEnabled = null,Object? configuration = freezed,Object? contactAccount = freezed,}) {
  return _then(MastodonInstanceV1(
uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<MastodonInstanceRule>,shortDescription: freezed == shortDescription ? _self.shortDescription : shortDescription // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,urls: freezed == urls ? _self.urls : urls // ignore: cast_nullable_to_non_nullable
as MastodonInstanceV1Urls?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as MastodonInstanceV1Stats?,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,registrations: null == registrations ? _self.registrations : registrations // ignore: cast_nullable_to_non_nullable
as bool,approvalRequired: null == approvalRequired ? _self.approvalRequired : approvalRequired // ignore: cast_nullable_to_non_nullable
as bool,invitesEnabled: null == invitesEnabled ? _self.invitesEnabled : invitesEnabled // ignore: cast_nullable_to_non_nullable
as bool,configuration: freezed == configuration ? _self.configuration : configuration // ignore: cast_nullable_to_non_nullable
as MastodonInstanceV1Configuration?,contactAccount: freezed == contactAccount ? _self.contactAccount : contactAccount // ignore: cast_nullable_to_non_nullable
as MastodonAccount?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonInstanceV1].
extension MastodonInstanceV1Patterns on MastodonInstanceV1 {
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
