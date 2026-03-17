// GENERATED CODE - DO NOT MODIFY BY HAND

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

MastodonAdminIp _$MastodonAdminIpFromJson(Map<String, dynamic> json) =>
    MastodonAdminIp(
      ip: json['ip'] as String,
      usedAt: const SafeDateTimeConverter().fromJson(
        json['used_at'] as String?,
      ),
    );

MastodonAdminRole _$MastodonAdminRoleFromJson(Map<String, dynamic> json) =>
    MastodonAdminRole(
      id: (json['id'] as num).toInt(),
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
