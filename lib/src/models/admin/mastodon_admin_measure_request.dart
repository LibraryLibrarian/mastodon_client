/// 管理者向けメジャーデータ取得リクエスト
///
/// `POST /api/v1/admin/measures` のリクエストボディ。
class MastodonAdminMeasureRequest {
  /// [MastodonAdminMeasureRequest] を生成する
  const MastodonAdminMeasureRequest({
    required this.keys,
    required this.startAt,
    required this.endAt,
    this.tagAccountsId,
    this.tagUsesId,
    this.tagServersId,
    this.instanceAccountsDomain,
    this.instanceMediaAttachmentsDomain,
    this.instanceReportsDomain,
    this.instanceStatusesDomain,
    this.instanceFollowsDomain,
    this.instanceFollowersDomain,
  });

  /// 取得するメジャーのキーリスト
  ///
  /// 有効な値: `active_users`, `new_users`, `interactions`,
  /// `opened_reports`, `resolved_reports`, `tag_accounts`, `tag_uses`,
  /// `tag_servers`, `instance_accounts`, `instance_media_attachments`,
  /// `instance_reports`, `instance_statuses`, `instance_follows`,
  /// `instance_followers`
  final List<String> keys;

  /// 開始日時（時刻部分は無視される）
  final DateTime startAt;

  /// 終了日時（時刻部分は無視される）
  final DateTime endAt;

  /// `tag_accounts` キーに必要なタグ ID
  final String? tagAccountsId;

  /// `tag_uses` キーに必要なタグ ID
  final String? tagUsesId;

  /// `tag_servers` キーに必要なタグ ID
  final String? tagServersId;

  /// `instance_accounts` キーに必要なドメイン
  final String? instanceAccountsDomain;

  /// `instance_media_attachments` キーに必要なドメイン
  final String? instanceMediaAttachmentsDomain;

  /// `instance_reports` キーに必要なドメイン
  final String? instanceReportsDomain;

  /// `instance_statuses` キーに必要なドメイン
  final String? instanceStatusesDomain;

  /// `instance_follows` キーに必要なドメイン
  final String? instanceFollowsDomain;

  /// `instance_followers` キーに必要なドメイン
  final String? instanceFollowersDomain;

  /// リクエストボディ用の JSON マップに変換する
  Map<String, dynamic> toJson() => {
    'keys[]': keys,
    'start_at': startAt.toIso8601String(),
    'end_at': endAt.toIso8601String(),
    if (tagAccountsId != null) 'tag_accounts[id]': tagAccountsId,
    if (tagUsesId != null) 'tag_uses[id]': tagUsesId,
    if (tagServersId != null) 'tag_servers[id]': tagServersId,
    if (instanceAccountsDomain != null)
      'instance_accounts[domain]': instanceAccountsDomain,
    if (instanceMediaAttachmentsDomain != null)
      'instance_media_attachments[domain]': instanceMediaAttachmentsDomain,
    if (instanceReportsDomain != null)
      'instance_reports[domain]': instanceReportsDomain,
    if (instanceStatusesDomain != null)
      'instance_statuses[domain]': instanceStatusesDomain,
    if (instanceFollowsDomain != null)
      'instance_follows[domain]': instanceFollowsDomain,
    if (instanceFollowersDomain != null)
      'instance_followers[domain]': instanceFollowersDomain,
  };
}
