// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mastodon_admin_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MastodonAdminAccount {

 String get id; String get username; String? get domain; DateTime? get createdAt; String? get email; String? get ip; List<MastodonAdminIp> get ips; String? get locale; String? get inviteRequest; MastodonAdminRole? get role; bool get confirmed; bool get approved; bool get disabled; bool get sensitized; bool get silenced; bool get suspended; MastodonAccount? get account; String? get createdByApplicationId; String? get invitedByAccountId;
/// Create a copy of MastodonAdminAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminAccountCopyWith<MastodonAdminAccount> get copyWith => _$MastodonAdminAccountCopyWithImpl<MastodonAdminAccount>(this as MastodonAdminAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.domain, domain) || other.domain == domain)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.email, email) || other.email == email)&&(identical(other.ip, ip) || other.ip == ip)&&const DeepCollectionEquality().equals(other.ips, ips)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.inviteRequest, inviteRequest) || other.inviteRequest == inviteRequest)&&(identical(other.role, role) || other.role == role)&&(identical(other.confirmed, confirmed) || other.confirmed == confirmed)&&(identical(other.approved, approved) || other.approved == approved)&&(identical(other.disabled, disabled) || other.disabled == disabled)&&(identical(other.sensitized, sensitized) || other.sensitized == sensitized)&&(identical(other.silenced, silenced) || other.silenced == silenced)&&(identical(other.suspended, suspended) || other.suspended == suspended)&&(identical(other.account, account) || other.account == account)&&(identical(other.createdByApplicationId, createdByApplicationId) || other.createdByApplicationId == createdByApplicationId)&&(identical(other.invitedByAccountId, invitedByAccountId) || other.invitedByAccountId == invitedByAccountId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,username,domain,createdAt,email,ip,const DeepCollectionEquality().hash(ips),locale,inviteRequest,role,confirmed,approved,disabled,sensitized,silenced,suspended,account,createdByApplicationId,invitedByAccountId]);



}

/// @nodoc
abstract mixin class $MastodonAdminAccountCopyWith<$Res>  {
  factory $MastodonAdminAccountCopyWith(MastodonAdminAccount value, $Res Function(MastodonAdminAccount) _then) = _$MastodonAdminAccountCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? domain, DateTime? createdAt, String? email, String? ip, List<MastodonAdminIp> ips, String? locale, String? inviteRequest, MastodonAdminRole? role, bool confirmed, bool approved, bool disabled, bool sensitized, bool silenced, bool suspended, MastodonAccount? account, String? createdByApplicationId, String? invitedByAccountId
});




}
/// @nodoc
class _$MastodonAdminAccountCopyWithImpl<$Res>
    implements $MastodonAdminAccountCopyWith<$Res> {
  _$MastodonAdminAccountCopyWithImpl(this._self, this._then);

  final MastodonAdminAccount _self;
  final $Res Function(MastodonAdminAccount) _then;

/// Create a copy of MastodonAdminAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? domain = freezed,Object? createdAt = freezed,Object? email = freezed,Object? ip = freezed,Object? ips = null,Object? locale = freezed,Object? inviteRequest = freezed,Object? role = freezed,Object? confirmed = null,Object? approved = null,Object? disabled = null,Object? sensitized = null,Object? silenced = null,Object? suspended = null,Object? account = freezed,Object? createdByApplicationId = freezed,Object? invitedByAccountId = freezed,}) {
  return _then(MastodonAdminAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,domain: freezed == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,ips: null == ips ? _self.ips : ips // ignore: cast_nullable_to_non_nullable
as List<MastodonAdminIp>,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,inviteRequest: freezed == inviteRequest ? _self.inviteRequest : inviteRequest // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as MastodonAdminRole?,confirmed: null == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as bool,approved: null == approved ? _self.approved : approved // ignore: cast_nullable_to_non_nullable
as bool,disabled: null == disabled ? _self.disabled : disabled // ignore: cast_nullable_to_non_nullable
as bool,sensitized: null == sensitized ? _self.sensitized : sensitized // ignore: cast_nullable_to_non_nullable
as bool,silenced: null == silenced ? _self.silenced : silenced // ignore: cast_nullable_to_non_nullable
as bool,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,account: freezed == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as MastodonAccount?,createdByApplicationId: freezed == createdByApplicationId ? _self.createdByApplicationId : createdByApplicationId // ignore: cast_nullable_to_non_nullable
as String?,invitedByAccountId: freezed == invitedByAccountId ? _self.invitedByAccountId : invitedByAccountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminAccount].
extension MastodonAdminAccountPatterns on MastodonAdminAccount {
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
mixin _$MastodonAdminIp {

 String get ip; DateTime? get usedAt;
/// Create a copy of MastodonAdminIp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminIpCopyWith<MastodonAdminIp> get copyWith => _$MastodonAdminIpCopyWithImpl<MastodonAdminIp>(this as MastodonAdminIp, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminIp&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.usedAt, usedAt) || other.usedAt == usedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ip,usedAt);



}

/// @nodoc
abstract mixin class $MastodonAdminIpCopyWith<$Res>  {
  factory $MastodonAdminIpCopyWith(MastodonAdminIp value, $Res Function(MastodonAdminIp) _then) = _$MastodonAdminIpCopyWithImpl;
@useResult
$Res call({
 String ip, DateTime? usedAt
});




}
/// @nodoc
class _$MastodonAdminIpCopyWithImpl<$Res>
    implements $MastodonAdminIpCopyWith<$Res> {
  _$MastodonAdminIpCopyWithImpl(this._self, this._then);

  final MastodonAdminIp _self;
  final $Res Function(MastodonAdminIp) _then;

/// Create a copy of MastodonAdminIp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ip = null,Object? usedAt = freezed,}) {
  return _then(MastodonAdminIp(
ip: null == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String,usedAt: freezed == usedAt ? _self.usedAt : usedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminIp].
extension MastodonAdminIpPatterns on MastodonAdminIp {
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
mixin _$MastodonAdminRole {

 String? get id; String get name; String? get color; int? get position; String? get permissions; bool get highlighted; DateTime? get createdAt; DateTime? get updatedAt; int? get collectionLimit;
/// Create a copy of MastodonAdminRole
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MastodonAdminRoleCopyWith<MastodonAdminRole> get copyWith => _$MastodonAdminRoleCopyWithImpl<MastodonAdminRole>(this as MastodonAdminRole, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MastodonAdminRole&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color)&&(identical(other.position, position) || other.position == position)&&(identical(other.permissions, permissions) || other.permissions == permissions)&&(identical(other.highlighted, highlighted) || other.highlighted == highlighted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.collectionLimit, collectionLimit) || other.collectionLimit == collectionLimit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,color,position,permissions,highlighted,createdAt,updatedAt,collectionLimit);



}

/// @nodoc
abstract mixin class $MastodonAdminRoleCopyWith<$Res>  {
  factory $MastodonAdminRoleCopyWith(MastodonAdminRole value, $Res Function(MastodonAdminRole) _then) = _$MastodonAdminRoleCopyWithImpl;
@useResult
$Res call({
 String? id, String name, String? color, int? position, String? permissions, bool highlighted, DateTime? createdAt, DateTime? updatedAt, int? collectionLimit
});




}
/// @nodoc
class _$MastodonAdminRoleCopyWithImpl<$Res>
    implements $MastodonAdminRoleCopyWith<$Res> {
  _$MastodonAdminRoleCopyWithImpl(this._self, this._then);

  final MastodonAdminRole _self;
  final $Res Function(MastodonAdminRole) _then;

/// Create a copy of MastodonAdminRole
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = null,Object? color = freezed,Object? position = freezed,Object? permissions = freezed,Object? highlighted = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? collectionLimit = freezed,}) {
  return _then(MastodonAdminRole(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int?,permissions: freezed == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as String?,highlighted: null == highlighted ? _self.highlighted : highlighted // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,collectionLimit: freezed == collectionLimit ? _self.collectionLimit : collectionLimit // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MastodonAdminRole].
extension MastodonAdminRolePatterns on MastodonAdminRole {
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
