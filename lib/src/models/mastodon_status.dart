import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_custom_emoji.dart';
import 'mastodon_media_attachment.dart';
import 'mastodon_poll.dart';
import 'mastodon_tag.dart';

export 'mastodon_tag.dart';

part 'mastodon_status.g.dart';

/// Visibility of a status.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonVisibility {
  public,
  unlisted,
  private,
  direct,
}

/// Mention (the `@username` portion within a status).
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

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonMentionToJson(this);

  final String id;
  final String username;
  final String acct;
  final String url;
}

/// Mastodon status (post).
///
/// Corresponds to responses from `/api/v1/statuses/:id` and various timeline APIs.
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

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonStatusToJson(this);

  static Object? _readVisibility(Map<dynamic, dynamic> json, String key) =>
      json['visibility'] ?? 'public';

  /// Internal ID of the status.
  final String id;

  /// URI of the status (ActivityPub identifier).
  final String? uri;

  /// Permalink URL of the status.
  final String? url;

  /// Timestamp when the status was posted.
  final DateTime createdAt;

  /// ID of the status being replied to.
  final String? inReplyToId;

  /// ID of the account being replied to.
  final String? inReplyToAccountId;

  /// Whether the status is marked as sensitive content.
  @JsonKey(defaultValue: false)
  final bool sensitive;

  /// Content warning (CW) text. Empty string if none.
  @JsonKey(defaultValue: '')
  final String spoilerText;

  /// Visibility of the status.
  @JsonKey(
    readValue: _readVisibility,
    unknownEnumValue: MastodonVisibility.public,
  )
  final MastodonVisibility visibility;

  /// Language code (BCP47 format).
  final String? language;

  /// Body text of the status (HTML format).
  @JsonKey(defaultValue: '')
  final String content;

  /// Plain text of the status body. Included only in certain APIs such as
  /// edit history retrieval.
  final String? text;

  /// Timestamp of the last edit. Null if never edited.
  @SafeDateTimeConverter()
  final DateTime? editedAt;

  /// Number of boosts.
  @JsonKey(defaultValue: 0)
  final int reblogsCount;

  /// Number of favourites.
  @JsonKey(defaultValue: 0)
  final int favouritesCount;

  /// Number of replies.
  @JsonKey(defaultValue: 0)
  final int repliesCount;

  /// Whether the authenticated user has favourited this status.
  final bool? favourited;

  /// Whether the authenticated user has boosted this status.
  final bool? reblogged;

  /// Whether the authenticated user has bookmarked this status.
  final bool? bookmarked;

  /// Whether the authenticated user has muted the thread.
  final bool? muted;

  /// Whether the status is pinned.
  final bool? pinned;

  /// Account of the author.
  final MastodonAccount account;

  /// List of media attachments.
  final List<MastodonMediaAttachment> mediaAttachments;

  /// List of mentions.
  final List<MastodonMention> mentions;

  /// List of hashtags.
  final List<MastodonTag> tags;

  /// List of custom emojis used in the status.
  final List<MastodonCustomEmoji> emojis;

  /// Original boosted status. Null if not a boost.
  final MastodonStatus? reblog;

  /// Poll. Null if the status does not have a poll.
  final MastodonPoll? poll;

  /// Quoted status (Mastodon 4.5+ / FEP-044f). Null if not a quote.
  final MastodonStatus? quote;
}
