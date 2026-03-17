import 'package:json_annotation/json_annotation.dart';

part 'mastodon_async_refresh.g.dart';

/// 非同期リフレッシュ操作のステータス（実験的）
///
/// `GET /api/v1_alpha/async_refreshes/:id` のレスポンスに対応する
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAsyncRefresh {
  const MastodonAsyncRefresh({
    required this.id,
    required this.status,
    this.resultCount,
  });

  factory MastodonAsyncRefresh.fromJson(Map<String, dynamic> json) =>
      _$MastodonAsyncRefreshFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonAsyncRefreshToJson(this);

  /// 非同期リフレッシュの識別子
  final String id;

  /// ステータス。`running`（処理中）または `finished`（完了）
  final String status;

  /// この操作で取得・生成された結果の数
  final int? resultCount;
}
