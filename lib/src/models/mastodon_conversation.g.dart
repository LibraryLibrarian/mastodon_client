// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonConversation _$MastodonConversationFromJson(
  Map<String, dynamic> json,
) => MastodonConversation(
  id: json['id'] as String,
  unread: json['unread'] as bool? ?? false,
  accounts:
      (json['accounts'] as List<dynamic>?)
          ?.map((e) => MastodonAccount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  lastStatus: json['last_status'] == null
      ? null
      : MastodonStatus.fromJson(json['last_status'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MastodonConversationToJson(
  MastodonConversation instance,
) => <String, dynamic>{
  'id': instance.id,
  'unread': instance.unread,
  'accounts': instance.accounts,
  'last_status': instance.lastStatus,
};
