/// 投稿の翻訳結果
///
/// `POST /api/v1/statuses/:id/translate`
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

  factory MastodonTranslation.fromJson(Map<String, dynamic> json) {
    return MastodonTranslation(
      content: json['content'] as String? ?? '',
      spoilerText: json['spoiler_text'] as String? ?? '',
      language: json['language'] as String? ?? '',
      detectedSourceLanguage: json['detected_source_language'] as String? ?? '',
      provider: json['provider'] as String? ?? '',
      mediaAttachments:
          (json['media_attachments'] as List<dynamic>?)
              ?.map(
                (m) => MastodonTranslationAttachment.fromJson(
                  m as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      poll: json['poll'] != null
          ? MastodonTranslationPoll.fromJson(
              json['poll'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// 翻訳済みの投稿本文（HTML形式）
  final String content;

  /// 翻訳済みのコンテンツ警告テキスト
  final String spoilerText;

  /// 翻訳先の言語コード
  final String language;

  /// 機械翻訳プロバイダーが自動検出した元の言語コード
  final String detectedSourceLanguage;

  /// 機械翻訳サービスの名前
  final String provider;

  /// 翻訳済みのメディア説明文のリスト
  final List<MastodonTranslationAttachment> mediaAttachments;

  /// 翻訳済みの投票。投票なしの場合は `null`
  final MastodonTranslationPoll? poll;
}

/// 翻訳結果内のメディア添付情報
class MastodonTranslationAttachment {
  const MastodonTranslationAttachment({
    required this.id,
    required this.description,
  });

  factory MastodonTranslationAttachment.fromJson(Map<String, dynamic> json) {
    return MastodonTranslationAttachment(
      id: json['id'] as String,
      description: json['description'] as String? ?? '',
    );
  }

  /// メディアの内部ID
  final String id;

  /// 翻訳済みの代替テキスト
  final String description;
}

/// 翻訳結果内の投票情報
class MastodonTranslationPoll {
  const MastodonTranslationPoll({
    required this.id,
    required this.options,
  });

  factory MastodonTranslationPoll.fromJson(Map<String, dynamic> json) {
    return MastodonTranslationPoll(
      id: json['id'] as String,
      options:
          (json['options'] as List<dynamic>?)
              ?.map(
                (o) => MastodonTranslationPollOption.fromJson(
                  o as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  /// 投票の内部ID
  final String id;

  /// 翻訳済みの選択肢リスト
  final List<MastodonTranslationPollOption> options;
}

/// 翻訳結果内の投票選択肢
class MastodonTranslationPollOption {
  const MastodonTranslationPollOption({required this.title});

  factory MastodonTranslationPollOption.fromJson(Map<String, dynamic> json) {
    return MastodonTranslationPollOption(title: json['title'] as String);
  }

  /// 翻訳済みの選択肢テキスト
  final String title;
}
