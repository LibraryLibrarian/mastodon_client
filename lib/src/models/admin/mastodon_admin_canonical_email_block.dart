import 'package:json_annotation/json_annotation.dart';

part 'mastodon_admin_canonical_email_block.g.dart';

/// 管理者向け正規化メールブロック情報
///
/// 正規化されたメールアドレスのハッシュによるブロック情報。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminCanonicalEmailBlock {
  const MastodonAdminCanonicalEmailBlock({
    required this.id,
    required this.canonicalEmailHash,
  });

  factory MastodonAdminCanonicalEmailBlock.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonAdminCanonicalEmailBlockFromJson(json);

  /// ブロックのデータベース内 ID
  final String id;

  /// 正規化されたメールアドレスの SHA256 ハッシュ
  final String canonicalEmailHash;
}
