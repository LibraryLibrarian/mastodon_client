import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_custom_emoji.dart';
import 'mastodon_media_attachment.dart';

part 'mastodon_status_edit.g.dart';

/// 投稿の編集リビジョン
///
/// `GET /api/v1/statuses/:id/history` のレスポンス要素に対応する
/// 各リビジョンの時点での投稿内容を保持する。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  factory MastodonStatusEdit.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusEditFromJson(json);

  /// リビジョン時点の投稿本文（HTML形式）
  @JsonKey(defaultValue: '')
  final String content;

  /// リビジョン時点のコンテンツ警告テキスト
  @JsonKey(defaultValue: '')
  final String spoilerText;

  /// リビジョン時点でセンシティブとしてマークされていたかどうか
  @JsonKey(defaultValue: false)
  final bool sensitive;

  /// リビジョンの公開日時
  final DateTime createdAt;

  /// リビジョンを公開したアカウント
  final MastodonAccount account;

  /// リビジョン時点の添付メディアのリスト
  @JsonKey(defaultValue: <MastodonMediaAttachment>[])
  final List<MastodonMediaAttachment> mediaAttachments;

  /// リビジョン時点のカスタム絵文字のリスト
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  final List<MastodonCustomEmoji> emojis;

  /// リビジョン時点の投票。投票なしの場合は `null`
  final MastodonStatusEditPoll? poll;
}

/// 編集履歴内の投票スナップショット。
///
/// `MastodonPoll` とは異なり、投票結果を持たない選択肢のみの構造
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonStatusEditPoll {
  const MastodonStatusEditPoll({required this.options});

  factory MastodonStatusEditPoll.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusEditPollFromJson(json);

  /// 投票の選択肢リスト
  @JsonKey(defaultValue: <MastodonStatusEditPollOption>[])
  final List<MastodonStatusEditPollOption> options;
}

/// 編集履歴内の投票選択肢
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonStatusEditPollOption {
  const MastodonStatusEditPollOption({required this.title});

  factory MastodonStatusEditPollOption.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusEditPollOptionFromJson(json);

  /// 選択肢のテキスト
  final String title;
}
