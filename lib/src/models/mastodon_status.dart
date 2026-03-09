import 'mastodon_account.dart';
import 'mastodon_custom_emoji.dart';
import 'mastodon_media_attachment.dart';
import 'mastodon_poll.dart';

/// 投稿の公開範囲
enum MastodonVisibility {
  public,
  unlisted,
  private,
  direct
  ;

  static MastodonVisibility fromString(String? value) {
    return switch (value) {
      'unlisted' => MastodonVisibility.unlisted,
      'private' => MastodonVisibility.private,
      'direct' => MastodonVisibility.direct,
      _ => MastodonVisibility.public,
    };
  }
}

/// メンション（投稿内の`@username`部分）
class MastodonMention {
  const MastodonMention({
    required this.id,
    required this.username,
    required this.acct,
    required this.url,
  });

  factory MastodonMention.fromJson(Map<String, dynamic> json) {
    return MastodonMention(
      id: json['id'] as String,
      username: json['username'] as String,
      acct: json['acct'] as String,
      url: json['url'] as String,
    );
  }

  final String id;
  final String username;
  final String acct;
  final String url;
}

/// ハッシュタグ
class MastodonTag {
  const MastodonTag({required this.name, required this.url});

  factory MastodonTag.fromJson(Map<String, dynamic> json) {
    return MastodonTag(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  final String name;
  final String url;
}

/// Mastodon の投稿（Status）
///
/// `/api/v1/statuses/:id`や各タイムラインAPIのレスポンスに対応する
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

  factory MastodonStatus.fromJson(Map<String, dynamic> json) {
    return MastodonStatus(
      id: json['id'] as String,
      uri: json['uri'] as String?,
      url: json['url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      inReplyToId: json['in_reply_to_id'] as String?,
      inReplyToAccountId: json['in_reply_to_account_id'] as String?,
      sensitive: json['sensitive'] as bool? ?? false,
      spoilerText: json['spoiler_text'] as String? ?? '',
      visibility: MastodonVisibility.fromString(
        json['visibility'] as String?,
      ),
      language: json['language'] as String?,
      content: json['content'] as String? ?? '',
      text: json['text'] as String?,
      editedAt: json['edited_at'] != null
          ? DateTime.tryParse(json['edited_at'] as String)
          : null,
      reblogsCount: json['reblogs_count'] as int? ?? 0,
      favouritesCount: json['favourites_count'] as int? ?? 0,
      repliesCount: json['replies_count'] as int? ?? 0,
      favourited: json['favourited'] as bool?,
      reblogged: json['reblogged'] as bool?,
      bookmarked: json['bookmarked'] as bool?,
      muted: json['muted'] as bool?,
      pinned: json['pinned'] as bool?,
      account: MastodonAccount.fromJson(
        json['account'] as Map<String, dynamic>,
      ),
      mediaAttachments: (json['media_attachments'] as List<dynamic>)
          .map(
            (m) => MastodonMediaAttachment.fromJson(
              m as Map<String, dynamic>,
            ),
          )
          .toList(),
      mentions: (json['mentions'] as List<dynamic>)
          .map((m) => MastodonMention.fromJson(m as Map<String, dynamic>))
          .toList(),
      tags: (json['tags'] as List<dynamic>)
          .map((t) => MastodonTag.fromJson(t as Map<String, dynamic>))
          .toList(),
      emojis: (json['emojis'] as List<dynamic>)
          .map(
            (e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      reblog: json['reblog'] != null
          ? MastodonStatus.fromJson(json['reblog'] as Map<String, dynamic>)
          : null,
      poll: json['poll'] != null
          ? MastodonPoll.fromJson(json['poll'] as Map<String, dynamic>)
          : null,
      quote: json['quote'] != null
          ? MastodonStatus.fromJson(json['quote'] as Map<String, dynamic>)
          : null,
    );
  }

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
  final bool sensitive;

  /// コンテンツ警告（CW）テキスト なければ空文字
  final String spoilerText;

  /// 公開範囲
  final MastodonVisibility visibility;

  /// 言語コード（BCP47形式）
  final String? language;

  /// 投稿本文（HTML形式）
  final String content;

  /// 投稿本文のプレーンテキスト 編集履歴取得時など一部APIでのみ含まれる
  final String? text;

  /// 最終編集日時 編集されていない場合はnull
  final DateTime? editedAt;

  /// ブースト数
  final int reblogsCount;

  /// お気に入り数
  final int favouritesCount;

  /// 返信数
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
