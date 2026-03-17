import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_marker.g.dart';

/// タイムラインの既読位置マーカーを表すモデル
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonMarker {
  /// 各フィールドを指定して [MastodonMarker] を生成する
  const MastodonMarker({
    required this.lastReadId,
    required this.version,
    this.updatedAt,
  });

  /// JSON マップから [MastodonMarker] を生成する
  factory MastodonMarker.fromJson(Map<String, dynamic> json) =>
      _$MastodonMarkerFromJson(json);

  /// 最後に閲覧したエンティティ（ステータスまたは通知）の ID
  final String lastReadId;

  /// 書き込み競合防止用のバージョンカウンター
  final int version;

  /// マーカーが設定された日時
  @SafeDateTimeConverter()
  final DateTime? updatedAt;
}
