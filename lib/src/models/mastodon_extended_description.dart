import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_extended_description.g.dart';

/// Extended description of the instance.
///
/// `GET /api/v1/instance/extended_description`
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonExtendedDescription {
  const MastodonExtendedDescription({
    this.updatedAt,
    required this.content,
  });

  factory MastodonExtendedDescription.fromJson(Map<String, dynamic> json) =>
      _$MastodonExtendedDescriptionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonExtendedDescriptionToJson(this);

  /// Timestamp when the extended description was last updated.
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// HTML content of the extended description.
  @JsonKey(defaultValue: '')
  final String content;
}
