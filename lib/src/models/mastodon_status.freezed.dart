// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonMention {

 String get id; String get username; String get acct; String get url;
/// Create a copy of MastodonMention
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonMentionCopyWith<MastodonMention> get copyWith => _$MastodonMentionCopyWithImpl<MastodonMention>(this as MastodonMention, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonMention&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.acct, acct) || other.acct == acct)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,acct,url);



}

/// @nodoc
abstract mixin class $MastodonMentionCopyWith<$Res>  {
  factory $MastodonMentionCopyWith(MastodonMention value, $Res Function(MastodonMention) _then) = _$MastodonMentionCopyWithImpl;
@useResult
$Res call({
 String id, String username, String acct, String url
});




}
/// @nodoc
class _$MastodonMentionCopyWithImpl<$Res>
    implements $MastodonMentionCopyWith<$Res> {
  _$MastodonMentionCopyWithImpl(this._self, this._then);

  final MastodonMention _self;
  final $Res Function(MastodonMention) _then;

/// Create a copy of MastodonMention
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? acct = null,Object? url = null,}) {
  return _then(MastodonMention(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,acct: null == acct ? _self.acct : acct // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonMention].
extension MastodonMentionPatterns on MastodonMention {
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
mixin _$MastodonStatus {

 String get id; String? get uri; String? get url; DateTime get createdAt; String? get inReplyToId; String? get inReplyToAccountId; bool get sensitive; String get spoilerText; MastodonVisibility get visibility; String? get language; String get content; String? get text; DateTime? get editedAt; int get reblogsCount; int get favouritesCount; int get repliesCount; int get quotesCount; bool? get favourited; bool? get reblogged; bool? get bookmarked; bool? get muted; bool? get pinned; MastodonAccount get account; List<MastodonMediaAttachment> get mediaAttachments; List<MastodonMention> get mentions; List<MastodonTag> get tags; List<MastodonCustomEmoji> get emojis; MastodonStatus? get reblog; MastodonPoll? get poll; MastodonStatus? get quote; MastodonPreviewCard? get card; MastodonStatusApplication? get application; List<MastodonFilterResult> get filtered; MastodonQuoteApproval? get quoteApproval; List<MastodonCollection> get taggedCollections;
/// Create a copy of MastodonStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonStatusCopyWith<MastodonStatus> get copyWith => _$MastodonStatusCopyWithImpl<MastodonStatus>(this as MastodonStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.url, url) || other.url == url)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.inReplyToId, inReplyToId) || other.inReplyToId == inReplyToId)&&(identical(other.inReplyToAccountId, inReplyToAccountId) || other.inReplyToAccountId == inReplyToAccountId)&&(identical(other.sensitive, sensitive) || other.sensitive == sensitive)&&(identical(other.spoilerText, spoilerText) || other.spoilerText == spoilerText)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.language, language) || other.language == language)&&(identical(other.content, content) || other.content == content)&&(identical(other.text, text) || other.text == text)&&(identical(other.editedAt, editedAt) || other.editedAt == editedAt)&&(identical(other.reblogsCount, reblogsCount) || other.reblogsCount == reblogsCount)&&(identical(other.favouritesCount, favouritesCount) || other.favouritesCount == favouritesCount)&&(identical(other.repliesCount, repliesCount) || other.repliesCount == repliesCount)&&(identical(other.quotesCount, quotesCount) || other.quotesCount == quotesCount)&&(identical(other.favourited, favourited) || other.favourited == favourited)&&(identical(other.reblogged, reblogged) || other.reblogged == reblogged)&&(identical(other.bookmarked, bookmarked) || other.bookmarked == bookmarked)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.pinned, pinned) || other.pinned == pinned)&&(identical(other.account, account) || other.account == account)&&const DeepCollectionEquality().equals(other.mediaAttachments, mediaAttachments)&&const DeepCollectionEquality().equals(other.mentions, mentions)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.emojis, emojis)&&(identical(other.reblog, reblog) || other.reblog == reblog)&&(identical(other.poll, poll) || other.poll == poll)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.card, card) || other.card == card)&&(identical(other.application, application) || other.application == application)&&const DeepCollectionEquality().equals(other.filtered, filtered)&&(identical(other.quoteApproval, quoteApproval) || other.quoteApproval == quoteApproval)&&const DeepCollectionEquality().equals(other.taggedCollections, taggedCollections));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,uri,url,createdAt,inReplyToId,inReplyToAccountId,sensitive,spoilerText,visibility,language,content,text,editedAt,reblogsCount,favouritesCount,repliesCount,quotesCount,favourited,reblogged,bookmarked,muted,pinned,account,const DeepCollectionEquality().hash(mediaAttachments),const DeepCollectionEquality().hash(mentions),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(emojis),reblog,poll,quote,card,application,const DeepCollectionEquality().hash(filtered),quoteApproval,const DeepCollectionEquality().hash(taggedCollections)]);



}

/// @nodoc
abstract mixin class $MastodonStatusCopyWith<$Res>  {
  factory $MastodonStatusCopyWith(MastodonStatus value, $Res Function(MastodonStatus) _then) = _$MastodonStatusCopyWithImpl;
@useResult
$Res call({
 String id, DateTime createdAt, bool sensitive, String spoilerText, MastodonVisibility visibility, String content, int reblogsCount, int favouritesCount, int repliesCount, MastodonAccount account, List<MastodonMediaAttachment> mediaAttachments, List<MastodonMention> mentions, List<MastodonTag> tags, List<MastodonCustomEmoji> emojis, String? uri, String? url, String? inReplyToId, String? inReplyToAccountId, String? language, String? text, DateTime? editedAt, bool? favourited, bool? reblogged, bool? bookmarked, bool? muted, bool? pinned, MastodonStatus? reblog, MastodonPoll? poll, MastodonStatus? quote, MastodonPreviewCard? card, MastodonStatusApplication? application, MastodonQuoteApproval? quoteApproval, int quotesCount, List<MastodonFilterResult> filtered, List<MastodonCollection> taggedCollections
});




}
/// @nodoc
class _$MastodonStatusCopyWithImpl<$Res>
    implements $MastodonStatusCopyWith<$Res> {
  _$MastodonStatusCopyWithImpl(this._self, this._then);

  final MastodonStatus _self;
  final $Res Function(MastodonStatus) _then;

/// Create a copy of MastodonStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? createdAt = null,Object? sensitive = null,Object? spoilerText = null,Object? visibility = null,Object? content = null,Object? reblogsCount = null,Object? favouritesCount = null,Object? repliesCount = null,Object? account = null,Object? mediaAttachments = null,Object? mentions = null,Object? tags = null,Object? emojis = null,Object? uri = freezed,Object? url = freezed,Object? inReplyToId = freezed,Object? inReplyToAccountId = freezed,Object? language = freezed,Object? text = freezed,Object? editedAt = freezed,Object? favourited = freezed,Object? reblogged = freezed,Object? bookmarked = freezed,Object? muted = freezed,Object? pinned = freezed,Object? reblog = freezed,Object? poll = freezed,Object? quote = freezed,Object? card = freezed,Object? application = freezed,Object? quoteApproval = freezed,Object? quotesCount = null,Object? filtered = null,Object? taggedCollections = null,}) {
  return _then(MastodonStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sensitive: null == sensitive ? _self.sensitive : sensitive // ignore: cast_nullable_to_non_nullable
as bool,spoilerText: null == spoilerText ? _self.spoilerText : spoilerText // ignore: cast_nullable_to_non_nullable
as String,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as MastodonVisibility,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,reblogsCount: null == reblogsCount ? _self.reblogsCount : reblogsCount // ignore: cast_nullable_to_non_nullable
as int,favouritesCount: null == favouritesCount ? _self.favouritesCount : favouritesCount // ignore: cast_nullable_to_non_nullable
as int,repliesCount: null == repliesCount ? _self.repliesCount : repliesCount // ignore: cast_nullable_to_non_nullable
as int,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MastodonAccount,mediaAttachments: null == mediaAttachments ? _self.mediaAttachments : mediaAttachments // ignore: cast_nullable_to_non_nullable
as List<MastodonMediaAttachment>,mentions: null == mentions ? _self.mentions : mentions // ignore: cast_nullable_to_non_nullable
as List<MastodonMention>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<MastodonTag>,emojis: null == emojis ? _self.emojis : emojis // ignore: cast_nullable_to_non_nullable
as List<MastodonCustomEmoji>,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,inReplyToId: freezed == inReplyToId ? _self.inReplyToId : inReplyToId // ignore: cast_nullable_to_non_nullable
as String?,inReplyToAccountId: freezed == inReplyToAccountId ? _self.inReplyToAccountId : inReplyToAccountId // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,editedAt: freezed == editedAt ? _self.editedAt : editedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,favourited: freezed == favourited ? _self.favourited : favourited // ignore: cast_nullable_to_non_nullable
as bool?,reblogged: freezed == reblogged ? _self.reblogged : reblogged // ignore: cast_nullable_to_non_nullable
as bool?,bookmarked: freezed == bookmarked ? _self.bookmarked : bookmarked // ignore: cast_nullable_to_non_nullable
as bool?,muted: freezed == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool?,pinned: freezed == pinned ? _self.pinned : pinned // ignore: cast_nullable_to_non_nullable
as bool?,reblog: freezed == reblog ? _self.reblog : reblog // ignore: cast_nullable_to_non_nullable
as MastodonStatus?,poll: freezed == poll ? _self.poll : poll // ignore: cast_nullable_to_non_nullable
as MastodonPoll?,quote: freezed == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as MastodonStatus?,card: freezed == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as MastodonPreviewCard?,application: freezed == application ? _self.application : application // ignore: cast_nullable_to_non_nullable
as MastodonStatusApplication?,quoteApproval: freezed == quoteApproval ? _self.quoteApproval : quoteApproval // ignore: cast_nullable_to_non_nullable
as MastodonQuoteApproval?,quotesCount: null == quotesCount ? _self.quotesCount : quotesCount // ignore: cast_nullable_to_non_nullable
as int,filtered: null == filtered ? _self.filtered : filtered // ignore: cast_nullable_to_non_nullable
as List<MastodonFilterResult>,taggedCollections: null == taggedCollections ? _self.taggedCollections : taggedCollections // ignore: cast_nullable_to_non_nullable
as List<MastodonCollection>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonStatus].
extension MastodonStatusPatterns on MastodonStatus {
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
mixin _$MastodonStatusApplication {

 String get name; String? get website;
/// Create a copy of MastodonStatusApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonStatusApplicationCopyWith<MastodonStatusApplication> get copyWith => _$MastodonStatusApplicationCopyWithImpl<MastodonStatusApplication>(this as MastodonStatusApplication, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonStatusApplication&&(identical(other.name, name) || other.name == name)&&(identical(other.website, website) || other.website == website));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,website);



}

/// @nodoc
abstract mixin class $MastodonStatusApplicationCopyWith<$Res>  {
  factory $MastodonStatusApplicationCopyWith(MastodonStatusApplication value, $Res Function(MastodonStatusApplication) _then) = _$MastodonStatusApplicationCopyWithImpl;
@useResult
$Res call({
 String name, String? website
});




}
/// @nodoc
class _$MastodonStatusApplicationCopyWithImpl<$Res>
    implements $MastodonStatusApplicationCopyWith<$Res> {
  _$MastodonStatusApplicationCopyWithImpl(this._self, this._then);

  final MastodonStatusApplication _self;
  final $Res Function(MastodonStatusApplication) _then;

/// Create a copy of MastodonStatusApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? website = freezed,}) {
  return _then(MastodonStatusApplication(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonStatusApplication].
extension MastodonStatusApplicationPatterns on MastodonStatusApplication {
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
mixin _$MastodonQuoteApproval {

 List<String> get automatic; List<String> get manual; String? get currentUser;
/// Create a copy of MastodonQuoteApproval
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonQuoteApprovalCopyWith<MastodonQuoteApproval> get copyWith => _$MastodonQuoteApprovalCopyWithImpl<MastodonQuoteApproval>(this as MastodonQuoteApproval, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonQuoteApproval&&const DeepCollectionEquality().equals(other.automatic, automatic)&&const DeepCollectionEquality().equals(other.manual, manual)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(automatic),const DeepCollectionEquality().hash(manual),currentUser);



}

/// @nodoc
abstract mixin class $MastodonQuoteApprovalCopyWith<$Res>  {
  factory $MastodonQuoteApprovalCopyWith(MastodonQuoteApproval value, $Res Function(MastodonQuoteApproval) _then) = _$MastodonQuoteApprovalCopyWithImpl;
@useResult
$Res call({
 List<String> automatic, List<String> manual, String? currentUser
});




}
/// @nodoc
class _$MastodonQuoteApprovalCopyWithImpl<$Res>
    implements $MastodonQuoteApprovalCopyWith<$Res> {
  _$MastodonQuoteApprovalCopyWithImpl(this._self, this._then);

  final MastodonQuoteApproval _self;
  final $Res Function(MastodonQuoteApproval) _then;

/// Create a copy of MastodonQuoteApproval
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? automatic = null,Object? manual = null,Object? currentUser = freezed,}) {
  return _then(MastodonQuoteApproval(
automatic: null == automatic ? _self.automatic : automatic // ignore: cast_nullable_to_non_nullable
as List<String>,manual: null == manual ? _self.manual : manual // ignore: cast_nullable_to_non_nullable
as List<String>,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonQuoteApproval].
extension MastodonQuoteApprovalPatterns on MastodonQuoteApproval {
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
