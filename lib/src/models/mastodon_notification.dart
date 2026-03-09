import 'mastodon_account.dart';
import 'mastodon_status.dart';

/// 通知の種別
///
/// Mastodon の標準通知タイプを網羅する。
/// Fedibird 固有のタイプ（`emoji_reaction` 等）は [unknown] として扱われる。
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
  adminSignUp,

  /// 管理者向け：通報を受け取った（Mastodon 4.0+）
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
  unknown
  ;

  static MastodonNotificationType fromString(String value) {
    return switch (value) {
      'mention' => MastodonNotificationType.mention,
      'status' => MastodonNotificationType.status,
      'reblog' => MastodonNotificationType.reblog,
      'follow' => MastodonNotificationType.follow,
      'follow_request' => MastodonNotificationType.followRequest,
      'favourite' => MastodonNotificationType.favourite,
      'poll' => MastodonNotificationType.poll,
      'update' => MastodonNotificationType.update,
      'admin.sign_up' => MastodonNotificationType.adminSignUp,
      'admin.report' => MastodonNotificationType.adminReport,
      'severed_relationships' => MastodonNotificationType.severedRelationships,
      'moderation_warning' => MastodonNotificationType.moderationWarning,
      'quote' => MastodonNotificationType.quote,
      'quoted_update' => MastodonNotificationType.quotedUpdate,
      _ => MastodonNotificationType.unknown,
    };
  }
}

/// フォロー関係の強制解除イベント（Mastodon 4.3+）
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
  ) {
    return MastodonRelationshipSeveranceEvent(
      id: json['id'] as String,
      type: json['type'] as String,
      purged: json['purged'] as bool? ?? false,
      targetName: json['target_name'] as String,
      followersCount: json['followers_count'] as int? ?? 0,
      followingCount: json['following_count'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }

  final String id;

  /// イベントの種別（`domain_block` / `user_domain_block` / `account_suspension`）
  final String type;

  /// アカウントが削除されたかどうか
  final bool purged;

  /// 解除されたドメインまたはアカウント名
  final String targetName;

  /// 影響を受けたフォロワー数
  final int followersCount;

  /// 影響を受けたフォロー数
  final int followingCount;

  final DateTime? createdAt;
}

/// モデレーション警告（Mastodon 4.3+）
class MastodonAccountWarning {
  const MastodonAccountWarning({
    required this.id,
    required this.action,
    required this.text,
    required this.appeal,
    this.createdAt,
  });

  factory MastodonAccountWarning.fromJson(Map<String, dynamic> json) {
    return MastodonAccountWarning(
      id: json['id'] as String,
      action: json['action'] as String,
      text: json['text'] as String? ?? '',
      appeal: json['appeal'] != null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }

  final String id;

  /// 警告の種別（`none` / `disable` / `mark_statuses_as_sensitive` 等）
  final String action;

  /// 警告の本文
  final String text;

  /// 異議申し立てが存在するかどうか
  final bool appeal;

  /// 通知の作成日時
  final DateTime? createdAt;
}

/// Mastodonの通知
///
/// `/api/v1/notifications` のレスポンスに対応する
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

  factory MastodonNotification.fromJson(Map<String, dynamic> json) {
    return MastodonNotification(
      id: json['id'] as String,
      type: MastodonNotificationType.fromString(
        json['type'] as String? ?? '',
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      account: MastodonAccount.fromJson(
        json['account'] as Map<String, dynamic>,
      ),
      status: json['status'] != null
          ? MastodonStatus.fromJson(json['status'] as Map<String, dynamic>)
          : null,
      relationshipSeveranceEvent: json['relationship_severance_event'] != null
          ? MastodonRelationshipSeveranceEvent.fromJson(
              json['relationship_severance_event'] as Map<String, dynamic>,
            )
          : null,
      moderationWarning: json['moderation_warning'] != null
          ? MastodonAccountWarning.fromJson(
              json['moderation_warning'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// 通知の内ID
  final String id;

  /// 通知の種別
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
