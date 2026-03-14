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
