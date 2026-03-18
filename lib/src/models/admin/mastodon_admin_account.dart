import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';
import '../mastodon_account.dart';

part 'mastodon_admin_account.g.dart';

/// Admin-level account information.
///
/// Account information returned by the Admin API responses.
/// Includes additional admin-specific details beyond the standard
/// [MastodonAccount].
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminAccount {
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
  final String id;

  /// Username of the account.
  final String username;

  /// Domain of the account (null for local accounts).
  final String? domain;

  /// Timestamp when the account was created.
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// Email address associated with the account.
  @JsonKey(defaultValue: '')
  final String? email;

  /// IP address last used for login.
  final String? ip;

  /// History of all IP addresses associated with this account.
  @JsonKey(defaultValue: <MastodonAdminIp>[])
  final List<MastodonAdminIp> ips;

  /// Locale of the account (ISO 639-1 language code).
  final String? locale;

  /// Reason provided when requesting an invite.
  final String? inviteRequest;

  /// Current role of the account.
  final MastodonAdminRole? role;

  /// Whether the email address has been confirmed.
  @JsonKey(defaultValue: false)
  final bool confirmed;

  /// Whether the account has been approved.
  @JsonKey(defaultValue: false)
  final bool approved;

  /// Whether the account has been disabled.
  @JsonKey(defaultValue: false)
  final bool disabled;

  /// Whether the account has been marked as sensitive.
  @JsonKey(defaultValue: false)
  final bool sensitized;

  /// Whether the account has been silenced.
  @JsonKey(defaultValue: false)
  final bool silenced;

  /// Whether the account has been suspended.
  @JsonKey(defaultValue: false)
  final bool suspended;

  /// User-level account information.
  final MastodonAccount? account;

  /// ID of the application that created this account.
  final String? createdByApplicationId;

  /// ID of the account that invited this user.
  final String? invitedByAccountId;
}

/// Admin-level IP address information.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminIp {
  const MastodonAdminIp({
    required this.ip,
    this.usedAt,
  });

  factory MastodonAdminIp.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminIpFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminIpToJson(this);

  /// IP address.
  final String ip;

  /// Timestamp when this IP address was last used.
  @SafeDateTimeConverter()
  final DateTime? usedAt;
}

/// Admin-level role information.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminRole {
  const MastodonAdminRole({
    required this.id,
    required this.name,
    this.color,
    this.position,
    this.permissions,
    this.highlighted = false,
    this.createdAt,
    this.updatedAt,
  });

  factory MastodonAdminRole.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminRoleFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminRoleToJson(this);

  /// ID of the role.
  final int id;

  /// Name of the role.
  final String name;

  /// Color code of the role.
  @JsonKey(defaultValue: '')
  final String? color;

  /// Priority of the role.
  final int? position;

  /// Permission bitmask of the role.
  final String? permissions;

  /// Whether to display the role as a badge.
  @JsonKey(defaultValue: false)
  final bool highlighted;

  /// Timestamp when the role was created.
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// Timestamp when the role was last updated.
  @SafeDateTimeConverter()
  final DateTime? updatedAt;
}
