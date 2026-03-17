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
