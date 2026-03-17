// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_async_refresh.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonAsyncRefresh _$MastodonAsyncRefreshFromJson(
  Map<String, dynamic> json,
) => MastodonAsyncRefresh(
  id: json['id'] as String,
  status: json['status'] as String,
  resultCount: (json['result_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$MastodonAsyncRefreshToJson(
  MastodonAsyncRefresh instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'result_count': instance.resultCount,
};
