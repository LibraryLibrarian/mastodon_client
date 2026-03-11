/// 2つのアカウント間のリレーションシップ（フォロー・ブロック・ミュート等の関係）
class MastodonRelationship {
  /// 各フィールドを指定して [MastodonRelationship] を生成する
  const MastodonRelationship({
    required this.id,
    required this.following,
    required this.showingReblogs,
    required this.notifying,
    required this.followedBy,
    required this.blocking,
    required this.blockedBy,
    required this.muting,
    required this.mutingNotifications,
    required this.requested,
    required this.requestedBy,
    required this.domainBlocking,
    required this.endorsed,
    required this.note,
    this.languages,
  });

  /// JSON マップから [MastodonRelationship] を生成する
  factory MastodonRelationship.fromJson(Map<String, dynamic> json) {
    return MastodonRelationship(
      id: json['id'] as String,
      following: json['following'] as bool? ?? false,
      showingReblogs: json['showing_reblogs'] as bool? ?? true,
      notifying: json['notifying'] as bool? ?? false,
      languages: (json['languages'] as List<dynamic>?)?.cast<String>(),
      followedBy: json['followed_by'] as bool? ?? false,
      blocking: json['blocking'] as bool? ?? false,
      blockedBy: json['blocked_by'] as bool? ?? false,
      muting: json['muting'] as bool? ?? false,
      mutingNotifications: json['muting_notifications'] as bool? ?? false,
      requested: json['requested'] as bool? ?? false,
      requestedBy: json['requested_by'] as bool? ?? false,
      domainBlocking: json['domain_blocking'] as bool? ?? false,
      endorsed: json['endorsed'] as bool? ?? false,
      note: json['note'] as String? ?? '',
    );
  }

  /// 対象アカウントの ID
  final String id;

  /// このアカウントをフォローしているかどうか
  final bool following;

  /// このアカウントのブースト投稿をホームタイムラインに表示するかどうか
  final bool showingReblogs;

  /// このアカウントの通知を有効にしているかどうか
  final bool notifying;

  /// このアカウントからフォローしている言語のリスト（ISO 639-1）
  final List<String>? languages;

  /// このアカウントにフォローされているかどうか
  final bool followedBy;

  /// このアカウントをブロックしているかどうか
  final bool blocking;

  /// このアカウントにブロックされているかどうか
  final bool blockedBy;

  /// このアカウントをミュートしているかどうか
  final bool muting;

  /// このアカウントからの通知をミュートしているかどうか
  final bool mutingNotifications;

  /// このアカウントへのフォローリクエストが保留中かどうか
  final bool requested;

  /// このアカウントからのフォローリクエストが保留中かどうか
  final bool requestedBy;

  /// このアカウントのドメインをブロックしているかどうか
  final bool domainBlocking;

  /// このアカウントをプロフィールで紹介しているかどうか
  final bool endorsed;

  /// このアカウントに設定したプライベートメモ
  final String note;
}
