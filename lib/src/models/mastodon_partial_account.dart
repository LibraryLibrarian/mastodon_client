import 'package:json_annotation/json_annotation.dart';

part 'mastodon_partial_account.g.dart';

/// Partial account information.
///
/// Model representing minimal account information returned by the grouped
/// notifications API. Used when `expand_accounts=partial_avatars` is specified.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPartialAccount {
  const MastodonPartialAccount({
    required this.id,
    required this.acct,
    required this.url,
    required this.avatar,
    required this.avatarStatic,
    required this.locked,
    required this.bot,
  });

  factory MastodonPartialAccount.fromJson(Map<String, dynamic> json) =>
      _$MastodonPartialAccountFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonPartialAccountToJson(this);

  /// Account ID.
  final String id;

  /// Account address (`user@domain` format).
  final String acct;

  /// Profile URL of the account.
  final String url;

  /// URL of the avatar image.
  final String avatar;

  /// Static URL of the avatar image (non-animated version).
  final String avatarStatic;

  /// Whether the account is locked.
  @JsonKey(defaultValue: false)
  final bool locked;

  /// Whether the account is a bot.
  @JsonKey(defaultValue: false)
  final bool bot;
}
