import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_filter.g.dart';

/// Filter action type (v2).
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonFilterAction {
  /// Shows a warning on matched content (default).
  warn,

  /// Completely hides matched content.
  hide,

  /// Blurs matched media (Mastodon 4.4.0+).
  blur,
}

/// Filter group (v2, Mastodon 4.0+).
///
/// Corresponds to the response from `/api/v2/filters`.
/// Performs server-side filtering and allows associating multiple keywords
/// and statuses with a single filter.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonFilter {
  const MastodonFilter({
    required this.id,
    required this.title,
    required this.context,
    required this.filterAction,
    required this.keywords,
    required this.statuses,
    this.expiresAt,
  });

  factory MastodonFilter.fromJson(Map<String, dynamic> json) =>
      _$MastodonFilterFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonFilterToJson(this);

  /// Internal ID of the filter.
  final String id;

  /// Name of the filter group.
  @JsonKey(defaultValue: '')
  final String title;

  /// Contexts where the filter is applied (`home`, `notifications`, `public`,
  /// `thread`, `account`).
  @JsonKey(defaultValue: <String>[])
  final List<String> context;

  /// Expiration timestamp. `null` if permanent.
  @SafeDateTimeConverter()
  final DateTime? expiresAt;

  /// Action to take on match.
  @JsonKey(unknownEnumValue: MastodonFilterAction.warn)
  final MastodonFilterAction filterAction;

  /// Keywords belonging to this filter.
  @JsonKey(defaultValue: <MastodonFilterKeyword>[])
  final List<MastodonFilterKeyword> keywords;

  /// Status filters belonging to this filter.
  @JsonKey(defaultValue: <MastodonFilterStatus>[])
  final List<MastodonFilterStatus> statuses;
}

/// Filter keyword.
///
/// Corresponds to the response from `/api/v2/filters/:filter_id/keywords`.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonFilterKeyword {
  const MastodonFilterKeyword({
    required this.id,
    required this.keyword,
    required this.wholeWord,
  });

  factory MastodonFilterKeyword.fromJson(Map<String, dynamic> json) =>
      _$MastodonFilterKeywordFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonFilterKeywordToJson(this);

  /// Internal ID of the FilterKeyword.
  final String id;

  /// Keyword string to filter.
  @JsonKey(defaultValue: '')
  final String keyword;

  /// Whether to consider word boundaries.
  @JsonKey(defaultValue: false)
  final bool wholeWord;
}

/// Status filter.
///
/// Corresponds to the response from `/api/v2/filters/:filter_id/statuses`.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonFilterStatus {
  const MastodonFilterStatus({
    required this.id,
    required this.statusId,
  });

  factory MastodonFilterStatus.fromJson(Map<String, dynamic> json) =>
      _$MastodonFilterStatusFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonFilterStatusToJson(this);

  /// Internal ID of the FilterStatus.
  final String id;

  /// ID of the status to filter.
  @JsonKey(defaultValue: '')
  final String statusId;
}

/// v1 filter (deprecated, scheduled for removal in Mastodon 4.0).
///
/// Corresponds to the response from `/api/v1/filters`.
/// Designed for client-side filtering with a one-filter-per-keyword structure.
@Deprecated('Deprecated in Mastodon 4.0.0. Use MastodonFilter (v2) instead')
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonFilterV1 {
  @Deprecated('Deprecated in Mastodon 4.0.0. Use MastodonFilter (v2) instead')
  const MastodonFilterV1({
    required this.id,
    required this.phrase,
    required this.context,
    required this.irreversible,
    required this.wholeWord,
    this.expiresAt,
  });

  @Deprecated('Deprecated in Mastodon 4.0.0. Use MastodonFilter (v2) instead')
  factory MastodonFilterV1.fromJson(Map<String, dynamic> json) =>
      _$MastodonFilterV1FromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonFilterV1ToJson(this);

  /// Internal ID of the filter.
  final String id;

  /// Text to filter.
  @JsonKey(defaultValue: '')
  final String phrase;

  /// Contexts where the filter is applied (`home`, `notifications`, `public`,
  /// `thread`, `account`).
  @JsonKey(defaultValue: <String>[])
  final List<String> context;

  /// Expiration timestamp. `null` if permanent.
  @SafeDateTimeConverter()
  final DateTime? expiresAt;

  /// Whether to irreversibly drop matching entities on the server side for
  /// home and notifications.
  @JsonKey(defaultValue: false)
  final bool irreversible;

  /// Whether to match using word boundaries.
  @JsonKey(defaultValue: false)
  final bool wholeWord;
}
