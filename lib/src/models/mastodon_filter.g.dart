// GENERATED CODE - DO NOT MODIFY BY HAND

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

MastodonFilterStatus _$MastodonFilterStatusFromJson(
  Map<String, dynamic> json,
) => MastodonFilterStatus(
  id: json['id'] as String,
  statusId: json['status_id'] as String? ?? '',
);

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
