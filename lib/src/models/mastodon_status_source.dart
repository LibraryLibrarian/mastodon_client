import 'package:json_annotation/json_annotation.dart';

part 'mastodon_status_source.g.dart';

/// Source information of a status.
///
/// `GET /api/v1/statuses/:id/source`
///
/// Holds plain text content of the status for use in the editing UI.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusSource {
  const MastodonStatusSource({
    required this.id,
    required this.text,
    required this.spoilerText,
  });

  factory MastodonStatusSource.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusSourceFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonStatusSourceToJson(this);

  /// Internal ID of the status.
  final String id;

  /// Plain text of the status body.
  final String text;

  /// Plain text of the content warning (CW).
  @JsonKey(defaultValue: '')
  final String spoilerText;
}
