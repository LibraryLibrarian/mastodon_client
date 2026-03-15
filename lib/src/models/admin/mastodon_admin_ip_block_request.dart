/// 管理者向け IP ブロック作成・更新リクエスト
///
/// `POST /api/v1/admin/ip_blocks` および
/// `PUT /api/v1/admin/ip_blocks/:id` のリクエストボディ。
class MastodonAdminIpBlockRequest {
  /// [MastodonAdminIpBlockRequest] を生成する
  const MastodonAdminIpBlockRequest({
    this.ip,
    this.severity,
    this.comment,
    this.expiresIn,
  });

  /// ブロック対象の IP アドレス範囲（CIDR 表記）
  final String? ip;

  /// 制限レベル（`sign_up_requires_approval` / `sign_up_block` / `no_access`）
  final String? severity;

  /// ブロックの理由
  final String? comment;

  /// 有効期限（秒）。未指定で無期限
  final int? expiresIn;

  /// リクエストボディ用の JSON マップに変換する
  Map<String, dynamic> toJson() => {
    'ip': ?ip,
    'severity': ?severity,
    'comment': ?comment,
    'expires_in': ?expiresIn,
  };
}
