// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_admin_canonical_email_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAdminCanonicalEmailBlock _$MastodonAdminCanonicalEmailBlockFromJson(
  Map<String, dynamic> json,
) => MastodonAdminCanonicalEmailBlock(
  id: json['id'] as String,
  canonicalEmailHash: json['canonical_email_hash'] as String,
);

Map<String, dynamic> _$MastodonAdminCanonicalEmailBlockToJson(
  MastodonAdminCanonicalEmailBlock instance,
) => <String, dynamic>{
  'id': instance.id,
  'canonical_email_hash': instance.canonicalEmailHash,
};
