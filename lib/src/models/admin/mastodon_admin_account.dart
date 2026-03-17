import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';
import '../mastodon_account.dart';

part 'mastodon_admin_account.g.dart';

/// 管理者向けアカウント情報
///
/// Admin API のレスポンスで返されるアカウント情報。
/// 通常の [MastodonAccount] に加え、管理者向けの詳細情報を含む。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminAccount {
  const MastodonAdminAccount({
    required this.id,
    required this.username,
    this.domain,
    this.createdAt,
    this.email,
    this.ip,
    this.ips = const [],
    this.locale,
    this.inviteRequest,
    this.role,
    this.confirmed = false,
    this.approved = false,
    this.disabled = false,
    this.sensitized = false,
    this.silenced = false,
    this.suspended = false,
    this.account,
    this.createdByApplicationId,
    this.invitedByAccountId,
  });

  factory MastodonAdminAccount.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminAccountFromJson(json);

  /// アカウントのデータベース内 ID
  final String id;

  /// ユーザー名
  final String username;

  /// アカウントのドメイン（ローカルアカウントの場合は null）
  final String? domain;

  /// アカウントの作成日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// アカウントに紐づくメールアドレス
  @JsonKey(defaultValue: '')
  final String? email;

  /// 最後にログインに使用された IP アドレス
  final String? ip;

  /// このアカウントに関連する全 IP アドレスの履歴
  @JsonKey(defaultValue: <MastodonAdminIp>[])
  final List<MastodonAdminIp> ips;

  /// アカウントのロケール（ISO 639-1 言語コード）
  final String? locale;

  /// 招待リクエスト時に入力された理由
  final String? inviteRequest;

  /// アカウントの現在のロール
  final MastodonAdminRole? role;

  /// メールアドレスが確認済みかどうか
  @JsonKey(defaultValue: false)
  final bool confirmed;

  /// アカウントが承認済みかどうか
  @JsonKey(defaultValue: false)
  final bool approved;

  /// アカウントが無効化されているかどうか
  @JsonKey(defaultValue: false)
  final bool disabled;

  /// アカウントがセンシティブ指定されているかどうか
  @JsonKey(defaultValue: false)
  final bool sensitized;

  /// アカウントがサイレンスされているかどうか
  @JsonKey(defaultValue: false)
  final bool silenced;

  /// アカウントが凍結されているかどうか
  @JsonKey(defaultValue: false)
  final bool suspended;

  /// ユーザーレベルのアカウント情報
  final MastodonAccount? account;

  /// このアカウントを作成したアプリケーションの ID
  final String? createdByApplicationId;

  /// このユーザーを招待したアカウントの ID
  final String? invitedByAccountId;
}

/// 管理者向け IP アドレス情報
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminIp {
  const MastodonAdminIp({
    required this.ip,
    this.usedAt,
  });

  factory MastodonAdminIp.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminIpFromJson(json);

  /// IP アドレス
  final String ip;

  /// この IP アドレスが最後に使用された日時
  @SafeDateTimeConverter()
  final DateTime? usedAt;
}

/// 管理者向けロール情報
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAdminRole {
  const MastodonAdminRole({
    required this.id,
    required this.name,
    this.color,
    this.position,
    this.permissions,
    this.highlighted = false,
    this.createdAt,
    this.updatedAt,
  });

  factory MastodonAdminRole.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminRoleFromJson(json);

  /// ロールの ID
  final int id;

  /// ロール名
  final String name;

  /// ロールのカラーコード
  @JsonKey(defaultValue: '')
  final String? color;

  /// ロールの優先順位
  final int? position;

  /// ロールの権限ビットマスク
  final String? permissions;

  /// ロールをバッジとして表示するかどうか
  @JsonKey(defaultValue: false)
  final bool highlighted;

  /// ロールの作成日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// ロールの最終更新日時
  @SafeDateTimeConverter()
  final DateTime? updatedAt;
}
