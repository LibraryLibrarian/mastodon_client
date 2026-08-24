// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_admin_preview_card_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAdminPreviewCardProvider {

 String get id; String get domain; bool? get trendable; DateTime? get reviewedAt; DateTime? get requestedReviewAt; bool? get requiresReview;
/// Create a copy of MastodonAdminPreviewCardProvider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminPreviewCardProviderCopyWith<MastodonAdminPreviewCardProvider> get copyWith => _$MastodonAdminPreviewCardProviderCopyWithImpl<MastodonAdminPreviewCardProvider>(this as MastodonAdminPreviewCardProvider, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminPreviewCardProvider&&(identical(other.id, id) || other.id == id)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.trendable, trendable) || other.trendable == trendable)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.requestedReviewAt, requestedReviewAt) || other.requestedReviewAt == requestedReviewAt)&&(identical(other.requiresReview, requiresReview) || other.requiresReview == requiresReview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,domain,trendable,reviewedAt,requestedReviewAt,requiresReview);



}

/// @nodoc
abstract mixin class $MastodonAdminPreviewCardProviderCopyWith<$Res>  {
  factory $MastodonAdminPreviewCardProviderCopyWith(MastodonAdminPreviewCardProvider value, $Res Function(MastodonAdminPreviewCardProvider) _then) = _$MastodonAdminPreviewCardProviderCopyWithImpl;
@useResult
$Res call({
 String id, String domain, bool? trendable, DateTime? reviewedAt, DateTime? requestedReviewAt, bool? requiresReview
});




}
/// @nodoc
class _$MastodonAdminPreviewCardProviderCopyWithImpl<$Res>
    implements $MastodonAdminPreviewCardProviderCopyWith<$Res> {
  _$MastodonAdminPreviewCardProviderCopyWithImpl(this._self, this._then);

  final MastodonAdminPreviewCardProvider _self;
  final $Res Function(MastodonAdminPreviewCardProvider) _then;

/// Create a copy of MastodonAdminPreviewCardProvider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? domain = null,Object? trendable = freezed,Object? reviewedAt = freezed,Object? requestedReviewAt = freezed,Object? requiresReview = freezed,}) {
  return _then(MastodonAdminPreviewCardProvider(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,trendable: freezed == trendable ? _self.trendable : trendable // ignore: cast_nullable_to_non_nullable
as bool?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,requestedReviewAt: freezed == requestedReviewAt ? _self.requestedReviewAt : requestedReviewAt // ignore: cast_nullable_to_non_nullable
as DateTime?,requiresReview: freezed == requiresReview ? _self.requiresReview : requiresReview // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminPreviewCardProvider].
extension MastodonAdminPreviewCardProviderPatterns on MastodonAdminPreviewCardProvider {
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
