// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_credential_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonCredentialAccount {

 String get id; String get username; String get acct; String get displayName; String get note; String get url; String? get uri; String get avatarUrl; String get avatarStaticUrl; String get headerUrl; String get headerStaticUrl; bool get locked; bool get bot; bool? get discoverable; bool? get indexable; bool? get group; bool? get noindex; int get followersCount; int get followingCount; int get statusesCount; DateTime? get createdAt; DateTime? get lastStatusAt; List<MastodonField> get fields; List<MastodonCustomEmoji> get emojis; MastodonAccount? get moved; bool? get suspended; bool? get limited; bool? get hideCollections; String? get avatarBlurhash; String? get headerBlurhash; String? get avatarDescription; String? get headerDescription; MastodonFeatureApproval? get featureApproval; bool? get showFeatured; bool? get showMedia; bool? get showMediaReplies; List<MastodonRole> get roles; MastodonAccountSource? get source; MastodonRole? get role;
/// Create a copy of MastodonCredentialAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonCredentialAccountCopyWith<MastodonCredentialAccount> get copyWith => _$MastodonCredentialAccountCopyWithImpl<MastodonCredentialAccount>(this as MastodonCredentialAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonCredentialAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.acct, acct) || other.acct == acct)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.note, note) || other.note == note)&&(identical(other.url, url) || other.url == url)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.avatarStaticUrl, avatarStaticUrl) || other.avatarStaticUrl == avatarStaticUrl)&&(identical(other.headerUrl, headerUrl) || other.headerUrl == headerUrl)&&(identical(other.headerStaticUrl, headerStaticUrl) || other.headerStaticUrl == headerStaticUrl)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.bot, bot) || other.bot == bot)&&(identical(other.discoverable, discoverable) || other.discoverable == discoverable)&&(identical(other.indexable, indexable) || other.indexable == indexable)&&(identical(other.group, group) || other.group == group)&&(identical(other.noindex, noindex) || other.noindex == noindex)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.statusesCount, statusesCount) || other.statusesCount == statusesCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastStatusAt, lastStatusAt) || other.lastStatusAt == lastStatusAt)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.emojis, emojis)&&(identical(other.moved, moved) || other.moved == moved)&&(identical(other.suspended, suspended) || other.suspended == suspended)&&(identical(other.limited, limited) || other.limited == limited)&&(identical(other.hideCollections, hideCollections) || other.hideCollections == hideCollections)&&(identical(other.avatarBlurhash, avatarBlurhash) || other.avatarBlurhash == avatarBlurhash)&&(identical(other.headerBlurhash, headerBlurhash) || other.headerBlurhash == headerBlurhash)&&(identical(other.avatarDescription, avatarDescription) || other.avatarDescription == avatarDescription)&&(identical(other.headerDescription, headerDescription) || other.headerDescription == headerDescription)&&(identical(other.featureApproval, featureApproval) || other.featureApproval == featureApproval)&&(identical(other.showFeatured, showFeatured) || other.showFeatured == showFeatured)&&(identical(other.showMedia, showMedia) || other.showMedia == showMedia)&&(identical(other.showMediaReplies, showMediaReplies) || other.showMediaReplies == showMediaReplies)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.source, source) || other.source == source)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,username,acct,displayName,note,url,uri,avatarUrl,avatarStaticUrl,headerUrl,headerStaticUrl,locked,bot,discoverable,indexable,group,noindex,followersCount,followingCount,statusesCount,createdAt,lastStatusAt,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(emojis),moved,suspended,limited,hideCollections,avatarBlurhash,headerBlurhash,avatarDescription,headerDescription,featureApproval,showFeatured,showMedia,showMediaReplies,const DeepCollectionEquality().hash(roles),source,role]);

@override
String toString() {
  return 'MastodonCredentialAccount(id: $id, username: $username, acct: $acct, displayName: $displayName, note: $note, url: $url, uri: $uri, avatarUrl: $avatarUrl, avatarStaticUrl: $avatarStaticUrl, headerUrl: $headerUrl, headerStaticUrl: $headerStaticUrl, locked: $locked, bot: $bot, discoverable: $discoverable, indexable: $indexable, group: $group, noindex: $noindex, followersCount: $followersCount, followingCount: $followingCount, statusesCount: $statusesCount, createdAt: $createdAt, lastStatusAt: $lastStatusAt, fields: $fields, emojis: $emojis, moved: $moved, suspended: $suspended, limited: $limited, hideCollections: $hideCollections, avatarBlurhash: $avatarBlurhash, headerBlurhash: $headerBlurhash, avatarDescription: $avatarDescription, headerDescription: $headerDescription, featureApproval: $featureApproval, showFeatured: $showFeatured, showMedia: $showMedia, showMediaReplies: $showMediaReplies, roles: $roles, source: $source, role: $role)';
}


}

/// @nodoc
abstract mixin class $MastodonCredentialAccountCopyWith<$Res>  {
  factory $MastodonCredentialAccountCopyWith(MastodonCredentialAccount value, $Res Function(MastodonCredentialAccount) _then) = _$MastodonCredentialAccountCopyWithImpl;
@useResult
$Res call({
 String id, String username, String acct, String displayName, String note, String url, String avatarUrl, String avatarStaticUrl, String headerUrl, String headerStaticUrl, bool locked, bool bot, int followersCount, int followingCount, int statusesCount, List<MastodonField> fields, List<MastodonCustomEmoji> emojis, String? uri, bool? discoverable, bool? indexable, bool? group, bool? noindex, DateTime? createdAt, DateTime? lastStatusAt, MastodonAccount? moved, bool? suspended, bool? limited, bool? hideCollections, String? avatarBlurhash, String? headerBlurhash, String? avatarDescription, String? headerDescription, MastodonFeatureApproval? featureApproval, bool? showFeatured, bool? showMedia, bool? showMediaReplies, List<MastodonRole> roles, MastodonAccountSource? source, MastodonRole? role
});




}
/// @nodoc
class _$MastodonCredentialAccountCopyWithImpl<$Res>
    implements $MastodonCredentialAccountCopyWith<$Res> {
  _$MastodonCredentialAccountCopyWithImpl(this._self, this._then);

  final MastodonCredentialAccount _self;
  final $Res Function(MastodonCredentialAccount) _then;

/// Create a copy of MastodonCredentialAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? acct = null,Object? displayName = null,Object? note = null,Object? url = null,Object? avatarUrl = null,Object? avatarStaticUrl = null,Object? headerUrl = null,Object? headerStaticUrl = null,Object? locked = null,Object? bot = null,Object? followersCount = null,Object? followingCount = null,Object? statusesCount = null,Object? fields = null,Object? emojis = null,Object? uri = freezed,Object? discoverable = freezed,Object? indexable = freezed,Object? group = freezed,Object? noindex = freezed,Object? createdAt = freezed,Object? lastStatusAt = freezed,Object? moved = freezed,Object? suspended = freezed,Object? limited = freezed,Object? hideCollections = freezed,Object? avatarBlurhash = freezed,Object? headerBlurhash = freezed,Object? avatarDescription = freezed,Object? headerDescription = freezed,Object? featureApproval = freezed,Object? showFeatured = freezed,Object? showMedia = freezed,Object? showMediaReplies = freezed,Object? roles = null,Object? source = freezed,Object? role = freezed,}) {
  return _then(MastodonCredentialAccount(
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
as List<MastodonRole>,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as MastodonAccountSource?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MastodonRole?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonCredentialAccount].
extension MastodonCredentialAccountPatterns on MastodonCredentialAccount {
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
mixin _$MastodonAccountSource {

 String? get privacy; bool? get sensitive; String? get language; String? get note; List<MastodonField>? get fields; int? get followRequestsCount; String? get quotePolicy;
/// Create a copy of MastodonAccountSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAccountSourceCopyWith<MastodonAccountSource> get copyWith => _$MastodonAccountSourceCopyWithImpl<MastodonAccountSource>(this as MastodonAccountSource, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAccountSource&&(identical(other.privacy, privacy) || other.privacy == privacy)&&(identical(other.sensitive, sensitive) || other.sensitive == sensitive)&&(identical(other.language, language) || other.language == language)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.fields, fields)&&(identical(other.followRequestsCount, followRequestsCount) || other.followRequestsCount == followRequestsCount)&&(identical(other.quotePolicy, quotePolicy) || other.quotePolicy == quotePolicy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,privacy,sensitive,language,note,const DeepCollectionEquality().hash(fields),followRequestsCount,quotePolicy);

@override
String toString() {
  return 'MastodonAccountSource(privacy: $privacy, sensitive: $sensitive, language: $language, note: $note, fields: $fields, followRequestsCount: $followRequestsCount, quotePolicy: $quotePolicy)';
}


}

/// @nodoc
abstract mixin class $MastodonAccountSourceCopyWith<$Res>  {
  factory $MastodonAccountSourceCopyWith(MastodonAccountSource value, $Res Function(MastodonAccountSource) _then) = _$MastodonAccountSourceCopyWithImpl;
@useResult
$Res call({
 String? privacy, bool? sensitive, String? language, String? note, List<MastodonField>? fields, int? followRequestsCount, String? quotePolicy
});




}
/// @nodoc
class _$MastodonAccountSourceCopyWithImpl<$Res>
    implements $MastodonAccountSourceCopyWith<$Res> {
  _$MastodonAccountSourceCopyWithImpl(this._self, this._then);

  final MastodonAccountSource _self;
  final $Res Function(MastodonAccountSource) _then;

/// Create a copy of MastodonAccountSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? privacy = freezed,Object? sensitive = freezed,Object? language = freezed,Object? note = freezed,Object? fields = freezed,Object? followRequestsCount = freezed,Object? quotePolicy = freezed,}) {
  return _then(MastodonAccountSource(
privacy: freezed == privacy ? _self.privacy : privacy // ignore: cast_nullable_to_non_nullable
as String?,sensitive: freezed == sensitive ? _self.sensitive : sensitive // ignore: cast_nullable_to_non_nullable
as bool?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,fields: freezed == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<MastodonField>?,followRequestsCount: freezed == followRequestsCount ? _self.followRequestsCount : followRequestsCount // ignore: cast_nullable_to_non_nullable
as int?,quotePolicy: freezed == quotePolicy ? _self.quotePolicy : quotePolicy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAccountSource].
extension MastodonAccountSourcePatterns on MastodonAccountSource {
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
