/// 管理者向け IP ブロック作成リクエスト
///
/// `POST /api/v1/admin/ip_blocks` のリクエストボディ。
/// `severity` は公式ドキュメントで必須パラメータのため非 nullable。
class MastodonAdminIpBlockCreateRequest {
  /// [MastodonAdminIpBlockCreateRequest] を生成する
  const MastodonAdminIpBlockCreateRequest({
    required this.severity,
    this.ip,
    this.comment,
    this.expiresIn,
  });

  /// ブロック対象の IP アドレス範囲（CIDR 表記）
  final String? ip;

  /// 制限レベル（`sign_up_requires_approval` / `sign_up_block` / `no_access`）
  final String severity;

  /// ブロックの理由
  final String? comment;

  /// 有効期限（秒）。未指定で無期限
  final int? expiresIn;

  /// リクエストボディ用の JSON マップに変換する
  Map<String, dynamic> toJson() => {
    'ip': ?ip,
    'severity': severity,
    'comment': ?comment,
    'expires_in': ?expiresIn,
  };
}

/// 管理者向け IP ブロック更新リクエスト
///
/// `PUT /api/v1/admin/ip_blocks/:id` のリクエストボディ。
/// すべてのフィールドは任意（部分更新可能）。
class MastodonAdminIpBlockUpdateRequest {
  /// [MastodonAdminIpBlockUpdateRequest] を生成する
  const MastodonAdminIpBlockUpdateRequest({
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
