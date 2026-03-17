import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_custom_emoji.dart';
import 'mastodon_status.dart';

part 'mastodon_announcement.g.dart';

/// お知らせに対するリアクション
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAnnouncementReaction {
  const MastodonAnnouncementReaction({
    required this.name,
    required this.count,
    required this.me,
    this.url,
    this.staticUrl,
  });

  factory MastodonAnnouncementReaction.fromJson(Map<String, dynamic> json) =>
      _$MastodonAnnouncementReactionFromJson(json);

  /// 絵文字名（Unicode絵文字またはカスタム絵文字ショートコード）
  final String name;

  /// このリアクションの総数
  @JsonKey(defaultValue: 0)
  final int count;

  /// 自分がこのリアクションを付けたかどうか
  @JsonKey(defaultValue: false)
  final bool me;

  /// カスタム絵文字の場合の画像 URL
  final String? url;

  /// カスタム絵文字の場合の静止画 URL
  final String? staticUrl;
}

/// サーバーのお知らせ
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAnnouncement {
  const MastodonAnnouncement({
    required this.id,
    required this.content,
    required this.allDay,
    required this.read,
    required this.emojis,
    required this.reactions,
    required this.tags,
    required this.mentions,
    required this.statuses,
    this.startsAt,
    this.endsAt,
    this.publishedAt,
    this.updatedAt,
  });

  factory MastodonAnnouncement.fromJson(Map<String, dynamic> json) =>
      _$MastodonAnnouncementFromJson(json);

  /// お知らせの内部ID
  final String id;

  /// お知らせの本文（HTML）
  @JsonKey(defaultValue: '')
  final String content;

  /// 開始日時
  @SafeDateTimeConverter()
  final DateTime? startsAt;

  /// 終了日時
  @SafeDateTimeConverter()
  final DateTime? endsAt;

  /// 終日イベントかどうか
  @JsonKey(defaultValue: false)
  final bool allDay;

  /// 公開日時
  @SafeDateTimeConverter()
  final DateTime? publishedAt;

  /// 最終更新日時
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// 既読かどうか
  @JsonKey(defaultValue: false)
  final bool read;

  /// 本文中のカスタム絵文字
  @JsonKey(defaultValue: [])
  final List<MastodonCustomEmoji> emojis;

  /// リアクション一覧
  @JsonKey(defaultValue: [])
  final List<MastodonAnnouncementReaction> reactions;

  /// 本文中のハッシュタグ
  @JsonKey(defaultValue: [])
  final List<MastodonTag> tags;

  /// 本文中のメンション
  @JsonKey(defaultValue: [])
  final List<MastodonMention> mentions;

  /// 本文中で言及されたステータス
  @JsonKey(defaultValue: [])
  final List<MastodonAnnouncementStatus> statuses;
}

/// お知らせ本文中で参照されるステータス
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAnnouncementStatus {
  const MastodonAnnouncementStatus({
    required this.id,
    required this.url,
  });

  factory MastodonAnnouncementStatus.fromJson(Map<String, dynamic> json) =>
      _$MastodonAnnouncementStatusFromJson(json);

  /// ステータスID
  final String id;

  /// ステータスURL
  @JsonKey(defaultValue: '')
  final String url;
}
