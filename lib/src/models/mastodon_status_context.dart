import 'package:json_annotation/json_annotation.dart';

import 'mastodon_status.dart';

part 'mastodon_status_context.g.dart';

/// Context of a status (ancestors and descendants).
///
/// Corresponds to the response from `GET /api/v1/statuses/{id}/context`.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusContext {
  const MastodonStatusContext({
    required this.ancestors,
    required this.descendants,
  });

  factory MastodonStatusContext.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusContextFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonStatusContextToJson(this);

  /// Statuses preceding the target status (thread ancestors).
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> ancestors;

  /// Reply tree of the target status (descendants).
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> descendants;
}
