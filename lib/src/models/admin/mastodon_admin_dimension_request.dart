/// 管理者向けディメンションデータ取得リクエスト
///
/// `POST /api/v1/admin/dimensions` のリクエストボディ。
class MastodonAdminDimensionRequest {
  /// [MastodonAdminDimensionRequest] を生成する
  const MastodonAdminDimensionRequest({
    required this.keys,
    this.startAt,
    this.endAt,
    this.limit,
    this.tagServersId,
    this.tagLanguagesId,
    this.instanceAccountsDomain,
    this.instanceLanguagesDomain,
  });

  /// 取得するディメンションのキーリスト
  ///
  /// 有効な値: `languages`, `sources`, `servers`, `space_usage`,
  /// `software_versions`, `tag_servers`, `tag_languages`,
  /// `instance_accounts`, `instance_languages`
  final List<String> keys;

  /// 開始日時（時刻部分は無視される）
  final DateTime? startAt;

  /// 終了日時（時刻部分は無視される）
  final DateTime? endAt;

  /// sources/servers/languages 等の最大取得件数
  final int? limit;

  /// `tag_servers` キーに必要なタグ ID
  final String? tagServersId;

  /// `tag_languages` キーに必要なタグ ID
  final String? tagLanguagesId;

  /// `instance_accounts` キーに必要なドメイン
  final String? instanceAccountsDomain;

  /// `instance_languages` キーに必要なドメイン
  final String? instanceLanguagesDomain;

  /// リクエストボディ用の JSON マップに変換する
  Map<String, dynamic> toJson() => {
    'keys': keys,
    'start_at': ?startAt?.toIso8601String(),
    'end_at': ?endAt?.toIso8601String(),
    'limit': ?limit,
    if (tagServersId != null) 'tag_servers': {'id': tagServersId},
    if (tagLanguagesId != null) 'tag_languages': {'id': tagLanguagesId},
    if (instanceAccountsDomain != null)
      'instance_accounts': {'domain': instanceAccountsDomain},
    if (instanceLanguagesDomain != null)
      'instance_languages': {'domain': instanceLanguagesDomain},
  };
}
