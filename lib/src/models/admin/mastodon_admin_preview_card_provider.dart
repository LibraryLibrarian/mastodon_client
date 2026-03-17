import 'package:json_annotation/json_annotation.dart';

import '../json_converters.dart';

part 'mastodon_admin_preview_card_provider.g.dart';

/// 管理者向けプレビューカード発行元
///
/// トレンドリンクの発行元ドメインの管理情報を表す。
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminPreviewCardProvider {
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

  /// JSON シリアライズ
  Map<String, dynamic> toJson() =>
      _$MastodonAdminPreviewCardProviderToJson(this);

  /// 発行元のデータベース ID
  final String id;

  /// 発行元のドメイン名
  final String domain;

  /// トレンドとして表示が承認されているかどうか
  final bool? trendable;

  /// モデレーターがレビューした日時
  @SafeDateTimeConverter()
  final DateTime? reviewedAt;

  /// レビューが要求された日時
  @SafeDateTimeConverter()
  final DateTime? requestedReviewAt;

  /// モデレーターによるレビューが必要かどうか
  final bool? requiresReview;
}
