import 'package:json_annotation/json_annotation.dart';
import '../mastodon_tag.dart';

part 'mastodon_admin_tag.g.dart';

/// 管理者向けハッシュタグ情報
///
/// 通常の [MastodonTag] に管理者向けのトレンド管理フィールドを追加したもの。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminTag {
  const MastodonAdminTag({
    required this.id,
    required this.name,
    required this.url,
    this.history = const [],
    this.trendable,
    this.usable,
    this.requiresReview,
  });

  factory MastodonAdminTag.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminTagFromJson(json);

  /// タグのデータベース ID
  @JsonKey(defaultValue: '')
  final String id;

  /// `#` 記号を除いたハッシュタグの名前
  final String name;

  /// インスタンス上のハッシュタグへの URL
  @JsonKey(defaultValue: '')
  final String url;

  /// 直近の日別利用統計
  @JsonKey(defaultValue: [])
  final List<MastodonTagHistory> history;

  /// トレンドとして表示が承認されているかどうか
  final bool? trendable;

  /// 自動リンクが有効かどうか
  final bool? usable;

  /// レビューが必要かどうか
  final bool? requiresReview;
}
