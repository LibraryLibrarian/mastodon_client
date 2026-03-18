// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonSearchResult _$MastodonSearchResultFromJson(
  Map<String, dynamic> json,
) => MastodonSearchResult(
  accounts:
      (json['accounts'] as List<dynamic>?)
          ?.map((e) => MastodonAccount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  statuses:
      (json['statuses'] as List<dynamic>?)
          ?.map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  hashtags:
      (json['hashtags'] as List<dynamic>?)
          ?.map((e) => MastodonTag.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$MastodonSearchResultToJson(
  MastodonSearchResult instance,
) => <String, dynamic>{
  'accounts': instance.accounts.map((e) => e.toJson()).toList(),
  'statuses': instance.statuses.map((e) => e.toJson()).toList(),
  'hashtags': instance.hashtags.map((e) => e.toJson()).toList(),
};

MastodonSearchResultV1 _$MastodonSearchResultV1FromJson(
  Map<String, dynamic> json,
) => MastodonSearchResultV1(
  accounts:
      (json['accounts'] as List<dynamic>?)
          ?.map((e) => MastodonAccount.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  statuses:
      (json['statuses'] as List<dynamic>?)
          ?.map((e) => MastodonStatus.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  hashtags:
      (json['hashtags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
);

Map<String, dynamic> _$MastodonSearchResultV1ToJson(
  MastodonSearchResultV1 instance,
) => <String, dynamic>{
  'accounts': instance.accounts.map((e) => e.toJson()).toList(),
  'statuses': instance.statuses.map((e) => e.toJson()).toList(),
  'hashtags': instance.hashtags,
};
