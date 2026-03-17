import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_domain_allow.g.dart';

/// 管理者向けドメイン許可情報
///
/// フェデレーションが許可されているドメインを表す。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminDomainAllow {
  const MastodonAdminDomainAllow({
    required this.id,
    required this.domain,
    this.createdAt,
  });

  factory MastodonAdminDomainAllow.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminDomainAllowFromJson(json);

  /// ドメイン許可のデータベース内 ID
  final String id;

  /// フェデレーションが許可されているドメイン
  final String domain;

  /// ドメインが許可された日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;
}
