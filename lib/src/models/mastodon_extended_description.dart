import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';

part 'mastodon_extended_description.freezed.dart';
part 'mastodon_extended_description.g.dart';

/// Extended description of the instance.
///
/// `GET /api/v1/instance/extended_description`
@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonExtendedDescription with _$MastodonExtendedDescription {
  const MastodonExtendedDescription({this.updatedAt, required this.content});

  factory MastodonExtendedDescription.fromJson(Map<String, dynamic> json) =>
      _$MastodonExtendedDescriptionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonExtendedDescriptionToJson(this);

  /// Timestamp when the extended description was last updated.
  @SafeDateTimeConverter()
  @override
  final DateTime? updatedAt;

  /// HTML content of the extended description.
  @JsonKey(defaultValue: '')
  @override
  final String content;
}
