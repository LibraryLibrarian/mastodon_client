// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mastodon_marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MastodonMarker _$MastodonMarkerFromJson(Map<String, dynamic> json) =>
    MastodonMarker(
      lastReadId: json['last_read_id'] as String,
      version: (json['version'] as num).toInt(),
      updatedAt: const SafeDateTimeConverter().fromJson(
        json['updated_at'] as String?,
      ),
    );

Map<String, dynamic> _$MastodonMarkerToJson(MastodonMarker instance) =>
    <String, dynamic>{
      'last_read_id': instance.lastReadId,
      'version': instance.version,
      'updated_at': const SafeDateTimeConverter().toJson(instance.updatedAt),
    };
