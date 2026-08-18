import 'package:freezed_annotation/freezed_annotation.dart';
import '../json_converters.dart';
import '../mastodon_account.dart';

part 'mastodon_admin_account.freezed.dart';
part 'mastodon_admin_account.g.dart';

/// Admin-level account information.
///
/// Account information returned by the Admin API responses.
/// Includes additional admin-specific details beyond the standard
/// [MastodonAccount].
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminAccount with _$MastodonAdminAccount {
  const MastodonAdminAccount({
    required this.id,
    required this.username,
    this.domain,
    this.createdAt,
    this.email,
    this.ip,
    this.ips = const [],
    this.locale,
    this.inviteRequest,
    this.role,
    this.confirmed = false,
    this.approved = false,
    this.disabled = false,
    this.sensitized = false,
    this.silenced = false,
    this.suspended = false,
    this.account,
    this.createdByApplicationId,
    this.invitedByAccountId,
  });

  factory MastodonAdminAccount.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminAccountFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminAccountToJson(this);

  /// Database ID of the account.
  @override
  final String id;

  /// Username of the account.
  @override
  final String username;

  /// Domain of the account (null for local accounts).
  @override
  final String? domain;

  /// Timestamp when the account was created.
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;

  /// Email address associated with the account.
  @JsonKey(defaultValue: '')
  @override
  final String? email;

  /// IP address last used for login.
  @override
  final String? ip;

  /// History of all IP addresses associated with this account.
  @JsonKey(defaultValue: <MastodonAdminIp>[])
  @override
  final List<MastodonAdminIp> ips;

  /// Locale of the account (ISO 639-1 language code).
  @override
  final String? locale;

  /// Reason provided when requesting an invite.
  @override
  final String? inviteRequest;

  /// Current role of the account.
  @JsonKey(fromJson: adminRoleFromJson)
  @override
  final MastodonAdminRole? role;

  /// Whether the email address has been confirmed.
  @JsonKey(defaultValue: false)
  @override
  final bool confirmed;

  /// Whether the account has been approved.
  @JsonKey(defaultValue: false)
  @override
  final bool approved;

  /// Whether the account has been disabled.
  @JsonKey(defaultValue: false)
  @override
  final bool disabled;

  /// Whether the account has been marked as sensitive.
  @JsonKey(defaultValue: false)
  @override
  final bool sensitized;

  /// Whether the account has been silenced.
  @JsonKey(defaultValue: false)
  @override
  final bool silenced;

  /// Whether the account has been suspended.
  @JsonKey(defaultValue: false)
  @override
  final bool suspended;

  /// User-level account information.
  @override
  final MastodonAccount? account;

  /// ID of the application that created this account.
  @override
  final String? createdByApplicationId;

  /// ID of the account that invited this user.
  @override
  final String? invitedByAccountId;
}

/// Admin-level IP address information.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminIp with _$MastodonAdminIp {
  const MastodonAdminIp({required this.ip, this.usedAt});

  factory MastodonAdminIp.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminIpFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminIpToJson(this);

  /// IP address.
  @override
  final String ip;

  /// Timestamp when this IP address was last used.
  @SafeDateTimeConverter()
  @override
  final DateTime? usedAt;
}

/// Admin-level role information.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminRole with _$MastodonAdminRole {
  const MastodonAdminRole({
    this.id,
    required this.name,
    this.color,
    this.position,
    this.permissions,
    this.highlighted = false,
    this.createdAt,
    this.updatedAt,
    this.collectionLimit,
  });

  factory MastodonAdminRole.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminRoleFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminRoleToJson(this);

  /// ID of the role.
  @JsonKey(fromJson: flexibleIdFromJson)
  @override
  final String? id;

  /// Name of the role.
  @override
  final String name;

  /// Color code of the role.
  @JsonKey(defaultValue: '')
  @override
  final String? color;

  /// Priority of the role.
  @override
  final int? position;

  /// Permission bitmask of the role.
  @override
  final String? permissions;

  /// Whether to display the role as a badge.
  @JsonKey(defaultValue: false)
  @override
  final bool highlighted;

  /// Timestamp when the role was created.
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;

  /// Timestamp when the role was last updated.
  @SafeDateTimeConverter()
  @override
  final DateTime? updatedAt;

  /// Maximum number of collections an account with this role may create.
  ///
  /// Added in Mastodon 4.6.0.
  @override
  final int? collectionLimit;
}

/// Deserializes the `role` field of an admin account.
///
/// Mastodon 4.0+ returns a role object, whereas Mastodon 3.x and forks such
/// as Fedibird return a plain string (`user`, `moderator`, `admin`). The
/// string form is mapped to a [MastodonAdminRole] carrying only its name.
MastodonAdminRole? adminRoleFromJson(Object? value) => switch (value) {
  null => null,
  final String name => MastodonAdminRole(name: name),
  final Map<String, dynamic> json => MastodonAdminRole.fromJson(json),
  _ => null,
};
