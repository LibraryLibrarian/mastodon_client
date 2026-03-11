import 'mastodon_account.dart';
import 'mastodon_custom_emoji.dart';
import 'mastodon_media_attachment.dart';
import 'mastodon_poll.dart';

/// 投稿の編集リビジョン
///
/// `GET /api/v1/statuses/:id/history` のレスポンス要素に対応する
/// 各リビジョンの時点での投稿内容を保持する。
class MastodonStatusEdit {
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

  factory MastodonStatusEdit.fromJson(Map<String, dynamic> json) {
    return MastodonStatusEdit(
      content: json['content'] as String? ?? '',
      spoilerText: json['spoiler_text'] as String? ?? '',
      sensitive: json['sensitive'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      account: MastodonAccount.fromJson(
        json['account'] as Map<String, dynamic>,
      ),
      mediaAttachments:
          (json['media_attachments'] as List<dynamic>?)
              ?.map(
                (m) =>
                    MastodonMediaAttachment.fromJson(m as Map<String, dynamic>),
              )
              .toList() ??
          [],
      emojis:
          (json['emojis'] as List<dynamic>?)
              ?.map(
                (e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      poll: json['poll'] != null
          ? MastodonStatusEditPoll.fromJson(
              json['poll'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// リビジョン時点の投稿本文（HTML形式）
  final String content;

  /// リビジョン時点のコンテンツ警告テキスト
  final String spoilerText;

  /// リビジョン時点でセンシティブとしてマークされていたかどうか
  final bool sensitive;

  /// リビジョンの公開日時
  final DateTime createdAt;

  /// リビジョンを公開したアカウント
  final MastodonAccount account;

  /// リビジョン時点の添付メディアのリスト
  final List<MastodonMediaAttachment> mediaAttachments;

  /// リビジョン時点のカスタム絵文字のリスト
  final List<MastodonCustomEmoji> emojis;

  /// リビジョン時点の投票。投票なしの場合は `null`
  final MastodonStatusEditPoll? poll;
}

/// 編集履歴内の投票スナップショット。
///
/// [MastodonPoll] とは異なり、投票結果を持たない選択肢のみの構造
class MastodonStatusEditPoll {
  const MastodonStatusEditPoll({required this.options});

  factory MastodonStatusEditPoll.fromJson(Map<String, dynamic> json) {
    return MastodonStatusEditPoll(
      options:
          (json['options'] as List<dynamic>?)
              ?.map(
                (o) => MastodonStatusEditPollOption.fromJson(
                  o as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
  }

  /// 投票の選択肢リスト
  final List<MastodonStatusEditPollOption> options;
}

/// 編集履歴内の投票選択肢
class MastodonStatusEditPollOption {
  const MastodonStatusEditPollOption({required this.title});

  factory MastodonStatusEditPollOption.fromJson(Map<String, dynamic> json) {
    return MastodonStatusEditPollOption(title: json['title'] as String);
  }

  /// 選択肢のテキスト
  final String title;
}
