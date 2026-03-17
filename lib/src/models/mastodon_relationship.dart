import 'package:json_annotation/json_annotation.dart';

part 'mastodon_relationship.g.dart';

/// 2つのアカウント間のリレーションシップ（フォロー・ブロック・ミュート等の関係）
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonRelationship {
  /// 各フィールドを指定して [MastodonRelationship] を生成する
  const MastodonRelationship({
    required this.id,
    required this.following,
    required this.showingReblogs,
    required this.notifying,
    required this.followedBy,
    required this.blocking,
    required this.blockedBy,
    required this.muting,
    required this.mutingNotifications,
    required this.requested,
    required this.requestedBy,
    required this.domainBlocking,
    required this.endorsed,
    required this.note,
    this.languages,
  });

  /// JSON マップから [MastodonRelationship] を生成する
  factory MastodonRelationship.fromJson(Map<String, dynamic> json) =>
      _$MastodonRelationshipFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonRelationshipToJson(this);

  /// 対象アカウントの ID
  final String id;

  /// このアカウントをフォローしているかどうか
  @JsonKey(defaultValue: false)
  final bool following;

  /// このアカウントのブースト投稿をホームタイムラインに表示するかどうか
  @JsonKey(defaultValue: true)
  final bool showingReblogs;

  /// このアカウントの通知を有効にしているかどうか
  @JsonKey(defaultValue: false)
  final bool notifying;

  /// このアカウントからフォローしている言語のリスト（ISO 639-1）
  final List<String>? languages;

  /// このアカウントにフォローされているかどうか
  @JsonKey(defaultValue: false)
  final bool followedBy;

  /// このアカウントをブロックしているかどうか
  @JsonKey(defaultValue: false)
  final bool blocking;

  /// このアカウントにブロックされているかどうか
  @JsonKey(defaultValue: false)
  final bool blockedBy;

  /// このアカウントをミュートしているかどうか
  @JsonKey(defaultValue: false)
  final bool muting;

  /// このアカウントからの通知をミュートしているかどうか
  @JsonKey(defaultValue: false)
  final bool mutingNotifications;

  /// このアカウントへのフォローリクエストが保留中かどうか
  @JsonKey(defaultValue: false)
  final bool requested;

  /// このアカウントからのフォローリクエストが保留中かどうか
  @JsonKey(defaultValue: false)
  final bool requestedBy;

  /// このアカウントのドメインをブロックしているかどうか
  @JsonKey(defaultValue: false)
  final bool domainBlocking;

  /// このアカウントをプロフィールで紹介しているかどうか
  @JsonKey(defaultValue: false)
  final bool endorsed;

  /// このアカウントに設定したプライベートメモ
  @JsonKey(defaultValue: '')
  final String note;
}
