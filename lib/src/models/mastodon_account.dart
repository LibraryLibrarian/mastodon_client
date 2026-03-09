import 'mastodon_custom_emoji.dart';

/// Mastodon アカウント（ユーザー）を表すモデル
///
/// `/api/v1/accounts/:id` や `/api/v1/accounts/verify_credentials` などの
/// レスポンスに対応する
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
    this.avatarBlurhash,
    this.headerBlurhash,
  });

  factory MastodonAccount.fromJson(Map<String, dynamic> json) {
    return MastodonAccount(
      id: json['id'] as String,
      username: json['username'] as String,
      acct: json['acct'] as String,
      displayName: json['display_name'] as String? ?? '',
      note: json['note'] as String? ?? '',
      url: json['url'] as String? ?? '',
      avatarUrl: json['avatar'] as String? ?? '',
      avatarStaticUrl: json['avatar_static'] as String? ?? '',
      headerUrl: json['header'] as String? ?? '',
      headerStaticUrl: json['header_static'] as String? ?? '',
      locked: json['locked'] as bool? ?? false,
      bot: json['bot'] as bool? ?? false,
      discoverable: json['discoverable'] as bool?,
      noindex: json['noindex'] as bool?,
      followersCount: json['followers_count'] as int? ?? 0,
      followingCount: json['following_count'] as int? ?? 0,
      statusesCount: json['statuses_count'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      lastStatusAt: json['last_status_at'] != null
          ? DateTime.tryParse(json['last_status_at'] as String)
          : null,
      fields:
          (json['fields'] as List<dynamic>?)
              ?.map((f) => MastodonField.fromJson(f as Map<String, dynamic>))
              .toList() ??
          [],
      emojis:
          (json['emojis'] as List<dynamic>?)
              ?.map(
                (e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      moved: json['moved'] != null
          ? MastodonAccount.fromJson(json['moved'] as Map<String, dynamic>)
          : null,
      suspended: json['suspended'] as bool?,
      limited: json['limited'] as bool?,
      avatarBlurhash: json['avatar_blurhash'] as String?,
      headerBlurhash: json['header_blurhash'] as String?,
    );
  }

  /// アカウントの内部 ID
  final String id;

  /// インスタンス内のユーザー名（`@` やホスト部分を含まない）
  final String username;

  /// ユーザーの完全修飾アカウント名。
  /// 同一インスタンスのユーザーは `username` のみ、外部ユーザーは `username@host` の形式。
  final String acct;

  /// 表示名
  final String displayName;

  /// プロフィール文（HTML 形式）
  final String note;

  /// アカウントのプロフィールページ URL
  final String url;

  /// アバター画像の URL（アニメーション版）
  final String avatarUrl;

  /// アバター画像の URL（静止画版）
  final String avatarStaticUrl;

  /// ヘッダー（バナー）画像の URL（アニメーション版）
  final String headerUrl;

  /// ヘッダー（バナー）画像の URL（静止画版）
  final String headerStaticUrl;

  /// フォロー承認制かどうか
  final bool locked;

  /// Bot アカウントかどうか
  final bool bot;

  /// ディスカバリー機能への掲載を許可するかどうか
  final bool? discoverable;

  /// 検索エンジンへのインデックスを拒否するかどうか
  final bool? noindex;

  /// フォロワー数
  final int followersCount;

  /// フォロー数
  final int followingCount;

  /// 投稿数
  final int statusesCount;

  /// アカウント作成日時
  final DateTime? createdAt;

  /// 最後に投稿した日付
  final DateTime? lastStatusAt;

  /// プロフィールに設定されたカスタムフィールドのリスト
  final List<MastodonField> fields;

  /// プロフィールや表示名で使われているカスタム絵文字のリスト
  final List<MastodonCustomEmoji> emojis;

  /// アカウント移行先。移行済みの場合のみ非 null
  final MastodonAccount? moved;

  /// 管理者によって凍結されているかどうか
  final bool? suspended;

  /// 管理者によって制限されているかどうか
  final bool? limited;

  /// アバター画像の blurhash
  final String? avatarBlurhash;

  /// ヘッダー画像の blurhash
  final String? headerBlurhash;
}

/// Mastodon アカウントのプロフィールフィールド
class MastodonField {
  const MastodonField({
    required this.name,
    required this.value,
    this.verifiedAt,
  });

  factory MastodonField.fromJson(Map<String, dynamic> json) {
    return MastodonField(
      name: json['name'] as String,
      value: json['value'] as String,
      verifiedAt: json['verified_at'] != null
          ? DateTime.tryParse(json['verified_at'] as String)
          : null,
    );
  }

  /// フィールドのラベル名
  final String name;

  /// フィールドの値（HTML 形式を含む場合がある）
  final String value;

  /// リンク検証が行われた日時。検証済みの場合のみ非 null
  final DateTime? verifiedAt;
}
