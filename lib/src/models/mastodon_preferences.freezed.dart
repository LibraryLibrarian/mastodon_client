// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonPreferences {

 String get postingDefaultVisibility; bool get postingDefaultSensitive; String? get postingDefaultLanguage; String? get postingDefaultQuotePolicy; String get readingExpandMedia; bool get readingExpandSpoilers; bool get readingAutoplayGifs;
/// Create a copy of MastodonPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonPreferencesCopyWith<MastodonPreferences> get copyWith => _$MastodonPreferencesCopyWithImpl<MastodonPreferences>(this as MastodonPreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonPreferences&&(identical(other.postingDefaultVisibility, postingDefaultVisibility) || other.postingDefaultVisibility == postingDefaultVisibility)&&(identical(other.postingDefaultSensitive, postingDefaultSensitive) || other.postingDefaultSensitive == postingDefaultSensitive)&&(identical(other.postingDefaultLanguage, postingDefaultLanguage) || other.postingDefaultLanguage == postingDefaultLanguage)&&(identical(other.postingDefaultQuotePolicy, postingDefaultQuotePolicy) || other.postingDefaultQuotePolicy == postingDefaultQuotePolicy)&&(identical(other.readingExpandMedia, readingExpandMedia) || other.readingExpandMedia == readingExpandMedia)&&(identical(other.readingExpandSpoilers, readingExpandSpoilers) || other.readingExpandSpoilers == readingExpandSpoilers)&&(identical(other.readingAutoplayGifs, readingAutoplayGifs) || other.readingAutoplayGifs == readingAutoplayGifs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,postingDefaultVisibility,postingDefaultSensitive,postingDefaultLanguage,postingDefaultQuotePolicy,readingExpandMedia,readingExpandSpoilers,readingAutoplayGifs);

@override
String toString() {
  return 'MastodonPreferences(postingDefaultVisibility: $postingDefaultVisibility, postingDefaultSensitive: $postingDefaultSensitive, postingDefaultLanguage: $postingDefaultLanguage, postingDefaultQuotePolicy: $postingDefaultQuotePolicy, readingExpandMedia: $readingExpandMedia, readingExpandSpoilers: $readingExpandSpoilers, readingAutoplayGifs: $readingAutoplayGifs)';
}


}

/// @nodoc
abstract mixin class $MastodonPreferencesCopyWith<$Res>  {
  factory $MastodonPreferencesCopyWith(MastodonPreferences value, $Res Function(MastodonPreferences) _then) = _$MastodonPreferencesCopyWithImpl;
@useResult
$Res call({
 String postingDefaultVisibility, bool postingDefaultSensitive, String? postingDefaultLanguage, String? postingDefaultQuotePolicy, String readingExpandMedia, bool readingExpandSpoilers, bool readingAutoplayGifs
});




}
/// @nodoc
class _$MastodonPreferencesCopyWithImpl<$Res>
    implements $MastodonPreferencesCopyWith<$Res> {
  _$MastodonPreferencesCopyWithImpl(this._self, this._then);

  final MastodonPreferences _self;
  final $Res Function(MastodonPreferences) _then;

/// Create a copy of MastodonPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postingDefaultVisibility = null,Object? postingDefaultSensitive = null,Object? postingDefaultLanguage = freezed,Object? postingDefaultQuotePolicy = freezed,Object? readingExpandMedia = null,Object? readingExpandSpoilers = null,Object? readingAutoplayGifs = null,}) {
  return _then(MastodonPreferences(
postingDefaultVisibility: null == postingDefaultVisibility ? _self.postingDefaultVisibility : postingDefaultVisibility // ignore: cast_nullable_to_non_nullable
as String,postingDefaultSensitive: null == postingDefaultSensitive ? _self.postingDefaultSensitive : postingDefaultSensitive // ignore: cast_nullable_to_non_nullable
as bool,postingDefaultLanguage: freezed == postingDefaultLanguage ? _self.postingDefaultLanguage : postingDefaultLanguage // ignore: cast_nullable_to_non_nullable
as String?,postingDefaultQuotePolicy: freezed == postingDefaultQuotePolicy ? _self.postingDefaultQuotePolicy : postingDefaultQuotePolicy // ignore: cast_nullable_to_non_nullable
as String?,readingExpandMedia: null == readingExpandMedia ? _self.readingExpandMedia : readingExpandMedia // ignore: cast_nullable_to_non_nullable
as String,readingExpandSpoilers: null == readingExpandSpoilers ? _self.readingExpandSpoilers : readingExpandSpoilers // ignore: cast_nullable_to_non_nullable
as bool,readingAutoplayGifs: null == readingAutoplayGifs ? _self.readingAutoplayGifs : readingAutoplayGifs // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonPreferences].
extension MastodonPreferencesPatterns on MastodonPreferences {
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
