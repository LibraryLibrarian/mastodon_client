import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters.dart';

part 'mastodon_admin_preview_card_provider.freezed.dart';
part 'mastodon_admin_preview_card_provider.g.dart';

/// Admin-level preview card provider.
///
/// Represents admin information for a trending link provider domain.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminPreviewCardProvider with _$MastodonAdminPreviewCardProvider {
  const MastodonAdminPreviewCardProvider({
    required this.id,
    required this.domain,
    this.trendable,
    this.reviewedAt,
    this.requestedReviewAt,
    this.requiresReview,
  });

  factory MastodonAdminPreviewCardProvider.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonAdminPreviewCardProviderFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonAdminPreviewCardProviderToJson(this);

  /// Database ID of the provider.
  @override
  final String id;

  /// Domain name of the provider.
  @override
  final String domain;

  /// Whether the provider is approved to appear as a trend.
  @override
  final bool? trendable;

  /// Timestamp when a moderator reviewed the provider.
  @SafeDateTimeConverter()
  @override
  final DateTime? reviewedAt;

  /// Timestamp when a review was requested.
  @SafeDateTimeConverter()
  @override
  final DateTime? requestedReviewAt;

  /// Whether moderator review is required.
  @override
  final bool? requiresReview;
}
