// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonCollection _$MastodonCollectionFromJson(Map<String, dynamic> json) =>
    MastodonCollection(
      id: json['id'] as String,
      uri: json['uri'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      language: json['language'] as String?,
      accountId: json['account_id'] as String?,
      local: json['local'] as bool?,
      sensitive: json['sensitive'] as bool?,
      discoverable: json['discoverable'] as bool?,
      url: json['url'] as String?,
      itemCount: (json['item_count'] as num?)?.toInt(),
      createdAt: const SafeDateTimeConverter().fromJson(
        json['created_at'] as String?,
      ),
      updatedAt: const SafeDateTimeConverter().fromJson(
        json['updated_at'] as String?,
      ),
      tag: json['tag'] == null
          ? null
          : MastodonCollectionTag.fromJson(json['tag'] as Map<String, dynamic>),
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MastodonCollectionItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$MastodonCollectionToJson(MastodonCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uri': instance.uri,
      'name': instance.name,
      'description': instance.description,
      'language': instance.language,
      'account_id': instance.accountId,
      'local': instance.local,
      'sensitive': instance.sensitive,
      'discoverable': instance.discoverable,
      'url': instance.url,
      'item_count': instance.itemCount,
      'created_at': const SafeDateTimeConverter().toJson(instance.createdAt),
      'updated_at': const SafeDateTimeConverter().toJson(instance.updatedAt),
      'tag': instance.tag?.toJson(),
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

MastodonCollectionTag _$MastodonCollectionTagFromJson(
  Map<String, dynamic> json,
) => MastodonCollectionTag(
  name: json['name'] as String,
  url: json['url'] as String,
);

Map<String, dynamic> _$MastodonCollectionTagToJson(
  MastodonCollectionTag instance,
) => <String, dynamic>{'name': instance.name, 'url': instance.url};

MastodonCollectionItem _$MastodonCollectionItemFromJson(
  Map<String, dynamic> json,
) => MastodonCollectionItem(
  id: json['id'] as String,
  state: json['state'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  accountId: json['account_id'] as String?,
);

Map<String, dynamic> _$MastodonCollectionItemToJson(
  MastodonCollectionItem instance,
) => <String, dynamic>{
  'id': instance.id,
  'state': instance.state,
  'created_at': instance.createdAt.toIso8601String(),
  'account_id': instance.accountId,
};
