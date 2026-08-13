import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_collection.dart';
import 'mastodon_custom_emoji.dart';
import 'mastodon_filter.dart';
import 'mastodon_media_attachment.dart';
import 'mastodon_poll.dart';
import 'mastodon_preview_card.dart';
import 'mastodon_tag.dart';

export 'mastodon_tag.dart';

part 'mastodon_status.g.dart';

/// Visibility of a status.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonVisibility { public, unlisted, private, direct }

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
    this.card,
    this.application,
    this.quoteApproval,
    this.quotesCount = 0,
    this.filtered = const <MastodonFilterResult>[],
    this.taggedCollections = const <MastodonCollection>[],
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

  /// Number of quotes of this status.
  ///
  /// Added in Mastodon 4.5.0.
  @JsonKey(defaultValue: 0)
  final int quotesCount;

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

  /// Link preview card for the first link in the status.
  ///
  /// Null when the status contains no link, or when the card has not been
  /// fetched yet. From Mastodon 4.6.0 this is the only way to obtain a
  /// status's preview card; the dedicated `GET /api/v1/statuses/:id/card`
  /// endpoint was removed.
  final MastodonPreviewCard? card;

  /// Application used to post the status.
  ///
  /// Returned only when the author has opted in to disclosing it, or when
  /// the status belongs to the authenticated user.
  final MastodonStatusApplication? application;

  /// Filters the status matched for the authenticated user.
  ///
  /// Empty for unauthenticated requests. Clients are expected to honour these
  /// results rather than applying filter rules themselves.
  @JsonKey(defaultValue: <MastodonFilterResult>[])
  final List<MastodonFilterResult> filtered;

  /// Quote approval policy of the status.
  ///
  /// Added in Mastodon 4.5.0.
  final MastodonQuoteApproval? quoteApproval;

  /// Collections this status has been tagged into.
  ///
  /// Added in Mastodon 4.6.0.
  @JsonKey(defaultValue: <MastodonCollection>[])
  final List<MastodonCollection> taggedCollections;
}

/// Application that published a status.
///
/// A reduced form of `MastodonApplication` carrying only the fields the
/// status API exposes; client credentials and registration details are not
/// disclosed for other users' statuses.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusApplication {
  const MastodonStatusApplication({required this.name, this.website});

  factory MastodonStatusApplication.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusApplicationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonStatusApplicationToJson(this);

  /// Name of the application.
  @JsonKey(defaultValue: '')
  final String name;

  /// Website URL of the application. Null if the application declared none.
  final String? website;
}

/// Quote approval policy of a status (Mastodon 4.5.0+).
///
/// [automatic] and [manual] each list the visibility scopes (e.g. `public`,
/// `followers`) whose members may quote the status without approval or with
/// manual approval, respectively.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonQuoteApproval {
  const MastodonQuoteApproval({
    this.automatic = const <String>[],
    this.manual = const <String>[],
    this.currentUser,
  });

  factory MastodonQuoteApproval.fromJson(Map<String, dynamic> json) =>
      _$MastodonQuoteApprovalFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonQuoteApprovalToJson(this);

  /// Visibility scopes whose members may quote without approval.
  @JsonKey(defaultValue: <String>[])
  final List<String> automatic;

  /// Visibility scopes whose members may quote with manual approval.
  @JsonKey(defaultValue: <String>[])
  final List<String> manual;

  /// Whether the authenticated user may quote this status
  /// (e.g. `automatic`, `manual`, `denied`). Null for unauthenticated
  /// requests.
  final String? currentUser;
}
