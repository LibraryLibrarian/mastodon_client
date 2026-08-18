// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_streaming_announcement_reaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonStreamingAnnouncementReaction {

 String get name; int get count; String get announcementId;
/// Create a copy of MastodonStreamingAnnouncementReaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonStreamingAnnouncementReactionCopyWith<MastodonStreamingAnnouncementReaction> get copyWith => _$MastodonStreamingAnnouncementReactionCopyWithImpl<MastodonStreamingAnnouncementReaction>(this as MastodonStreamingAnnouncementReaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonStreamingAnnouncementReaction&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count)&&(identical(other.announcementId, announcementId) || other.announcementId == announcementId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,count,announcementId);

@override
String toString() {
  return 'MastodonStreamingAnnouncementReaction(name: $name, count: $count, announcementId: $announcementId)';
}


}

/// @nodoc
abstract mixin class $MastodonStreamingAnnouncementReactionCopyWith<$Res>  {
  factory $MastodonStreamingAnnouncementReactionCopyWith(MastodonStreamingAnnouncementReaction value, $Res Function(MastodonStreamingAnnouncementReaction) _then) = _$MastodonStreamingAnnouncementReactionCopyWithImpl;
@useResult
$Res call({
 String name, int count, String announcementId
});




}
/// @nodoc
class _$MastodonStreamingAnnouncementReactionCopyWithImpl<$Res>
    implements $MastodonStreamingAnnouncementReactionCopyWith<$Res> {
  _$MastodonStreamingAnnouncementReactionCopyWithImpl(this._self, this._then);

  final MastodonStreamingAnnouncementReaction _self;
  final $Res Function(MastodonStreamingAnnouncementReaction) _then;

/// Create a copy of MastodonStreamingAnnouncementReaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? count = null,Object? announcementId = null,}) {
  return _then(MastodonStreamingAnnouncementReaction(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,announcementId: null == announcementId ? _self.announcementId : announcementId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonStreamingAnnouncementReaction].
extension MastodonStreamingAnnouncementReactionPatterns on MastodonStreamingAnnouncementReaction {
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
