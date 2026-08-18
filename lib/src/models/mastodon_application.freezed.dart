// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonApplication {

 String get id; String get name; String? get website; List<String> get scopes; List<String> get redirectUris; String? get redirectUri; String? get vapidKey;
/// Create a copy of MastodonApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonApplicationCopyWith<MastodonApplication> get copyWith => _$MastodonApplicationCopyWithImpl<MastodonApplication>(this as MastodonApplication, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.website, website) || other.website == website)&&const DeepCollectionEquality().equals(other.scopes, scopes)&&const DeepCollectionEquality().equals(other.redirectUris, redirectUris)&&(identical(other.redirectUri, redirectUri) || other.redirectUri == redirectUri)&&(identical(other.vapidKey, vapidKey) || other.vapidKey == vapidKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,website,const DeepCollectionEquality().hash(scopes),const DeepCollectionEquality().hash(redirectUris),redirectUri,vapidKey);

@override
String toString() {
  return 'MastodonApplication(id: $id, name: $name, website: $website, scopes: $scopes, redirectUris: $redirectUris, redirectUri: $redirectUri, vapidKey: $vapidKey)';
}


}

/// @nodoc
abstract mixin class $MastodonApplicationCopyWith<$Res>  {
  factory $MastodonApplicationCopyWith(MastodonApplication value, $Res Function(MastodonApplication) _then) = _$MastodonApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? website, List<String> scopes, List<String> redirectUris,@Deprecated('Use redirectUris instead') String? redirectUri,@Deprecated('VAPID key used by the Push Streaming API') String? vapidKey
});




}
/// @nodoc
class _$MastodonApplicationCopyWithImpl<$Res>
    implements $MastodonApplicationCopyWith<$Res> {
  _$MastodonApplicationCopyWithImpl(this._self, this._then);

  final MastodonApplication _self;
  final $Res Function(MastodonApplication) _then;

/// Create a copy of MastodonApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? website = freezed,Object? scopes = null,Object? redirectUris = null,Object? redirectUri = freezed,Object? vapidKey = freezed,}) {
  return _then(MastodonApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,scopes: null == scopes ? _self.scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<String>,redirectUris: null == redirectUris ? _self.redirectUris : redirectUris // ignore: cast_nullable_to_non_nullable
as List<String>,redirectUri: freezed == redirectUri ? _self.redirectUri : redirectUri // ignore: cast_nullable_to_non_nullable
as String?,vapidKey: freezed == vapidKey ? _self.vapidKey : vapidKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonApplication].
extension MastodonApplicationPatterns on MastodonApplication {
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
mixin _$MastodonCredentialApplication {

 String get id; String get name; String? get website; List<String> get scopes; List<String> get redirectUris; String? get redirectUri; String get clientId; String get clientSecret; int get clientSecretExpiresAt;
/// Create a copy of MastodonCredentialApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonCredentialApplicationCopyWith<MastodonCredentialApplication> get copyWith => _$MastodonCredentialApplicationCopyWithImpl<MastodonCredentialApplication>(this as MastodonCredentialApplication, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonCredentialApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.website, website) || other.website == website)&&const DeepCollectionEquality().equals(other.scopes, scopes)&&const DeepCollectionEquality().equals(other.redirectUris, redirectUris)&&(identical(other.redirectUri, redirectUri) || other.redirectUri == redirectUri)&&(identical(other.clientId, clientId) || other.clientId == clientId)&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.clientSecretExpiresAt, clientSecretExpiresAt) || other.clientSecretExpiresAt == clientSecretExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,website,const DeepCollectionEquality().hash(scopes),const DeepCollectionEquality().hash(redirectUris),redirectUri,clientId,clientSecret,clientSecretExpiresAt);



}

/// @nodoc
abstract mixin class $MastodonCredentialApplicationCopyWith<$Res>  {
  factory $MastodonCredentialApplicationCopyWith(MastodonCredentialApplication value, $Res Function(MastodonCredentialApplication) _then) = _$MastodonCredentialApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? website, List<String> scopes, List<String> redirectUris,@Deprecated('Use redirectUris instead') String? redirectUri, String clientId, String clientSecret, int clientSecretExpiresAt
});




}
/// @nodoc
class _$MastodonCredentialApplicationCopyWithImpl<$Res>
    implements $MastodonCredentialApplicationCopyWith<$Res> {
  _$MastodonCredentialApplicationCopyWithImpl(this._self, this._then);

  final MastodonCredentialApplication _self;
  final $Res Function(MastodonCredentialApplication) _then;

/// Create a copy of MastodonCredentialApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? website = freezed,Object? scopes = null,Object? redirectUris = null,Object? redirectUri = freezed,Object? clientId = null,Object? clientSecret = null,Object? clientSecretExpiresAt = null,}) {
  return _then(MastodonCredentialApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,scopes: null == scopes ? _self.scopes : scopes // ignore: cast_nullable_to_non_nullable
as List<String>,redirectUris: null == redirectUris ? _self.redirectUris : redirectUris // ignore: cast_nullable_to_non_nullable
as List<String>,redirectUri: freezed == redirectUri ? _self.redirectUri : redirectUri // ignore: cast_nullable_to_non_nullable
as String?,clientId: null == clientId ? _self.clientId : clientId // ignore: cast_nullable_to_non_nullable
as String,clientSecret: null == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String,clientSecretExpiresAt: null == clientSecretExpiresAt ? _self.clientSecretExpiresAt : clientSecretExpiresAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonCredentialApplication].
extension MastodonCredentialApplicationPatterns on MastodonCredentialApplication {
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
