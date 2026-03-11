import 'package:json_annotation/json_annotation.dart';

part 'mastodon_translation.g.dart';

/// 投稿の翻訳結果
///
/// `POST /api/v1/statuses/:id/translate`
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonTranslation {
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

  /// 翻訳済みの投稿本文（HTML形式）
  @JsonKey(defaultValue: '')
  final String content;

  /// 翻訳済みのコンテンツ警告テキスト
  @JsonKey(defaultValue: '')
  final String spoilerText;

  /// 翻訳先の言語コード
  @JsonKey(defaultValue: '')
  final String language;

  /// 機械翻訳プロバイダーが自動検出した元の言語コード
  @JsonKey(defaultValue: '')
  final String detectedSourceLanguage;

  /// 機械翻訳サービスの名前
  @JsonKey(defaultValue: '')
  final String provider;

  /// 翻訳済みのメディア説明文のリスト
  @JsonKey(defaultValue: <MastodonTranslationAttachment>[])
  final List<MastodonTranslationAttachment> mediaAttachments;

  /// 翻訳済みの投票。投票なしの場合は `null`
  final MastodonTranslationPoll? poll;
}

/// 翻訳結果内のメディア添付情報
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonTranslationAttachment {
  const MastodonTranslationAttachment({
    required this.id,
    required this.description,
  });

  factory MastodonTranslationAttachment.fromJson(Map<String, dynamic> json) =>
      _$MastodonTranslationAttachmentFromJson(json);

  /// メディアの内部ID
  final String id;

  /// 翻訳済みの代替テキスト
  @JsonKey(defaultValue: '')
  final String description;
}

/// 翻訳結果内の投票情報
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonTranslationPoll {
  const MastodonTranslationPoll({
    required this.id,
    required this.options,
  });

  factory MastodonTranslationPoll.fromJson(Map<String, dynamic> json) =>
      _$MastodonTranslationPollFromJson(json);

  /// 投票の内部ID
  final String id;

  /// 翻訳済みの選択肢リスト
  @JsonKey(defaultValue: <MastodonTranslationPollOption>[])
  final List<MastodonTranslationPollOption> options;
}

/// 翻訳結果内の投票選択肢
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonTranslationPollOption {
  const MastodonTranslationPollOption({required this.title});

  factory MastodonTranslationPollOption.fromJson(Map<String, dynamic> json) =>
      _$MastodonTranslationPollOptionFromJson(json);

  /// 翻訳済みの選択肢テキスト
  final String title;
}
