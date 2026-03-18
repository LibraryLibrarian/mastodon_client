// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonSuggestion _$MastodonSuggestionFromJson(Map<String, dynamic> json) =>
    MastodonSuggestion(
      source: json['source'] as String,
      account: MastodonAccount.fromJson(
        json['account'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$MastodonSuggestionToJson(MastodonSuggestion instance) =>
    <String, dynamic>{
      'source': instance.source,
      'account': instance.account.toJson(),
    };
