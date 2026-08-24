import 'package:freezed_annotation/freezed_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_custom_emoji.dart';
import 'mastodon_media_attachment.dart';

part 'mastodon_status_edit.freezed.dart';
part 'mastodon_status_edit.g.dart';

/// Revision of a status edit.
///
/// Corresponds to an element of the response from `GET /api/v1/statuses/:id/history`.
/// Holds the status content at the time of each revision.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusEdit with _$MastodonStatusEdit {
  const MastodonStatusEdit({
    required this.content,
    required this.spoilerText,
    required this.sensitive,
    required this.createdAt,
    required this.account,
    required this.mediaAttachments,
    required this.emojis,
    this.poll,
  });

  factory MastodonStatusEdit.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusEditFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonStatusEditToJson(this);

  /// Body text of the status at revision time (HTML format).
  @JsonKey(defaultValue: '')
  @override
  final String content;

  /// Content warning text at revision time.
  @JsonKey(defaultValue: '')
  @override
  final String spoilerText;

  /// Whether the status was marked as sensitive at revision time.
  @JsonKey(defaultValue: false)
  @override
  final bool sensitive;

  /// Timestamp when the revision was published.
  @override
  final DateTime createdAt;

  /// Account that published the revision.
  @override
  final MastodonAccount account;

  /// List of media attachments at revision time.
  @JsonKey(defaultValue: <MastodonMediaAttachment>[])
  @override
  final List<MastodonMediaAttachment> mediaAttachments;

  /// List of custom emojis at revision time.
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  @override
  final List<MastodonCustomEmoji> emojis;

  /// Poll at revision time. `null` if no poll.
  @override
  final MastodonStatusEditPoll? poll;
}

/// Poll snapshot within the edit history.
///
/// Unlike `MastodonPoll`, this is an options-only structure without vote
/// results.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusEditPoll with _$MastodonStatusEditPoll {
  const MastodonStatusEditPoll({required this.options});

  factory MastodonStatusEditPoll.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusEditPollFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonStatusEditPollToJson(this);

  /// List of poll options.
  @JsonKey(defaultValue: <MastodonStatusEditPollOption>[])
  @override
  final List<MastodonStatusEditPollOption> options;
}

/// Poll option within the edit history.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonStatusEditPollOption with _$MastodonStatusEditPollOption {
  const MastodonStatusEditPollOption({required this.title});

  factory MastodonStatusEditPollOption.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusEditPollOptionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonStatusEditPollOptionToJson(this);

  /// Text of the option.
  @override
  final String title;
}
