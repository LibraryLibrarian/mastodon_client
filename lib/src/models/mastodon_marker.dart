import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_marker.g.dart';

/// Timeline read position marker model.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonMarker {
  /// Creates a [MastodonMarker] with the given fields.
  const MastodonMarker({
    required this.lastReadId,
    required this.version,
    this.updatedAt,
  });

  /// Creates a [MastodonMarker] from a JSON map.
  factory MastodonMarker.fromJson(Map<String, dynamic> json) =>
      _$MastodonMarkerFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonMarkerToJson(this);

  /// ID of the last viewed entity (status or notification).
  final String lastReadId;

  /// Version counter for write conflict prevention.
  final int version;

  /// Timestamp when the marker was set.
  @SafeDateTimeConverter()
  final DateTime? updatedAt;
}
