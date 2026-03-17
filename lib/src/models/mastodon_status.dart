import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_custom_emoji.dart';
import 'mastodon_media_attachment.dart';
import 'mastodon_poll.dart';
import 'mastodon_tag.dart';

export 'mastodon_tag.dart';

part 'mastodon_status.g.dart';

/// 投稿の公開範囲
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonVisibility {
  public,
  unlisted,
  private,
  direct,
}

/// メンション（投稿内の`@username`部分）
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonMention {
  const MastodonMention({
    required this.id,
    required this.username,
    required this.acct,
    required this.url,
  });

  factory MastodonMention.fromJson(Map<String, dynamic> json) =>
      _$MastodonMentionFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonMentionToJson(this);

  final String id;
  final String username;
  final String acct;
  final String url;
}

/// Mastodon の投稿（Status）
///
/// `/api/v1/statuses/:id`や各タイムラインAPIのレスポンスに対応する
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatus {
  const MastodonStatus({
    required this.id,
    required this.createdAt,
    required this.sensitive,
    required this.spoilerText,
    required this.visibility,
    required this.content,
    required this.reblogsCount,
    required this.favouritesCount,
    required this.repliesCount,
    required this.account,
    required this.mediaAttachments,
    required this.mentions,
    required this.tags,
    required this.emojis,
    this.uri,
    this.url,
    this.inReplyToId,
    this.inReplyToAccountId,
    this.language,
    this.text,
    this.editedAt,
    this.favourited,
    this.reblogged,
    this.bookmarked,
    this.muted,
    this.pinned,
    this.reblog,
    this.poll,
    this.quote,
  });

  factory MastodonStatus.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonStatusToJson(this);

  static Object? _readVisibility(Map<dynamic, dynamic> json, String key) =>
      json['visibility'] ?? 'public';

  /// 投稿の内部ID
  final String id;

  /// 投稿のURI（ActivityPub識別子）
  final String? uri;

  /// 投稿のパーマリンクURL
  final String? url;

  /// 投稿日時
  final DateTime createdAt;

  /// 返信先の投稿ID
  final String? inReplyToId;

  /// 返信先のアカウントID
  final String? inReplyToAccountId;

  /// センシティブコンテンツかどうか
  @JsonKey(defaultValue: false)
  final bool sensitive;

  /// コンテンツ警告（CW）テキスト なければ空文字
  @JsonKey(defaultValue: '')
  final String spoilerText;

  /// 公開範囲
  @JsonKey(
    readValue: _readVisibility,
    unknownEnumValue: MastodonVisibility.public,
  )
  final MastodonVisibility visibility;

  /// 言語コード（BCP47形式）
  final String? language;

  /// 投稿本文（HTML形式）
  @JsonKey(defaultValue: '')
  final String content;

  /// 投稿本文のプレーンテキスト 編集履歴取得時など一部APIでのみ含まれる
  final String? text;

  /// 最終編集日時 編集されていない場合はnull
  @SafeDateTimeConverter()
  final DateTime? editedAt;

  /// ブースト数
  @JsonKey(defaultValue: 0)
  final int reblogsCount;

  /// お気に入り数
  @JsonKey(defaultValue: 0)
  final int favouritesCount;

  /// 返信数
  @JsonKey(defaultValue: 0)
  final int repliesCount;

  /// 自分がお気に入り済みかどうか
  final bool? favourited;

  /// 自分がブースト済みかどうか
  final bool? reblogged;

  /// 自分がブックマーク済みかどうか
  final bool? bookmarked;

  /// 自分がミュートしているスレッドかどうか
  final bool? muted;

  /// ピン留めされているかどうか
  final bool? pinned;

  /// 投稿者のアカウント
  final MastodonAccount account;

  /// 添付メディアのリスト
  final List<MastodonMediaAttachment> mediaAttachments;

  /// メンションのリスト
  final List<MastodonMention> mentions;

  /// ハッシュタグのリスト
  final List<MastodonTag> tags;

  /// 投稿内で使われているカスタム絵文字のリスト
  final List<MastodonCustomEmoji> emojis;

  /// ブースト元の投稿 ブーストでない場合はnull
  final MastodonStatus? reblog;

  /// 投票 投票付き投稿でない場合はnull
  final MastodonPoll? poll;

  /// 引用元の投稿（Mastodon 4.5+ / FEP-044f）引用でない場合はnull
  final MastodonStatus? quote;
}
