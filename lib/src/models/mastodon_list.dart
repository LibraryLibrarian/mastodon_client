import 'package:json_annotation/json_annotation.dart';

part 'mastodon_list.g.dart';

/// User-defined list.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonList {
  /// Creates a [MastodonList] with the given fields.
  const MastodonList({
    required this.id,
    required this.title,
    required this.repliesPolicy,
    required this.exclusive,
  });

  /// Creates a [MastodonList] from a JSON map.
  factory MastodonList.fromJson(Map<String, dynamic> json) =>
      _$MastodonListFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonListToJson(this);

  /// Internal ID of the list.
  final String id;

  /// Title of the list.
  final String title;

  /// Reply display policy within the list (`followed` / `list` / `none`).
  @JsonKey(defaultValue: 'list')
  final String repliesPolicy;

  /// Whether to exclude list member posts from the home timeline.
  @JsonKey(defaultValue: false)
  final bool exclusive;
}
