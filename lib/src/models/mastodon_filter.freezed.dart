// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonFilter {

 String get id; String get title; List<String> get context; DateTime? get expiresAt; MastodonFilterAction get filterAction; List<MastodonFilterKeyword> get keywords; List<MastodonFilterStatus> get statuses;
/// Create a copy of MastodonFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonFilterCopyWith<MastodonFilter> get copyWith => _$MastodonFilterCopyWithImpl<MastodonFilter>(this as MastodonFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonFilter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.context, context)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.filterAction, filterAction) || other.filterAction == filterAction)&&const DeepCollectionEquality().equals(other.keywords, keywords)&&const DeepCollectionEquality().equals(other.statuses, statuses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(context),expiresAt,filterAction,const DeepCollectionEquality().hash(keywords),const DeepCollectionEquality().hash(statuses));



}

/// @nodoc
abstract mixin class $MastodonFilterCopyWith<$Res>  {
  factory $MastodonFilterCopyWith(MastodonFilter value, $Res Function(MastodonFilter) _then) = _$MastodonFilterCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<String> context, MastodonFilterAction filterAction, List<MastodonFilterKeyword> keywords, List<MastodonFilterStatus> statuses, DateTime? expiresAt
});




}
/// @nodoc
class _$MastodonFilterCopyWithImpl<$Res>
    implements $MastodonFilterCopyWith<$Res> {
  _$MastodonFilterCopyWithImpl(this._self, this._then);

  final MastodonFilter _self;
  final $Res Function(MastodonFilter) _then;

/// Create a copy of MastodonFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? context = null,Object? filterAction = null,Object? keywords = null,Object? statuses = null,Object? expiresAt = freezed,}) {
  return _then(MastodonFilter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as List<String>,filterAction: null == filterAction ? _self.filterAction : filterAction // ignore: cast_nullable_to_non_nullable
as MastodonFilterAction,keywords: null == keywords ? _self.keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<MastodonFilterKeyword>,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<MastodonFilterStatus>,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonFilter].
extension MastodonFilterPatterns on MastodonFilter {
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
mixin _$MastodonFilterKeyword {

 String get id; String get keyword; bool get wholeWord;
/// Create a copy of MastodonFilterKeyword
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonFilterKeywordCopyWith<MastodonFilterKeyword> get copyWith => _$MastodonFilterKeywordCopyWithImpl<MastodonFilterKeyword>(this as MastodonFilterKeyword, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonFilterKeyword&&(identical(other.id, id) || other.id == id)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.wholeWord, wholeWord) || other.wholeWord == wholeWord));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,keyword,wholeWord);



}

/// @nodoc
abstract mixin class $MastodonFilterKeywordCopyWith<$Res>  {
  factory $MastodonFilterKeywordCopyWith(MastodonFilterKeyword value, $Res Function(MastodonFilterKeyword) _then) = _$MastodonFilterKeywordCopyWithImpl;
@useResult
$Res call({
 String id, String keyword, bool wholeWord
});




}
/// @nodoc
class _$MastodonFilterKeywordCopyWithImpl<$Res>
    implements $MastodonFilterKeywordCopyWith<$Res> {
  _$MastodonFilterKeywordCopyWithImpl(this._self, this._then);

  final MastodonFilterKeyword _self;
  final $Res Function(MastodonFilterKeyword) _then;

/// Create a copy of MastodonFilterKeyword
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? keyword = null,Object? wholeWord = null,}) {
  return _then(MastodonFilterKeyword(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,keyword: null == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String,wholeWord: null == wholeWord ? _self.wholeWord : wholeWord // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonFilterKeyword].
extension MastodonFilterKeywordPatterns on MastodonFilterKeyword {
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
mixin _$MastodonFilterStatus {

 String get id; String get statusId;
/// Create a copy of MastodonFilterStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonFilterStatusCopyWith<MastodonFilterStatus> get copyWith => _$MastodonFilterStatusCopyWithImpl<MastodonFilterStatus>(this as MastodonFilterStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonFilterStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.statusId, statusId) || other.statusId == statusId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,statusId);



}

/// @nodoc
abstract mixin class $MastodonFilterStatusCopyWith<$Res>  {
  factory $MastodonFilterStatusCopyWith(MastodonFilterStatus value, $Res Function(MastodonFilterStatus) _then) = _$MastodonFilterStatusCopyWithImpl;
@useResult
$Res call({
 String id, String statusId
});




}
/// @nodoc
class _$MastodonFilterStatusCopyWithImpl<$Res>
    implements $MastodonFilterStatusCopyWith<$Res> {
  _$MastodonFilterStatusCopyWithImpl(this._self, this._then);

  final MastodonFilterStatus _self;
  final $Res Function(MastodonFilterStatus) _then;

/// Create a copy of MastodonFilterStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? statusId = null,}) {
  return _then(MastodonFilterStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,statusId: null == statusId ? _self.statusId : statusId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonFilterStatus].
extension MastodonFilterStatusPatterns on MastodonFilterStatus {
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
mixin _$MastodonFilterV1 {

 String get id; String get phrase; List<String> get context; DateTime? get expiresAt; bool get irreversible; bool get wholeWord;
/// Create a copy of MastodonFilterV1
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonFilterV1CopyWith<MastodonFilterV1> get copyWith => _$MastodonFilterV1CopyWithImpl<MastodonFilterV1>(this as MastodonFilterV1, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonFilterV1&&(identical(other.id, id) || other.id == id)&&(identical(other.phrase, phrase) || other.phrase == phrase)&&const DeepCollectionEquality().equals(other.context, context)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.irreversible, irreversible) || other.irreversible == irreversible)&&(identical(other.wholeWord, wholeWord) || other.wholeWord == wholeWord));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phrase,const DeepCollectionEquality().hash(context),expiresAt,irreversible,wholeWord);



}

/// @nodoc
abstract mixin class $MastodonFilterV1CopyWith<$Res>  {
  factory $MastodonFilterV1CopyWith(MastodonFilterV1 value, $Res Function(MastodonFilterV1) _then) = _$MastodonFilterV1CopyWithImpl;
@useResult
$Res call({
 String id, String phrase, List<String> context, bool irreversible, bool wholeWord, DateTime? expiresAt
});




}
/// @nodoc
class _$MastodonFilterV1CopyWithImpl<$Res>
    implements $MastodonFilterV1CopyWith<$Res> {
  _$MastodonFilterV1CopyWithImpl(this._self, this._then);

  final MastodonFilterV1 _self;
  final $Res Function(MastodonFilterV1) _then;

/// Create a copy of MastodonFilterV1
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phrase = null,Object? context = null,Object? irreversible = null,Object? wholeWord = null,Object? expiresAt = freezed,}) {
  return _then(MastodonFilterV1(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phrase: null == phrase ? _self.phrase : phrase // ignore: cast_nullable_to_non_nullable
as String,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as List<String>,irreversible: null == irreversible ? _self.irreversible : irreversible // ignore: cast_nullable_to_non_nullable
as bool,wholeWord: null == wholeWord ? _self.wholeWord : wholeWord // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonFilterV1].
extension MastodonFilterV1Patterns on MastodonFilterV1 {
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
mixin _$MastodonFilterResult {

 MastodonFilter get filter; List<String> get keywordMatches; List<String> get statusMatches;
/// Create a copy of MastodonFilterResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonFilterResultCopyWith<MastodonFilterResult> get copyWith => _$MastodonFilterResultCopyWithImpl<MastodonFilterResult>(this as MastodonFilterResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonFilterResult&&(identical(other.filter, filter) || other.filter == filter)&&const DeepCollectionEquality().equals(other.keywordMatches, keywordMatches)&&const DeepCollectionEquality().equals(other.statusMatches, statusMatches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filter,const DeepCollectionEquality().hash(keywordMatches),const DeepCollectionEquality().hash(statusMatches));



}

/// @nodoc
abstract mixin class $MastodonFilterResultCopyWith<$Res>  {
  factory $MastodonFilterResultCopyWith(MastodonFilterResult value, $Res Function(MastodonFilterResult) _then) = _$MastodonFilterResultCopyWithImpl;
@useResult
$Res call({
 MastodonFilter filter, List<String> keywordMatches, List<String> statusMatches
});




}
/// @nodoc
class _$MastodonFilterResultCopyWithImpl<$Res>
    implements $MastodonFilterResultCopyWith<$Res> {
  _$MastodonFilterResultCopyWithImpl(this._self, this._then);

  final MastodonFilterResult _self;
  final $Res Function(MastodonFilterResult) _then;

/// Create a copy of MastodonFilterResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filter = null,Object? keywordMatches = null,Object? statusMatches = null,}) {
  return _then(MastodonFilterResult(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as MastodonFilter,keywordMatches: null == keywordMatches ? _self.keywordMatches : keywordMatches // ignore: cast_nullable_to_non_nullable
as List<String>,statusMatches: null == statusMatches ? _self.statusMatches : statusMatches // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonFilterResult].
extension MastodonFilterResultPatterns on MastodonFilterResult {
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
