import 'package:freezed_annotation/freezed_annotation.dart';

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

part 'mastodon_status.freezed.dart';
part 'mastodon_status.g.dart';

/// Visibility of a status.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonVisibility { public, unlisted, private, direct }

/// State of a quote relationship.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonQuoteState {
  pending,
  accepted,
  rejected,
  revoked,
  deleted,
  unauthorized,
  blockedDomain,
  blockedAccount,
  mutedAccount,
  unknown,
}

/// Mention (the `@username` portion within a status).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonMention with _$MastodonMention {
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

  @override
  final String id;
  @override
  final String username;
  @override
  final String acct;
  @override
  final String url;
}

/// Mastodon status (post).
///
/// Corresponds to responses from `/api/v1/statuses/:id` and various timeline APIs.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatus with _$MastodonStatus {
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
  @override
  final String id;

  /// URI of the status (ActivityPub identifier).
  @override
  final String? uri;

  /// Permalink URL of the status.
  @override
  final String? url;

  /// Timestamp when the status was posted.
  @override
  final DateTime createdAt;

  /// ID of the status being replied to.
  @override
  final String? inReplyToId;

  /// ID of the account being replied to.
  @override
  final String? inReplyToAccountId;

  /// Whether the status is marked as sensitive content.
  @JsonKey(defaultValue: false)
  @override
  final bool sensitive;

  /// Content warning (CW) text. Empty string if none.
  @JsonKey(defaultValue: '')
  @override
  final String spoilerText;

  /// Visibility of the status.
  @JsonKey(
    readValue: _readVisibility,
    unknownEnumValue: MastodonVisibility.public,
  )
  @override
  final MastodonVisibility visibility;

  /// Language code (BCP47 format).
  @override
  final String? language;

  /// Body text of the status (HTML format).
  @JsonKey(defaultValue: '')
  @override
  final String content;

  /// Plain text of the status body. Included only in certain APIs such as
  /// edit history retrieval.
  @override
  final String? text;

  /// Timestamp of the last edit. Null if never edited.
  @SafeDateTimeConverter()
  @override
  final DateTime? editedAt;

  /// Number of boosts.
  @JsonKey(defaultValue: 0)
  @override
  final int reblogsCount;

  /// Number of favourites.
  @JsonKey(defaultValue: 0)
  @override
  final int favouritesCount;

  /// Number of replies.
  @JsonKey(defaultValue: 0)
  @override
  final int repliesCount;

  /// Number of quotes of this status.
  ///
  /// Added in Mastodon 4.5.0.
  @JsonKey(defaultValue: 0)
  @override
  final int quotesCount;

  /// Whether the authenticated user has favourited this status.
  @override
  final bool? favourited;

  /// Whether the authenticated user has boosted this status.
  @override
  final bool? reblogged;

  /// Whether the authenticated user has bookmarked this status.
  @override
  final bool? bookmarked;

  /// Whether the authenticated user has muted the thread.
  @override
  final bool? muted;

  /// Whether the status is pinned.
  @override
  final bool? pinned;

  /// Account of the author.
  @override
  final MastodonAccount account;

  /// List of media attachments.
  @override
  final List<MastodonMediaAttachment> mediaAttachments;

  /// List of mentions.
  @override
  final List<MastodonMention> mentions;

  /// List of hashtags.
  @override
  final List<MastodonTag> tags;

  /// List of custom emojis used in the status.
  @override
  final List<MastodonCustomEmoji> emojis;

  /// Original boosted status. Null if not a boost.
  @override
  final MastodonStatus? reblog;

  /// Poll. Null if the status does not have a poll.
  @override
  final MastodonPoll? poll;

  /// Quote relationship attached to this status.
  ///
  /// Null if this status is not a quote. Added in Mastodon 4.5.0.
  @override
  final MastodonQuote? quote;

  /// Link preview card for the first link in the status.
  ///
  /// Null when the status contains no link, or when the card has not been
  /// fetched yet. Added in Mastodon 2.6.0 as the replacement for the dedicated
  /// `GET /api/v1/statuses/:id/card` endpoint, which was removed in 3.0.0.
  @override
  final MastodonPreviewCard? card;

  /// Application used to post the status.
  ///
  /// Returned only when the author has opted in to disclosing it, or when
  /// the status belongs to the authenticated user.
  @override
  final MastodonStatusApplication? application;

  /// Filters the status matched for the authenticated user.
  ///
  /// Empty for unauthenticated requests. Clients are expected to honour these
  /// results rather than applying filter rules themselves.
  @JsonKey(defaultValue: <MastodonFilterResult>[])
  @override
  final List<MastodonFilterResult> filtered;

  /// Quote approval policy of the status.
  ///
  /// Added in Mastodon 4.5.0.
  @override
  final MastodonQuoteApproval? quoteApproval;

  /// Collections this status has been tagged into.
  ///
  /// Added in Mastodon 4.6.0.
  @JsonKey(defaultValue: <MastodonCollection>[])
  @override
  final List<MastodonCollection> taggedCollections;
}

/// Quote relationship attached to a status (Mastodon 4.5.0+).
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonQuote with _$MastodonQuote {
  const MastodonQuote({
    required this.state,
    this.quotedStatus,
    this.quotedStatusId,
  });

  factory MastodonQuote.fromJson(Map<String, dynamic> json) =>
      _$MastodonQuoteFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonQuoteToJson(this);

  /// State of the quote relationship.
  @JsonKey(unknownEnumValue: MastodonQuoteState.unknown)
  @override
  final MastodonQuoteState state;

  /// Quoted status when the response embeds the visible status.
  @override
  final MastodonStatus? quotedStatus;

  /// ID of the quoted status in shallow nested contexts.
  @override
  final String? quotedStatusId;
}

/// Application that published a status.
///
/// A reduced form of `MastodonApplication` carrying only the fields the
/// status API exposes; client credentials and registration details are not
/// disclosed for other users' statuses.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusApplication with _$MastodonStatusApplication {
  const MastodonStatusApplication({required this.name, this.website});

  factory MastodonStatusApplication.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusApplicationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonStatusApplicationToJson(this);

  /// Name of the application.
  @JsonKey(defaultValue: '')
  @override
  final String name;

  /// Website URL of the application. Null if the application declared none.
  @override
  final String? website;
}

/// Quote approval policy of a status (Mastodon 4.5.0+).
///
/// [automatic] and [manual] each list the visibility scopes (e.g. `public`,
/// `followers`) whose members may quote the status without approval or with
/// manual approval, respectively.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonQuoteApproval with _$MastodonQuoteApproval {
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
  @override
  final List<String> automatic;

  /// Visibility scopes whose members may quote with manual approval.
  @JsonKey(defaultValue: <String>[])
  @override
  final List<String> manual;

  /// Whether the authenticated user may quote this status
  /// (e.g. `automatic`, `manual`, `denied`). Null for unauthenticated
  /// requests.
  @override
  final String? currentUser;
}
