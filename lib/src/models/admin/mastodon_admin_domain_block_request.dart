/// 管理者向けドメインブロック作成・更新リクエスト
///
/// `POST /api/v1/admin/domain_blocks` および
/// `PUT /api/v1/admin/domain_blocks/:id` のリクエストボディ。
class MastodonAdminDomainBlockRequest {
  /// [MastodonAdminDomainBlockRequest] を生成する
  const MastodonAdminDomainBlockRequest({
    this.domain,
    this.severity,
    this.rejectMedia,
    this.rejectReports,
    this.privateComment,
    this.publicComment,
    this.obfuscate,
  });

  /// ブロック対象のドメイン（作成時は必須）
  final String? domain;

  /// 制限レベル（`silence` / `suspend` / `noop`）デフォルト: `silence`
  final String? severity;

  /// メディア添付を拒否するかどうか
  final bool? rejectMedia;

  /// 通報を拒否するかどうか
  final bool? rejectReports;

  /// 管理者向け非公開コメント
  final String? privateComment;

  /// 一般公開用コメント
  final String? publicComment;

  /// 公開表示時にドメイン名を難読化するかどうか
  final bool? obfuscate;

  /// リクエストボディ用の JSON マップに変換する
  Map<String, dynamic> toJson() => {
    'domain': ?domain,
    'severity': ?severity,
    'reject_media': ?rejectMedia,
    'reject_reports': ?rejectReports,
    'private_comment': ?privateComment,
    'public_comment': ?publicComment,
    'obfuscate': ?obfuscate,
  };
}
