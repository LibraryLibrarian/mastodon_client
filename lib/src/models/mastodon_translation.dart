import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_translation.freezed.dart';
part 'mastodon_translation.g.dart';

/// Translation result of a status.
///
/// `POST /api/v1/statuses/:id/translate`
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTranslation with _$MastodonTranslation {
  const MastodonTranslation({
    required this.content,
    required this.spoilerText,
    required this.language,
    required this.detectedSourceLanguage,
    required this.provider,
    required this.mediaAttachments,
    this.poll,
  });

  factory MastodonTranslation.fromJson(Map<String, dynamic> json) =>
      _$MastodonTranslationFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTranslationToJson(this);

  /// Translated body text of the status (HTML format).
  @JsonKey(defaultValue: '')
  @override
  final String content;

  /// Translated content warning text.
  @JsonKey(defaultValue: '')
  @override
  final String spoilerText;

  /// Target language code of the translation.
  @JsonKey(defaultValue: '')
  @override
  final String language;

  /// Source language code auto-detected by the translation provider.
  @JsonKey(defaultValue: '')
  @override
  final String detectedSourceLanguage;

  /// Name of the translation service.
  @JsonKey(defaultValue: '')
  @override
  final String provider;

  /// List of translated media descriptions.
  @JsonKey(defaultValue: <MastodonTranslationAttachment>[])
  @override
  final List<MastodonTranslationAttachment> mediaAttachments;

  /// Translated poll. `null` if no poll.
  @override
  final MastodonTranslationPoll? poll;
}

/// Media attachment information within a translation result.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTranslationAttachment with _$MastodonTranslationAttachment {
  const MastodonTranslationAttachment({
    required this.id,
    required this.description,
  });

  factory MastodonTranslationAttachment.fromJson(Map<String, dynamic> json) =>
      _$MastodonTranslationAttachmentFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTranslationAttachmentToJson(this);

  /// Internal ID of the media.
  @override
  final String id;

  /// Translated alt text.
  @JsonKey(defaultValue: '')
  @override
  final String description;
}

/// Poll information within a translation result.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTranslationPoll with _$MastodonTranslationPoll {
  const MastodonTranslationPoll({required this.id, required this.options});

  factory MastodonTranslationPoll.fromJson(Map<String, dynamic> json) =>
      _$MastodonTranslationPollFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTranslationPollToJson(this);

  /// Internal ID of the poll.
  @override
  final String id;

  /// List of translated options.
  @JsonKey(defaultValue: <MastodonTranslationPollOption>[])
  @override
  final List<MastodonTranslationPollOption> options;
}

/// Poll option within a translation result.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonTranslationPollOption with _$MastodonTranslationPollOption {
  const MastodonTranslationPollOption({required this.title});

  factory MastodonTranslationPollOption.fromJson(Map<String, dynamic> json) =>
      _$MastodonTranslationPollOptionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonTranslationPollOptionToJson(this);

  /// Translated option text.
  @override
  final String title;
}
