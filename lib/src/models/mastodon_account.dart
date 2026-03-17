import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_custom_emoji.dart';

part 'mastodon_account.g.dart';

/// Mastodon アカウント（ユーザー）を表すモデル
///
/// `/api/v1/accounts/:id` や `/api/v1/accounts/verify_credentials` などの
/// レスポンスに対応する
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccount {
  const MastodonAccount({
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
  });

  factory MastodonAccount.fromJson(Map<String, dynamic> json) =>
      _$MastodonAccountFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonAccountToJson(this);

  /// アカウントの内部 ID
  final String id;

  /// インスタンス内のユーザー名（`@` やホスト部分を含まない）
  final String username;

  /// ユーザーの完全修飾アカウント名。
  /// 同一インスタンスのユーザーは `username` のみ、外部ユーザーは `username@host` の形式。
  final String acct;

  /// 表示名
  @JsonKey(defaultValue: '')
  final String displayName;

  /// プロフィール文（HTML 形式）
  @JsonKey(defaultValue: '')
  final String note;

  /// アカウントのプロフィールページ URL
  @JsonKey(defaultValue: '')
  final String url;

  /// アバター画像の URL（アニメーション版）
  @JsonKey(name: 'avatar', defaultValue: '')
  final String avatarUrl;

  /// アバター画像の URL（静止画版）
  @JsonKey(name: 'avatar_static', defaultValue: '')
  final String avatarStaticUrl;

  /// ヘッダー（バナー）画像の URL（アニメーション版）
  @JsonKey(name: 'header', defaultValue: '')
  final String headerUrl;

  /// ヘッダー（バナー）画像の URL（静止画版）
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

  /// プロフィールに設定されたカスタムフィールドのリスト
  @JsonKey(defaultValue: <MastodonField>[])
  final List<MastodonField> fields;

  /// プロフィールや表示名で使われているカスタム絵文字のリスト
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  final List<MastodonCustomEmoji> emojis;

  /// アカウント移行先。移行済みの場合のみ非 null
  final MastodonAccount? moved;

  /// 管理者によって凍結されているかどうか
  final bool? suspended;

  /// 管理者によって制限されているかどうか
  final bool? limited;

  /// フォロー・フォロワー一覧を非公開にしているかどうか
  ///
  /// Mastodon 4.3.0 で追加
  final bool? hideCollections;

  /// アバター画像の blurhash
  final String? avatarBlurhash;

  /// ヘッダー画像の blurhash
  final String? headerBlurhash;
}

/// Mastodon アカウントのプロフィールフィールド
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonField {
  const MastodonField({
    required this.name,
    required this.value,
    this.verifiedAt,
  });

  factory MastodonField.fromJson(Map<String, dynamic> json) =>
      _$MastodonFieldFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonFieldToJson(this);

  /// フィールドのラベル名
  final String name;

  /// フィールドの値（HTML 形式を含む場合がある）
  final String value;

  /// リンク検証が行われた日時。検証済みの場合のみ非 null
  @SafeDateTimeConverter()
  final DateTime? verifiedAt;
}
