import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';
import 'mastodon_status.dart';

part 'mastodon_notification.g.dart';

/// 通知の種別
///
/// Mastodon の標準通知タイプを網羅する。
/// Fedibird 固有のタイプ（`emoji_reaction` 等）は [unknown] として扱われる。
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonNotificationType {
  /// 自分の投稿がメンションされた
  mention,

  /// フォロー中のユーザーが投稿した（Mastodon 3.3+）
  status,

  /// 自分の投稿がブーストされた
  reblog,

  /// フォローされた
  follow,

  /// フォローリクエストを受け取った
  followRequest,

  /// 自分の投稿がお気に入りされた
  favourite,

  /// 自分が参加した投票が終了した
  poll,

  /// 自分の投稿が編集された（Mastodon 3.5+）
  update,

  /// 管理者向け：新規ユーザー登録（Mastodon 3.5+）
  @JsonValue('admin.sign_up')
  adminSignUp,

  /// 管理者向け：通報を受け取った（Mastodon 4.0+）
  @JsonValue('admin.report')
  adminReport,

  /// フォロー関係が強制解除された（Mastodon 4.3+）
  severedRelationships,

  /// モデレーション警告を受け取った（Mastodon 4.3+）
  moderationWarning,

  /// 自分の投稿が引用された（Mastodon 4.5+ / FEP-044f）
  quote,

  /// 引用した投稿が更新された（Mastodon 4.5+ / FEP-044f）
  quotedUpdate,

  /// 未知または将来追加される通知タイプ
  unknown,
}

/// フォロー関係の強制解除イベント（Mastodon 4.3+）
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonRelationshipSeveranceEvent {
  const MastodonRelationshipSeveranceEvent({
    required this.id,
    required this.type,
    required this.purged,
    required this.targetName,
    required this.followersCount,
    required this.followingCount,
    this.createdAt,
  });

  factory MastodonRelationshipSeveranceEvent.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonRelationshipSeveranceEventFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() =>
      _$MastodonRelationshipSeveranceEventToJson(this);

  final String id;

  /// イベントの種別（`domain_block` / `user_domain_block` / `account_suspension`）
  final String type;

  /// アカウントが削除されたかどうか
  @JsonKey(defaultValue: false)
  final bool purged;

  /// 解除されたドメインまたはアカウント名
  final String targetName;

  /// 影響を受けたフォロワー数
  @JsonKey(defaultValue: 0)
  final int followersCount;

  /// 影響を受けたフォロー数
  @JsonKey(defaultValue: 0)
  final int followingCount;

  @SafeDateTimeConverter()
  final DateTime? createdAt;
}

/// モデレーション警告（Mastodon 4.3+）
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAccountWarning {
  const MastodonAccountWarning({
    required this.id,
    required this.action,
    required this.text,
    required this.appeal,
    this.createdAt,
  });

  factory MastodonAccountWarning.fromJson(Map<String, dynamic> json) =>
      _$MastodonAccountWarningFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonAccountWarningToJson(this);

  static Object? _readAppeal(Map<dynamic, dynamic> json, String key) =>
      json['appeal'] != null;

  final String id;

  /// 警告の種別（`none` / `disable` / `mark_statuses_as_sensitive` 等）
  final String action;

  /// 警告の本文
  @JsonKey(defaultValue: '')
  final String text;

  /// 異議申し立てが存在するかどうか
  @JsonKey(readValue: _readAppeal, defaultValue: false)
  final bool appeal;

  /// 通知の作成日時
  @SafeDateTimeConverter()
  final DateTime? createdAt;
}

/// Mastodonの通知
///
/// `/api/v1/notifications` のレスポンスに対応する
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotification {
  const MastodonNotification({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.account,
    this.status,
    this.relationshipSeveranceEvent,
    this.moderationWarning,
  });

  factory MastodonNotification.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonNotificationToJson(this);

  static Object? _readType(Map<dynamic, dynamic> json, String key) =>
      json['type'] ?? 'unknown';

  /// 通知の内ID
  final String id;

  /// 通知の種別
  @JsonKey(
    readValue: _readType,
    unknownEnumValue: MastodonNotificationType.unknown,
  )
  final MastodonNotificationType type;

  /// 通知の作成日時
  final DateTime createdAt;

  /// 通知を発生させたアカウント
  final MastodonAccount account;

  /// 関連する投稿 種別によってはnull
  final MastodonStatus? status;

  /// フォロー関係強制解除イベントの詳細
  ///
  /// [MastodonNotificationType.severedRelationships] の場合のみ非null
  final MastodonRelationshipSeveranceEvent? relationshipSeveranceEvent;

  /// モデレーション警告の詳細 [MastodonNotificationType.moderationWarning] の場合のみ非 null
  final MastodonAccountWarning? moderationWarning;
}
