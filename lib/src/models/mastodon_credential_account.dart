import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_custom_emoji.dart';

part 'mastodon_credential_account.g.dart';

/// 認証済みユーザー自身のアカウント情報を表すモデル
///
/// [MastodonAccount] の全フィールドに加え、`source`（投稿デフォルト設定）や
/// `role`（ユーザーロール）など、認証済みユーザーにのみ公開される追加情報を含む。
///
/// `/api/v1/accounts/verify_credentials` や `/api/v1/accounts/update_credentials`、
/// `DELETE /api/v1/profile/avatar|header` などのレスポンスに対応する。
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCredentialAccount {
  const MastodonCredentialAccount({
    required this.id,
    required this.username,
    required this.acct,
    required this.displayName,
    required this.note,
    required this.url,
    required this.avatarUrl,
    required this.avatarStaticUrl,
    required this.headerUrl,
    required this.headerStaticUrl,
    required this.locked,
    required this.bot,
    required this.followersCount,
    required this.followingCount,
    required this.statusesCount,
    required this.fields,
    required this.emojis,
    this.discoverable,
    this.noindex,
    this.createdAt,
    this.lastStatusAt,
    this.moved,
    this.suspended,
    this.limited,
    this.hideCollections,
    this.avatarBlurhash,
    this.headerBlurhash,
    this.source,
    this.role,
  });

  factory MastodonCredentialAccount.fromJson(Map<String, dynamic> json) =>
      _$MastodonCredentialAccountFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonCredentialAccountToJson(this);

  /// アカウントの内部 ID
  final String id;

  /// インスタンス内のユーザー名
  final String username;

  /// 完全修飾アカウント名
  final String acct;

  /// 表示名
  @JsonKey(defaultValue: '')
  final String displayName;

  /// プロフィール文（HTML 形式）
  @JsonKey(defaultValue: '')
  final String note;

  /// プロフィールページ URL
  @JsonKey(defaultValue: '')
  final String url;

  /// アバター画像の URL（アニメーション版）
  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatarUrl;

  /// アバター画像の URL（静止画版）
  @JsonKey(name: 'avatar_static', defaultValue: '')
  final String avatarStaticUrl;

  /// ヘッダー画像の URL（アニメーション版）
  @JsonKey(name: 'header', defaultValue: '')
  final String headerUrl;

  /// ヘッダー画像の URL（静止画版）
  @JsonKey(name: 'header_static', defaultValue: '')
  final String headerStaticUrl;

  /// フォロー承認制かどうか
  @JsonKey(defaultValue: false)
  final bool locked;

  /// Bot アカウントかどうか
  @JsonKey(defaultValue: false)
  final bool bot;

  /// ディスカバリー機能への掲載を許可するかどうか
  final bool? discoverable;

  /// 検索エンジンへのインデックスを拒否するかどうか
  final bool? noindex;

  /// フォロワー数
  @JsonKey(defaultValue: 0)
  final int followersCount;

  /// フォロー数
  @JsonKey(defaultValue: 0)
  final int followingCount;

  /// 投稿数
  @JsonKey(defaultValue: 0)
  final int statusesCount;

  /// アカウント作成日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// 最後に投稿した日付
  @SafeDateTimeConverter()
  final DateTime? lastStatusAt;

  /// プロフィールフィールドのリスト
  @JsonKey(defaultValue: <MastodonField>[])
  final List<MastodonField> fields;

  /// カスタム絵文字のリスト
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  final List<MastodonCustomEmoji> emojis;

  /// アカウント移行先
  final MastodonAccount? moved;

  /// 凍結されているかどうか
  final bool? suspended;

  /// 制限されているかどうか
  final bool? limited;

  /// フォロー・フォロワー一覧を非公開にしているかどうか
  final bool? hideCollections;

  /// アバター画像の blurhash
  final String? avatarBlurhash;

  /// ヘッダー画像の blurhash
  final String? headerBlurhash;

  /// 投稿のデフォルト設定やフォローリクエスト数などの非公開情報
  final MastodonAccountSource? source;

  /// ユーザーロール情報
  final MastodonRole? role;
}

/// 認証済みユーザーの投稿デフォルト設定・非公開情報
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccountSource {
  const MastodonAccountSource({
    this.privacy,
    this.sensitive,
    this.language,
    this.note,
    this.fields,
    this.followRequestsCount,
    this.quotePolicy,
  });

  factory MastodonAccountSource.fromJson(Map<String, dynamic> json) =>
      _$MastodonAccountSourceFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonAccountSourceToJson(this);

  /// デフォルトの投稿公開範囲
  final String? privacy;

  /// デフォルトでセンシティブフラグを付けるかどうか
  final bool? sensitive;

  /// デフォルトの投稿言語（ISO 639-1 形式）
  final String? language;

  /// プロフィール文（プレーンテキスト形式）
  final String? note;

  /// プロフィールフィールド（プレーンテキスト形式）
  @JsonKey(defaultValue: <MastodonField>[])
  final List<MastodonField>? fields;

  /// 未処理のフォローリクエスト数
  @JsonKey(defaultValue: 0)
  final int? followRequestsCount;

  /// デフォルトの引用承認ポリシー
  final String? quotePolicy;
}

/// ユーザーロール情報
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonRole {
  const MastodonRole({
    required this.id,
    required this.name,
    this.permissions,
    this.color,
    this.highlighted,
    this.createdAt,
    this.updatedAt,
  });

  factory MastodonRole.fromJson(Map<String, dynamic> json) =>
      _$MastodonRoleFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonRoleToJson(this);

  /// ロール ID
  final int id;

  /// ロール名
  final String name;

  /// 権限ビットマスク（文字列形式）
  final String? permissions;

  /// ロールバッジの色
  @JsonKey(defaultValue: '')
  final String? color;

  /// ロールバッジを表示するかどうか
  final bool? highlighted;

  /// ロール作成日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// ロール更新日時
  @SafeDateTimeConverter()
  final DateTime? updatedAt;
}
