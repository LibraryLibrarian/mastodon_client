// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_admin_domain_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAdminDomainBlock {

 String get id; String get domain; String get digest; MastodonAdminDomainBlockSeverity get severity; bool get rejectMedia; bool get rejectReports; String? get privateComment; String? get publicComment; bool get obfuscate; DateTime? get createdAt;
/// Create a copy of MastodonAdminDomainBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminDomainBlockCopyWith<MastodonAdminDomainBlock> get copyWith => _$MastodonAdminDomainBlockCopyWithImpl<MastodonAdminDomainBlock>(this as MastodonAdminDomainBlock, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminDomainBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.digest, digest) || other.digest == digest)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.rejectMedia, rejectMedia) || other.rejectMedia == rejectMedia)&&(identical(other.rejectReports, rejectReports) || other.rejectReports == rejectReports)&&(identical(other.privateComment, privateComment) || other.privateComment == privateComment)&&(identical(other.publicComment, publicComment) || other.publicComment == publicComment)&&(identical(other.obfuscate, obfuscate) || other.obfuscate == obfuscate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,domain,digest,severity,rejectMedia,rejectReports,privateComment,publicComment,obfuscate,createdAt);



}

/// @nodoc
abstract mixin class $MastodonAdminDomainBlockCopyWith<$Res>  {
  factory $MastodonAdminDomainBlockCopyWith(MastodonAdminDomainBlock value, $Res Function(MastodonAdminDomainBlock) _then) = _$MastodonAdminDomainBlockCopyWithImpl;
@useResult
$Res call({
 String id, String domain, String digest, MastodonAdminDomainBlockSeverity severity, bool rejectMedia, bool rejectReports, String? privateComment, String? publicComment, bool obfuscate, DateTime? createdAt
});




}
/// @nodoc
class _$MastodonAdminDomainBlockCopyWithImpl<$Res>
    implements $MastodonAdminDomainBlockCopyWith<$Res> {
  _$MastodonAdminDomainBlockCopyWithImpl(this._self, this._then);

  final MastodonAdminDomainBlock _self;
  final $Res Function(MastodonAdminDomainBlock) _then;

/// Create a copy of MastodonAdminDomainBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? domain = null,Object? digest = null,Object? severity = null,Object? rejectMedia = null,Object? rejectReports = null,Object? privateComment = freezed,Object? publicComment = freezed,Object? obfuscate = null,Object? createdAt = freezed,}) {
  return _then(MastodonAdminDomainBlock(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,digest: null == digest ? _self.digest : digest // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as MastodonAdminDomainBlockSeverity,rejectMedia: null == rejectMedia ? _self.rejectMedia : rejectMedia // ignore: cast_nullable_to_non_nullable
as bool,rejectReports: null == rejectReports ? _self.rejectReports : rejectReports // ignore: cast_nullable_to_non_nullable
as bool,privateComment: freezed == privateComment ? _self.privateComment : privateComment // ignore: cast_nullable_to_non_nullable
as String?,publicComment: freezed == publicComment ? _self.publicComment : publicComment // ignore: cast_nullable_to_non_nullable
as String?,obfuscate: null == obfuscate ? _self.obfuscate : obfuscate // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminDomainBlock].
extension MastodonAdminDomainBlockPatterns on MastodonAdminDomainBlock {
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
