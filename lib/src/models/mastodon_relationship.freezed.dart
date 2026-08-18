// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_relationship.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonRelationship {

 String get id; bool get following; bool get showingReblogs; bool get notifying; List<String>? get languages; bool get followedBy; bool get blocking; bool get blockedBy; bool get muting; DateTime? get mutingExpiresAt; bool get mutingNotifications; bool get requested; bool get requestedBy; bool get domainBlocking; bool get endorsed; String get note;
/// Create a copy of MastodonRelationship
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonRelationshipCopyWith<MastodonRelationship> get copyWith => _$MastodonRelationshipCopyWithImpl<MastodonRelationship>(this as MastodonRelationship, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonRelationship&&(identical(other.id, id) || other.id == id)&&(identical(other.following, following) || other.following == following)&&(identical(other.showingReblogs, showingReblogs) || other.showingReblogs == showingReblogs)&&(identical(other.notifying, notifying) || other.notifying == notifying)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.followedBy, followedBy) || other.followedBy == followedBy)&&(identical(other.blocking, blocking) || other.blocking == blocking)&&(identical(other.blockedBy, blockedBy) || other.blockedBy == blockedBy)&&(identical(other.muting, muting) || other.muting == muting)&&(identical(other.mutingExpiresAt, mutingExpiresAt) || other.mutingExpiresAt == mutingExpiresAt)&&(identical(other.mutingNotifications, mutingNotifications) || other.mutingNotifications == mutingNotifications)&&(identical(other.requested, requested) || other.requested == requested)&&(identical(other.requestedBy, requestedBy) || other.requestedBy == requestedBy)&&(identical(other.domainBlocking, domainBlocking) || other.domainBlocking == domainBlocking)&&(identical(other.endorsed, endorsed) || other.endorsed == endorsed)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,following,showingReblogs,notifying,const DeepCollectionEquality().hash(languages),followedBy,blocking,blockedBy,muting,mutingExpiresAt,mutingNotifications,requested,requestedBy,domainBlocking,endorsed,note);



}

/// @nodoc
abstract mixin class $MastodonRelationshipCopyWith<$Res>  {
  factory $MastodonRelationshipCopyWith(MastodonRelationship value, $Res Function(MastodonRelationship) _then) = _$MastodonRelationshipCopyWithImpl;
@useResult
$Res call({
 String id, bool following, bool showingReblogs, bool notifying, bool followedBy, bool blocking, bool blockedBy, bool muting, bool mutingNotifications, bool requested, bool requestedBy, bool domainBlocking, bool endorsed, String note, List<String>? languages, DateTime? mutingExpiresAt
});




}
/// @nodoc
class _$MastodonRelationshipCopyWithImpl<$Res>
    implements $MastodonRelationshipCopyWith<$Res> {
  _$MastodonRelationshipCopyWithImpl(this._self, this._then);

  final MastodonRelationship _self;
  final $Res Function(MastodonRelationship) _then;

/// Create a copy of MastodonRelationship
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? following = null,Object? showingReblogs = null,Object? notifying = null,Object? followedBy = null,Object? blocking = null,Object? blockedBy = null,Object? muting = null,Object? mutingNotifications = null,Object? requested = null,Object? requestedBy = null,Object? domainBlocking = null,Object? endorsed = null,Object? note = null,Object? languages = freezed,Object? mutingExpiresAt = freezed,}) {
  return _then(MastodonRelationship(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,following: null == following ? _self.following : following // ignore: cast_nullable_to_non_nullable
as bool,showingReblogs: null == showingReblogs ? _self.showingReblogs : showingReblogs // ignore: cast_nullable_to_non_nullable
as bool,notifying: null == notifying ? _self.notifying : notifying // ignore: cast_nullable_to_non_nullable
as bool,followedBy: null == followedBy ? _self.followedBy : followedBy // ignore: cast_nullable_to_non_nullable
as bool,blocking: null == blocking ? _self.blocking : blocking // ignore: cast_nullable_to_non_nullable
as bool,blockedBy: null == blockedBy ? _self.blockedBy : blockedBy // ignore: cast_nullable_to_non_nullable
as bool,muting: null == muting ? _self.muting : muting // ignore: cast_nullable_to_non_nullable
as bool,mutingNotifications: null == mutingNotifications ? _self.mutingNotifications : mutingNotifications // ignore: cast_nullable_to_non_nullable
as bool,requested: null == requested ? _self.requested : requested // ignore: cast_nullable_to_non_nullable
as bool,requestedBy: null == requestedBy ? _self.requestedBy : requestedBy // ignore: cast_nullable_to_non_nullable
as bool,domainBlocking: null == domainBlocking ? _self.domainBlocking : domainBlocking // ignore: cast_nullable_to_non_nullable
as bool,endorsed: null == endorsed ? _self.endorsed : endorsed // ignore: cast_nullable_to_non_nullable
as bool,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,mutingExpiresAt: freezed == mutingExpiresAt ? _self.mutingExpiresAt : mutingExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonRelationship].
extension MastodonRelationshipPatterns on MastodonRelationship {
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
