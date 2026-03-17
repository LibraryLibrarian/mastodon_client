// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_familiar_followers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonFamiliarFollowers _$MastodonFamiliarFollowersFromJson(
  Map<String, dynamic> json,
) => MastodonFamiliarFollowers(
  id: json['id'] as String,
  accounts:
      (json['accounts'] as List<dynamic>?)
          ?.map((e) => MastodonAccount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$MastodonFamiliarFollowersToJson(
  MastodonFamiliarFollowers instance,
) => <String, dynamic>{'id': instance.id, 'accounts': instance.accounts};
