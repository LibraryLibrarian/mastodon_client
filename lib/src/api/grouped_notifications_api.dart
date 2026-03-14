import '../client/mastodon_http_client.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_grouped_notifications_results.dart';

/// グループ化通知に関する API（v2）
///
/// Mastodon 4.3+ で追加されたグループ化通知エンドポイントを提供する。
/// 同一タイプ・同一対象の通知をグループ化して効率的に取得できる。
class GroupedNotificationsApi {
  const GroupedNotificationsApi(this._http);

  final MastodonHttpClient _http;

  /// グループ化された通知一覧を取得
  ///
  /// `GET /api/v2/notifications`
  ///
  /// - [maxId]: このグループキー以前の通知を取得する（古い方向）
  /// - [sinceId]: このグループキー以降の通知を取得する（新しい方向）
  /// - [minId]: このグループキー直後の通知を取得する（新しい方向、即時）
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [types]: 取得対象の通知タイプ一覧
  /// - [excludeTypes]: 取得から除外する通知タイプ一覧
  /// - [accountId]: 特定のアカウントからの通知のみを取得
  /// - [expandAccounts]: アカウント情報の展開方法（`full` または `partial_avatars`）
  /// - [groupedTypes]: グループ化対象の通知タイプ一覧
  /// - [includeFiltered]: フィルタリングされた通知を含めるかどうか
  Future<MastodonGroupedNotificationsResults> fetch({
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
    List<String>? types,
    List<String>? excludeTypes,
    String? accountId,
    String? expandAccounts,
    List<String>? groupedTypes,
    bool? includeFiltered,
  }) async {
    final query = <String, dynamic>{
      if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
      if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
      if (minId != null && minId.isNotEmpty) 'min_id': minId,
      'limit': ?limit,
      if (types != null && types.isNotEmpty) 'types[]': types,
      if (excludeTypes != null && excludeTypes.isNotEmpty)
        'exclude_types[]': excludeTypes,
      if (accountId != null && accountId.isNotEmpty) 'account_id': accountId,
      if (expandAccounts != null && expandAccounts.isNotEmpty)
        'expand_accounts': expandAccounts,
      if (groupedTypes != null && groupedTypes.isNotEmpty)
        'grouped_types[]': groupedTypes,
      'include_filtered': ?includeFiltered,
    };
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/notifications',
      queryParameters: query,
    );
    return MastodonGroupedNotificationsResults.fromJson(data!);
  }

  /// 指定グループキーの通知グループを取得
  ///
  /// `GET /api/v2/notifications/:group_key`
  ///
  /// - [groupKey]: 取得する通知グループのキー
  Future<MastodonGroupedNotificationsResults> fetchByGroupKey(
    String groupKey,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/notifications/$groupKey',
    );
    return MastodonGroupedNotificationsResults.fromJson(data!);
  }

  /// 指定グループキーの通知を削除
  ///
  /// `POST /api/v2/notifications/:group_key/dismiss`
  ///
  /// - [groupKey]: 削除する通知グループのキー
  Future<void> dismiss(String groupKey) async {
    await _http.send<dynamic>(
      '/api/v2/notifications/$groupKey/dismiss',
      method: 'POST',
    );
  }

  /// 指定グループキーの通知に関連するアカウント一覧を取得
  ///
  /// `GET /api/v2/notifications/:group_key/accounts`
  ///
  /// - [groupKey]: 取得する通知グループのキー
  Future<List<MastodonAccount>> fetchAccounts(String groupKey) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v2/notifications/$groupKey/accounts',
    );
    return (data ?? [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList(growable: false);
  }

  /// 未読通知グループの件数を取得
  ///
  /// `GET /api/v2/notifications/unread_count`
  ///
  /// - [limit]: カウントの上限。省略時はサーバーのデフォルト値が適用される
  /// - [types]: 集計対象の通知タイプ一覧
  /// - [excludeTypes]: 集計から除外する通知タイプ一覧
  /// - [accountId]: 特定のアカウントからの通知のみを集計
  /// - [groupedTypes]: グループ化対象の通知タイプ一覧
  Future<int> fetchUnreadCount({
    int? limit,
    List<String>? types,
    List<String>? excludeTypes,
    String? accountId,
    List<String>? groupedTypes,
  }) async {
    final query = <String, dynamic>{
      'limit': ?limit,
      if (types != null && types.isNotEmpty) 'types[]': types,
      if (excludeTypes != null && excludeTypes.isNotEmpty)
        'exclude_types[]': excludeTypes,
      if (accountId != null && accountId.isNotEmpty) 'account_id': accountId,
      if (groupedTypes != null && groupedTypes.isNotEmpty)
        'grouped_types[]': groupedTypes,
    };
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/notifications/unread_count',
      queryParameters: query,
    );
    return (data?['count'] as int?) ?? 0;
  }
}
