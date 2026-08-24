import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_status_source.freezed.dart';
part 'mastodon_status_source.g.dart';

/// Source information of a status.
///
/// `GET /api/v1/statuses/:id/source`
///
/// Holds plain text content of the status for use in the editing UI.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusSource with _$MastodonStatusSource {
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
  @override
  final String id;

  /// Plain text of the status body.
  @override
  final String text;

  /// Plain text of the content warning (CW).
  @JsonKey(defaultValue: '')
  @override
  final String spoilerText;
}
