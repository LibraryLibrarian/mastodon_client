import 'package:json_annotation/json_annotation.dart';

part 'mastodon_tag.g.dart';

/// ハッシュタグ情報を表すモデル
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTag {
  /// 各フィールドを指定して [MastodonTag] を生成する
  const MastodonTag({
    required this.id,
    required this.name,
    required this.url,
    this.history = const [],
    this.following,
    this.featuring,
  });

  /// JSON マップから [MastodonTag] を生成する
  factory MastodonTag.fromJson(Map<String, dynamic> json) =>
      _$MastodonTagFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonTagToJson(this);

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

  /// 認証済みユーザーがこのタグをフォローしているか（認証時のみ）
  final bool? following;

  /// 認証済みユーザーがこのタグをプロフィールにフィーチャーしているか（認証時のみ）
  final bool? featuring;
}

/// ハッシュタグの日別利用統計
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTagHistory {
  /// 各フィールドを指定して [MastodonTagHistory] を生成する
  const MastodonTagHistory({
    required this.day,
    required this.uses,
    required this.accounts,
  });

  /// JSON マップから [MastodonTagHistory] を生成する
  factory MastodonTagHistory.fromJson(Map<String, dynamic> json) =>
      _$MastodonTagHistoryFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonTagHistoryToJson(this);

  /// 該当日の深夜0時の UNIX タイムスタンプ（文字列）
  final String day;

  /// その日のタグ使用回数（文字列）
  final String uses;

  /// その日にタグを使用したアカウント数（文字列）
  final String accounts;
}
