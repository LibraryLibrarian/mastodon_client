import 'package:json_annotation/json_annotation.dart';

part 'mastodon_partial_account.g.dart';

/// 部分的なアカウント情報
///
/// グループ化通知APIで返される、必要最低限のアカウント情報を表すモデル。
/// `expand_accounts=partial_avatars` を指定した場合に使用される。
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

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonPartialAccountToJson(this);

  /// アカウントID
  final String id;

  /// アカウントのアドレス（`user@domain` 形式）
  final String acct;

  /// アカウントのプロフィールURL
  final String url;

  /// アバター画像のURL
  final String avatar;

  /// アバター画像の静的URL（GIFアニメーションなしバージョン）
  final String avatarStatic;

  /// アカウントがロックされているかどうか
  @JsonKey(defaultValue: false)
  final bool locked;

  /// アカウントがBotかどうか
  @JsonKey(defaultValue: false)
  final bool bot;
}
