// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAccount {

 String get id; String get username; String get acct; String get displayName; String get note; String get url; String? get uri; String get avatarUrl; String get avatarStaticUrl; String get headerUrl; String get headerStaticUrl; bool get locked; bool get bot; bool? get discoverable; bool? get indexable; bool? get group; bool? get noindex; int get followersCount; int get followingCount; int get statusesCount; DateTime? get createdAt; DateTime? get lastStatusAt; List<MastodonField> get fields; List<MastodonCustomEmoji> get emojis; MastodonAccount? get moved; bool? get suspended; bool? get limited; bool? get hideCollections; String? get avatarBlurhash; String? get headerBlurhash; String? get avatarDescription; String? get headerDescription; MastodonFeatureApproval? get featureApproval; bool? get showFeatured; bool? get showMedia; bool? get showMediaReplies; List<MastodonRole> get roles;
/// Create a copy of MastodonAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAccountCopyWith<MastodonAccount> get copyWith => _$MastodonAccountCopyWithImpl<MastodonAccount>(this as MastodonAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.acct, acct) || other.acct == acct)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.note, note) || other.note == note)&&(identical(other.url, url) || other.url == url)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarStaticUrl, avatarStaticUrl) || other.avatarStaticUrl == avatarStaticUrl)&&(identical(other.headerUrl, headerUrl) || other.headerUrl == headerUrl)&&(identical(other.headerStaticUrl, headerStaticUrl) || other.headerStaticUrl == headerStaticUrl)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.bot, bot) || other.bot == bot)&&(identical(other.discoverable, discoverable) || other.discoverable == discoverable)&&(identical(other.indexable, indexable) || other.indexable == indexable)&&(identical(other.group, group) || other.group == group)&&(identical(other.noindex, noindex) || other.noindex == noindex)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.statusesCount, statusesCount) || other.statusesCount == statusesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastStatusAt, lastStatusAt) || other.lastStatusAt == lastStatusAt)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.emojis, emojis)&&(identical(other.moved, moved) || other.moved == moved)&&(identical(other.suspended, suspended) || other.suspended == suspended)&&(identical(other.limited, limited) || other.limited == limited)&&(identical(other.hideCollections, hideCollections) || other.hideCollections == hideCollections)&&(identical(other.avatarBlurhash, avatarBlurhash) || other.avatarBlurhash == avatarBlurhash)&&(identical(other.headerBlurhash, headerBlurhash) || other.headerBlurhash == headerBlurhash)&&(identical(other.avatarDescription, avatarDescription) || other.avatarDescription == avatarDescription)&&(identical(other.headerDescription, headerDescription) || other.headerDescription == headerDescription)&&(identical(other.featureApproval, featureApproval) || other.featureApproval == featureApproval)&&(identical(other.showFeatured, showFeatured) || other.showFeatured == showFeatured)&&(identical(other.showMedia, showMedia) || other.showMedia == showMedia)&&(identical(other.showMediaReplies, showMediaReplies) || other.showMediaReplies == showMediaReplies)&&const DeepCollectionEquality().equals(other.roles, roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,username,acct,displayName,note,url,uri,avatarUrl,avatarStaticUrl,headerUrl,headerStaticUrl,locked,bot,discoverable,indexable,group,noindex,followersCount,followingCount,statusesCount,createdAt,lastStatusAt,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(emojis),moved,suspended,limited,hideCollections,avatarBlurhash,headerBlurhash,avatarDescription,headerDescription,featureApproval,showFeatured,showMedia,showMediaReplies,const DeepCollectionEquality().hash(roles)]);

@override
String toString() {
  return 'MastodonAccount(id: $id, username: $username, acct: $acct, displayName: $displayName, note: $note, url: $url, uri: $uri, avatarUrl: $avatarUrl, avatarStaticUrl: $avatarStaticUrl, headerUrl: $headerUrl, headerStaticUrl: $headerStaticUrl, locked: $locked, bot: $bot, discoverable: $discoverable, indexable: $indexable, group: $group, noindex: $noindex, followersCount: $followersCount, followingCount: $followingCount, statusesCount: $statusesCount, createdAt: $createdAt, lastStatusAt: $lastStatusAt, fields: $fields, emojis: $emojis, moved: $moved, suspended: $suspended, limited: $limited, hideCollections: $hideCollections, avatarBlurhash: $avatarBlurhash, headerBlurhash: $headerBlurhash, avatarDescription: $avatarDescription, headerDescription: $headerDescription, featureApproval: $featureApproval, showFeatured: $showFeatured, showMedia: $showMedia, showMediaReplies: $showMediaReplies, roles: $roles)';
}


}

/// @nodoc
abstract mixin class $MastodonAccountCopyWith<$Res>  {
  factory $MastodonAccountCopyWith(MastodonAccount value, $Res Function(MastodonAccount) _then) = _$MastodonAccountCopyWithImpl;
@useResult
$Res call({
 String id, String username, String acct, String displayName, String note, String url, String avatarUrl, String avatarStaticUrl, String headerUrl, String headerStaticUrl, bool locked, bool bot, int followersCount, int followingCount, int statusesCount, List<MastodonField> fields, List<MastodonCustomEmoji> emojis, String? uri, bool? discoverable, bool? indexable, bool? group, bool? noindex, DateTime? createdAt, DateTime? lastStatusAt, MastodonAccount? moved, bool? suspended, bool? limited, bool? hideCollections, String? avatarBlurhash, String? headerBlurhash, String? avatarDescription, String? headerDescription, MastodonFeatureApproval? featureApproval, bool? showFeatured, bool? showMedia, bool? showMediaReplies, List<MastodonRole> roles
});




}
/// @nodoc
class _$MastodonAccountCopyWithImpl<$Res>
    implements $MastodonAccountCopyWith<$Res> {
  _$MastodonAccountCopyWithImpl(this._self, this._then);

  final MastodonAccount _self;
  final $Res Function(MastodonAccount) _then;

/// Create a copy of MastodonAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? acct = null,Object? displayName = null,Object? note = null,Object? url = null,Object? avatarUrl = null,Object? avatarStaticUrl = null,Object? headerUrl = null,Object? headerStaticUrl = null,Object? locked = null,Object? bot = null,Object? followersCount = null,Object? followingCount = null,Object? statusesCount = null,Object? fields = null,Object? emojis = null,Object? uri = freezed,Object? discoverable = freezed,Object? indexable = freezed,Object? group = freezed,Object? noindex = freezed,Object? createdAt = freezed,Object? lastStatusAt = freezed,Object? moved = freezed,Object? suspended = freezed,Object? limited = freezed,Object? hideCollections = freezed,Object? avatarBlurhash = freezed,Object? headerBlurhash = freezed,Object? avatarDescription = freezed,Object? headerDescription = freezed,Object? featureApproval = freezed,Object? showFeatured = freezed,Object? showMedia = freezed,Object? showMediaReplies = freezed,Object? roles = null,}) {
  return _then(MastodonAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,acct: null == acct ? _self.acct : acct // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: null == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String,avatarStaticUrl: null == avatarStaticUrl ? _self.avatarStaticUrl : avatarStaticUrl // ignore: cast_nullable_to_non_nullable
as String,headerUrl: null == headerUrl ? _self.headerUrl : headerUrl // ignore: cast_nullable_to_non_nullable
as String,headerStaticUrl: null == headerStaticUrl ? _self.headerStaticUrl : headerStaticUrl // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,bot: null == bot ? _self.bot : bot // ignore: cast_nullable_to_non_nullable
as bool,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,statusesCount: null == statusesCount ? _self.statusesCount : statusesCount // ignore: cast_nullable_to_non_nullable
as int,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<MastodonField>,emojis: null == emojis ? _self.emojis : emojis // ignore: cast_nullable_to_non_nullable
as List<MastodonCustomEmoji>,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,discoverable: freezed == discoverable ? _self.discoverable : discoverable // ignore: cast_nullable_to_non_nullable
as bool?,indexable: freezed == indexable ? _self.indexable : indexable // ignore: cast_nullable_to_non_nullable
as bool?,group: freezed == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as bool?,noindex: freezed == noindex ? _self.noindex : noindex // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastStatusAt: freezed == lastStatusAt ? _self.lastStatusAt : lastStatusAt // ignore: cast_nullable_to_non_nullable
as DateTime?,moved: freezed == moved ? _self.moved : moved // ignore: cast_nullable_to_non_nullable
as MastodonAccount?,suspended: freezed == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool?,limited: freezed == limited ? _self.limited : limited // ignore: cast_nullable_to_non_nullable
as bool?,hideCollections: freezed == hideCollections ? _self.hideCollections : hideCollections // ignore: cast_nullable_to_non_nullable
as bool?,avatarBlurhash: freezed == avatarBlurhash ? _self.avatarBlurhash : avatarBlurhash // ignore: cast_nullable_to_non_nullable
as String?,headerBlurhash: freezed == headerBlurhash ? _self.headerBlurhash : headerBlurhash // ignore: cast_nullable_to_non_nullable
as String?,avatarDescription: freezed == avatarDescription ? _self.avatarDescription : avatarDescription // ignore: cast_nullable_to_non_nullable
as String?,headerDescription: freezed == headerDescription ? _self.headerDescription : headerDescription // ignore: cast_nullable_to_non_nullable
as String?,featureApproval: freezed == featureApproval ? _self.featureApproval : featureApproval // ignore: cast_nullable_to_non_nullable
as MastodonFeatureApproval?,showFeatured: freezed == showFeatured ? _self.showFeatured : showFeatured // ignore: cast_nullable_to_non_nullable
as bool?,showMedia: freezed == showMedia ? _self.showMedia : showMedia // ignore: cast_nullable_to_non_nullable
as bool?,showMediaReplies: freezed == showMediaReplies ? _self.showMediaReplies : showMediaReplies // ignore: cast_nullable_to_non_nullable
as bool?,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<MastodonRole>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAccount].
extension MastodonAccountPatterns on MastodonAccount {
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
mixin _$MastodonRole {

 String? get id; String get name; String? get permissions; String? get color; bool? get highlighted; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of MastodonRole
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonRoleCopyWith<MastodonRole> get copyWith => _$MastodonRoleCopyWithImpl<MastodonRole>(this as MastodonRole, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonRole&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.permissions, permissions) || other.permissions == permissions)&&(identical(other.color, color) || other.color == color)&&(identical(other.highlighted, highlighted) || other.highlighted == highlighted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,permissions,color,highlighted,createdAt,updatedAt);

@override
String toString() {
  return 'MastodonRole(id: $id, name: $name, permissions: $permissions, color: $color, highlighted: $highlighted, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MastodonRoleCopyWith<$Res>  {
  factory $MastodonRoleCopyWith(MastodonRole value, $Res Function(MastodonRole) _then) = _$MastodonRoleCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String? permissions, String? color, bool? highlighted, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$MastodonRoleCopyWithImpl<$Res>
    implements $MastodonRoleCopyWith<$Res> {
  _$MastodonRoleCopyWithImpl(this._self, this._then);

  final MastodonRole _self;
  final $Res Function(MastodonRole) _then;

/// Create a copy of MastodonRole
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? permissions = freezed,Object? color = freezed,Object? highlighted = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(MastodonRole(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,permissions: freezed == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as String?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,highlighted: freezed == highlighted ? _self.highlighted : highlighted // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonRole].
extension MastodonRolePatterns on MastodonRole {
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
mixin _$MastodonFeatureApproval {

 List<String> get automatic; List<String> get manual; String? get currentUser;
/// Create a copy of MastodonFeatureApproval
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonFeatureApprovalCopyWith<MastodonFeatureApproval> get copyWith => _$MastodonFeatureApprovalCopyWithImpl<MastodonFeatureApproval>(this as MastodonFeatureApproval, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonFeatureApproval&&const DeepCollectionEquality().equals(other.automatic, automatic)&&const DeepCollectionEquality().equals(other.manual, manual)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(automatic),const DeepCollectionEquality().hash(manual),currentUser);

@override
String toString() {
  return 'MastodonFeatureApproval(automatic: $automatic, manual: $manual, currentUser: $currentUser)';
}


}

/// @nodoc
abstract mixin class $MastodonFeatureApprovalCopyWith<$Res>  {
  factory $MastodonFeatureApprovalCopyWith(MastodonFeatureApproval value, $Res Function(MastodonFeatureApproval) _then) = _$MastodonFeatureApprovalCopyWithImpl;
@useResult
$Res call({
 List<String> automatic, List<String> manual, String? currentUser
});




}
/// @nodoc
class _$MastodonFeatureApprovalCopyWithImpl<$Res>
    implements $MastodonFeatureApprovalCopyWith<$Res> {
  _$MastodonFeatureApprovalCopyWithImpl(this._self, this._then);

  final MastodonFeatureApproval _self;
  final $Res Function(MastodonFeatureApproval) _then;

/// Create a copy of MastodonFeatureApproval
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? automatic = null,Object? manual = null,Object? currentUser = freezed,}) {
  return _then(MastodonFeatureApproval(
automatic: null == automatic ? _self.automatic : automatic // ignore: cast_nullable_to_non_nullable
as List<String>,manual: null == manual ? _self.manual : manual // ignore: cast_nullable_to_non_nullable
as List<String>,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonFeatureApproval].
extension MastodonFeatureApprovalPatterns on MastodonFeatureApproval {
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
mixin _$MastodonField {

 String get name; String get value; DateTime? get verifiedAt;
/// Create a copy of MastodonField
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonFieldCopyWith<MastodonField> get copyWith => _$MastodonFieldCopyWithImpl<MastodonField>(this as MastodonField, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonField&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,value,verifiedAt);

@override
String toString() {
  return 'MastodonField(name: $name, value: $value, verifiedAt: $verifiedAt)';
}


}

/// @nodoc
abstract mixin class $MastodonFieldCopyWith<$Res>  {
  factory $MastodonFieldCopyWith(MastodonField value, $Res Function(MastodonField) _then) = _$MastodonFieldCopyWithImpl;
@useResult
$Res call({
 String name, String value, DateTime? verifiedAt
});




}
/// @nodoc
class _$MastodonFieldCopyWithImpl<$Res>
    implements $MastodonFieldCopyWith<$Res> {
  _$MastodonFieldCopyWithImpl(this._self, this._then);

  final MastodonField _self;
  final $Res Function(MastodonField) _then;

/// Create a copy of MastodonField
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? value = null,Object? verifiedAt = freezed,}) {
  return _then(MastodonField(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonField].
extension MastodonFieldPatterns on MastodonField {
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
