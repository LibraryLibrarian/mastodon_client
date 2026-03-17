import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_conversation.g.dart';

/// ダイレクトメッセージの会話
///
/// `/api/v1/conversations` のレスポンスに対応する
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonConversation {
  const MastodonConversation({
    required this.id,
    required this.unread,
    required this.accounts,
    this.lastStatus,
  });

  factory MastodonConversation.fromJson(Map<String, dynamic> json) =>
      _$MastodonConversationFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonConversationToJson(this);

  /// 会話の内部 ID
  final String id;

  /// 未読かどうか
  @JsonKey(defaultValue: false)
  final bool unread;

  /// 会話に参加しているアカウントの一覧
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;

  /// 会話内の最新の投稿。存在しない場合は `null`
  final MastodonStatus? lastStatus;
}
