// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_admin_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminAccount _$MastodonAdminAccountFromJson(
  Map<String, dynamic> json,
) => MastodonAdminAccount(
  id: json['id'] as String,
  username: json['username'] as String,
  domain: json['domain'] as String?,
  createdAt: const SafeDateTimeConverter().fromJson(
    json['created_at'] as String?,
  ),
  email: json['email'] as String? ?? '',
  ip: json['ip'] as String?,
  ips:
      (json['ips'] as List<dynamic>?)
          ?.map((e) => MastodonAdminIp.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  locale: json['locale'] as String?,
  inviteRequest: json['invite_request'] as String?,
  role: json['role'] == null
      ? null
      : MastodonAdminRole.fromJson(json['role'] as Map<String, dynamic>),
  confirmed: json['confirmed'] as bool? ?? false,
  approved: json['approved'] as bool? ?? false,
  disabled: json['disabled'] as bool? ?? false,
  sensitized: json['sensitized'] as bool? ?? false,
  silenced: json['silenced'] as bool? ?? false,
  suspended: json['suspended'] as bool? ?? false,
  account: json['account'] == null
      ? null
      : MastodonAccount.fromJson(json['account'] as Map<String, dynamic>),
  createdByApplicationId: json['created_by_application_id'] as String?,
  invitedByAccountId: json['invited_by_account_id'] as String?,
);

Map<String, dynamic> _$MastodonAdminAccountToJson(
  MastodonAdminAccount instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'domain': instance.domain,
  'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
  'email': instance.email,
  'ip': instance.ip,
  'ips': instance.ips.map((e) => e.toJson()).toList(),
  'locale': instance.locale,
  'invite_request': instance.inviteRequest,
  'role': instance.role?.toJson(),
  'confirmed': instance.confirmed,
  'approved': instance.approved,
  'disabled': instance.disabled,
  'sensitized': instance.sensitized,
  'silenced': instance.silenced,
  'suspended': instance.suspended,
  'account': instance.account?.toJson(),
  'created_by_application_id': instance.createdByApplicationId,
  'invited_by_account_id': instance.invitedByAccountId,
};

MastodonAdminIp _$MastodonAdminIpFromJson(Map<String, dynamic> json) =>
    MastodonAdminIp(
      ip: json['ip'] as String,
      usedAt: const SafeDateTimeConverter().fromJson(
        json['used_at'] as String?,
      ),
    );

Map<String, dynamic> _$MastodonAdminIpToJson(MastodonAdminIp instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'used_at': const SafeDateTimeConverter().toJson(instance.usedAt),
    };

MastodonAdminRole _$MastodonAdminRoleFromJson(Map<String, dynamic> json) =>
    MastodonAdminRole(
      id: flexibleIdFromJson(json['id']),
      name: json['name'] as String,
      color: json['color'] as String? ?? '',
      position: (json['position'] as num?)?.toInt(),
      permissions: json['permissions'] as String?,
      highlighted: json['highlighted'] as bool? ?? false,
      createdAt: const SafeDateTimeConverter().fromJson(
        json['created_at'] as String?,
      ),
      updatedAt: const SafeDateTimeConverter().fromJson(
        json['updated_at'] as String?,
      ),
    );

Map<String, dynamic> _$MastodonAdminRoleToJson(MastodonAdminRole instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'position': instance.position,
      'permissions': instance.permissions,
      'highlighted': instance.highlighted,
      'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
      'updated_at': const SafeDateTimeConverter().toJson(instance.updatedAt),
    };
