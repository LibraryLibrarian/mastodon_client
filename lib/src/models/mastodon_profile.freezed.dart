// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonProfile {

 String get id; String get displayName; String get note; String get formattedNote; List<MastodonField> get fields; List<MastodonField> get formattedFields; String? get avatar; String? get avatarStatic; String? get avatarDescription; String? get header; String? get headerStatic; String? get headerDescription; bool get locked; bool get bot; bool get hideCollections; bool get discoverable; bool get indexable; bool get showMedia; bool get showMediaReplies; bool get showFeatured; List<String> get attributionDomains; List<MastodonFeaturedTag> get featuredTags;
/// Create a copy of MastodonProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonProfileCopyWith<MastodonProfile> get copyWith => _$MastodonProfileCopyWithImpl<MastodonProfile>(this as MastodonProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.note, note) || other.note == note)&&(identical(other.formattedNote, formattedNote) || other.formattedNote == formattedNote)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.formattedFields, formattedFields)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.avatarStatic, avatarStatic) || other.avatarStatic == avatarStatic)&&(identical(other.avatarDescription, avatarDescription) || other.avatarDescription == avatarDescription)&&(identical(other.header, header) || other.header == header)&&(identical(other.headerStatic, headerStatic) || other.headerStatic == headerStatic)&&(identical(other.headerDescription, headerDescription) || other.headerDescription == headerDescription)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.bot, bot) || other.bot == bot)&&(identical(other.hideCollections, hideCollections) || other.hideCollections == hideCollections)&&(identical(other.discoverable, discoverable) || other.discoverable == discoverable)&&(identical(other.indexable, indexable) || other.indexable == indexable)&&(identical(other.showMedia, showMedia) || other.showMedia == showMedia)&&(identical(other.showMediaReplies, showMediaReplies) || other.showMediaReplies == showMediaReplies)&&(identical(other.showFeatured, showFeatured) || other.showFeatured == showFeatured)&&const DeepCollectionEquality().equals(other.attributionDomains, attributionDomains)&&const DeepCollectionEquality().equals(other.featuredTags, featuredTags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,displayName,note,formattedNote,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(formattedFields),avatar,avatarStatic,avatarDescription,header,headerStatic,headerDescription,locked,bot,hideCollections,discoverable,indexable,showMedia,showMediaReplies,showFeatured,const DeepCollectionEquality().hash(attributionDomains),const DeepCollectionEquality().hash(featuredTags)]);



}

/// @nodoc
abstract mixin class $MastodonProfileCopyWith<$Res>  {
  factory $MastodonProfileCopyWith(MastodonProfile value, $Res Function(MastodonProfile) _then) = _$MastodonProfileCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String note, String formattedNote, List<MastodonField> fields, List<MastodonField> formattedFields, bool locked, bool bot, bool hideCollections, bool discoverable, bool indexable, bool showMedia, bool showMediaReplies, bool showFeatured, String? avatar, String? avatarStatic, String? avatarDescription, String? header, String? headerStatic, String? headerDescription, List<String> attributionDomains, List<MastodonFeaturedTag> featuredTags
});




}
/// @nodoc
class _$MastodonProfileCopyWithImpl<$Res>
    implements $MastodonProfileCopyWith<$Res> {
  _$MastodonProfileCopyWithImpl(this._self, this._then);

  final MastodonProfile _self;
  final $Res Function(MastodonProfile) _then;

/// Create a copy of MastodonProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? note = null,Object? formattedNote = null,Object? fields = null,Object? formattedFields = null,Object? locked = null,Object? bot = null,Object? hideCollections = null,Object? discoverable = null,Object? indexable = null,Object? showMedia = null,Object? showMediaReplies = null,Object? showFeatured = null,Object? avatar = freezed,Object? avatarStatic = freezed,Object? avatarDescription = freezed,Object? header = freezed,Object? headerStatic = freezed,Object? headerDescription = freezed,Object? attributionDomains = null,Object? featuredTags = null,}) {
  return _then(MastodonProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,formattedNote: null == formattedNote ? _self.formattedNote : formattedNote // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<MastodonField>,formattedFields: null == formattedFields ? _self.formattedFields : formattedFields // ignore: cast_nullable_to_non_nullable
as List<MastodonField>,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,bot: null == bot ? _self.bot : bot // ignore: cast_nullable_to_non_nullable
as bool,hideCollections: null == hideCollections ? _self.hideCollections : hideCollections // ignore: cast_nullable_to_non_nullable
as bool,discoverable: null == discoverable ? _self.discoverable : discoverable // ignore: cast_nullable_to_non_nullable
as bool,indexable: null == indexable ? _self.indexable : indexable // ignore: cast_nullable_to_non_nullable
as bool,showMedia: null == showMedia ? _self.showMedia : showMedia // ignore: cast_nullable_to_non_nullable
as bool,showMediaReplies: null == showMediaReplies ? _self.showMediaReplies : showMediaReplies // ignore: cast_nullable_to_non_nullable
as bool,showFeatured: null == showFeatured ? _self.showFeatured : showFeatured // ignore: cast_nullable_to_non_nullable
as bool,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,avatarStatic: freezed == avatarStatic ? _self.avatarStatic : avatarStatic // ignore: cast_nullable_to_non_nullable
as String?,avatarDescription: freezed == avatarDescription ? _self.avatarDescription : avatarDescription // ignore: cast_nullable_to_non_nullable
as String?,header: freezed == header ? _self.header : header // ignore: cast_nullable_to_non_nullable
as String?,headerStatic: freezed == headerStatic ? _self.headerStatic : headerStatic // ignore: cast_nullable_to_non_nullable
as String?,headerDescription: freezed == headerDescription ? _self.headerDescription : headerDescription // ignore: cast_nullable_to_non_nullable
as String?,attributionDomains: null == attributionDomains ? _self.attributionDomains : attributionDomains // ignore: cast_nullable_to_non_nullable
as List<String>,featuredTags: null == featuredTags ? _self.featuredTags : featuredTags // ignore: cast_nullable_to_non_nullable
as List<MastodonFeaturedTag>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonProfile].
extension MastodonProfilePatterns on MastodonProfile {
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
