import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_report.dart';
import '../../models/admin/mastodon_admin_report_update_request.dart';

/// 管理者向け通報管理 API
///
/// 通報の一覧取得・担当割り当て・解決・再オープンなどを行う。
/// すべてのエンドポイントに `admin:read:reports` または
/// `admin:write:reports` の OAuth スコープが必要。
class AdminReportsApi {
  const AdminReportsApi(this._http);

  final MastodonHttpClient _http;

  /// すべての通報を取得する
  ///
  /// `GET /api/v1/admin/reports`
  ///
  /// - [resolved]: 解決済みの通報のみに絞り込む
  /// - [accountId]: 通報者のアカウント ID で絞り込む
  /// - [targetAccountId]: 通報対象のアカウント ID で絞り込む
  /// - [maxId]: ページネーション上限 ID
  /// - [sinceId]: ページネーション下限 ID
  /// - [minId]: 前方ページネーション用 ID
  /// - [limit]: 最大取得件数（デフォルト: 100、最大: 200）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAdminReport>> fetch({
    bool? resolved,
    String? accountId,
    String? targetAccountId,
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/reports',
      queryParameters: <String, dynamic>{
        'resolved': ?resolved,
        'account_id': ?accountId,
        'target_account_id': ?targetAccountId,
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'min_id': ?minId,
        'limit': ?limit,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminReport.fromJson)
        .toList();
  }

  /// ID を指定して通報の詳細を取得する
  ///
  /// `GET /api/v1/admin/reports/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminReport> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id',
    );
    return MastodonAdminReport.fromJson(data!);
  }

  /// 通報のメタデータを更新する
  ///
  /// `PUT /api/v1/admin/reports/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminReport> update(
    String id,
    MastodonAdminReportUpdateRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id',
      method: 'PUT',
      data: request.toJson(),
    );
    return MastodonAdminReport.fromJson(data!);
  }

  /// 通報を自分に割り当てる
  ///
  /// `POST /api/v1/admin/reports/{id}/assign_to_self`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminReport> assignToSelf(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id/assign_to_self',
      method: 'POST',
    );
    return MastodonAdminReport.fromJson(data!);
  }

  /// 通報の割り当てを解除する
  ///
  /// `POST /api/v1/admin/reports/{id}/unassign`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminReport> unassign(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id/unassign',
      method: 'POST',
    );
    return MastodonAdminReport.fromJson(data!);
  }

  /// 通報を解決済みにする
  ///
  /// `POST /api/v1/admin/reports/{id}/resolve`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminReport> resolve(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id/resolve',
      method: 'POST',
    );
    return MastodonAdminReport.fromJson(data!);
  }

  /// 解決済みの通報を再オープンする
  ///
  /// `POST /api/v1/admin/reports/{id}/reopen`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminReport> reopen(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id/reopen',
      method: 'POST',
    );
    return MastodonAdminReport.fromJson(data!);
  }
}
