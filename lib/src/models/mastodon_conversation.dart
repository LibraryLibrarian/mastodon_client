import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_conversation.g.dart';

/// Direct message conversation.
///
/// Corresponds to the response from `/api/v1/conversations`.
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

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonConversationToJson(this);

  /// Internal ID of the conversation.
  final String id;

  /// Whether the conversation is unread.
  @JsonKey(defaultValue: false)
  final bool unread;

  /// List of accounts participating in the conversation.
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;

  /// Most recent status in the conversation. `null` if none exists.
  final MastodonStatus? lastStatus;
}
