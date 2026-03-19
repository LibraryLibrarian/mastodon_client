// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: deprecated_member_use_from_same_package

part of 'mastodon_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonFilter _$MastodonFilterFromJson(
  Map<String, dynamic> json,
) => MastodonFilter(
  id: json['id'] as String,
  title: json['title'] as String? ?? '',
  context:
      (json['context'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  filterAction: $enumDecode(
    _$MastodonFilterActionEnumMap,
    json['filter_action'],
    unknownValue: MastodonFilterAction.warn,
  ),
  keywords:
      (json['keywords'] as List<dynamic>?)
          ?.map(
            (e) => MastodonFilterKeyword.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  statuses:
      (json['statuses'] as List<dynamic>?)
          ?.map((e) => MastodonFilterStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  expiresAt: const SafeDateTimeConverter().fromJson(
    json['expires_at'] as String?,
  ),
);

Map<String, dynamic> _$MastodonFilterToJson(MastodonFilter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'context': instance.context,
      'expires_at': const SafeDateTimeConverter().toJson(instance.expiresAt),
      'filter_action': _$MastodonFilterActionEnumMap[instance.filterAction]!,
      'keywords': instance.keywords,
      'statuses': instance.statuses,
    };

const _$MastodonFilterActionEnumMap = {
  MastodonFilterAction.warn: 'warn',
  MastodonFilterAction.hide: 'hide',
  MastodonFilterAction.blur: 'blur',
};

MastodonFilterKeyword _$MastodonFilterKeywordFromJson(
  Map<String, dynamic> json,
) => MastodonFilterKeyword(
  id: json['id'] as String,
  keyword: json['keyword'] as String? ?? '',
  wholeWord: json['whole_word'] as bool? ?? false,
);

Map<String, dynamic> _$MastodonFilterKeywordToJson(
  MastodonFilterKeyword instance,
) => <String, dynamic>{
  'id': instance.id,
  'keyword': instance.keyword,
  'whole_word': instance.wholeWord,
};

MastodonFilterStatus _$MastodonFilterStatusFromJson(
  Map<String, dynamic> json,
) => MastodonFilterStatus(
  id: json['id'] as String,
  statusId: json['status_id'] as String? ?? '',
);

Map<String, dynamic> _$MastodonFilterStatusToJson(
  MastodonFilterStatus instance,
) => <String, dynamic>{'id': instance.id, 'status_id': instance.statusId};

MastodonFilterV1 _$MastodonFilterV1FromJson(Map<String, dynamic> json) =>
    MastodonFilterV1(
      id: json['id'] as String,
      phrase: json['phrase'] as String? ?? '',
      context:
          (json['context'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      irreversible: json['irreversible'] as bool? ?? false,
      wholeWord: json['whole_word'] as bool? ?? false,
      expiresAt: const SafeDateTimeConverter().fromJson(
        json['expires_at'] as String?,
      ),
    );

Map<String, dynamic> _$MastodonFilterV1ToJson(MastodonFilterV1 instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phrase': instance.phrase,
      'context': instance.context,
      'expires_at': const SafeDateTimeConverter().toJson(instance.expiresAt),
      'irreversible': instance.irreversible,
      'whole_word': instance.wholeWord,
    };
