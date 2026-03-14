// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonTag _$MastodonTagFromJson(Map<String, dynamic> json) => MastodonTag(
  id: json['id'] as String? ?? '',
  name: json['name'] as String,
  url: json['url'] as String? ?? '',
  history:
      (json['history'] as List<dynamic>?)
          ?.map((e) => MastodonTagHistory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  following: json['following'] as bool?,
  featuring: json['featuring'] as bool?,
);

MastodonTagHistory _$MastodonTagHistoryFromJson(Map<String, dynamic> json) =>
    MastodonTagHistory(
      day: json['day'] as String,
      uses: json['uses'] as String,
      accounts: json['accounts'] as String,
    );
