import '../../client/mastodon_http_client.dart';
import '../../internal/link_header_parser.dart';
import '../../models/admin/mastodon_admin_report.dart';
import '../../models/admin/mastodon_admin_report_update_request.dart';
import '../../models/mastodon_page.dart';

/// Admin report management API.
///
/// Provides report listing, assignment, resolution, and reopening.
/// All endpoints require `admin:read:reports` or
/// `admin:write:reports` OAuth scopes.
class AdminReportsApi {
  const AdminReportsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches all reports.
  ///
  /// `GET /api/v1/admin/reports`
  ///
  /// Set [resolved] to `true` to filter to resolved reports only.
  /// [accountId] filters by the reporter's account ID and
  /// [targetAccountId] by the reported account ID. Use [maxId], [sinceId],
  /// and [minId] for pagination. [limit] controls the maximum number of
  /// results (default: 100, max: 200).
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAdminReport>> fetch({
    bool? resolved,
    String? accountId,
    String? targetAccountId,
    String? maxId,
    String? sinceId,
    String? minId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
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
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminReport.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches a report by its ID.
  ///
  /// `GET /api/v1/admin/reports/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminReport> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id',
    );
    return MastodonAdminReport.fromJson(data!);
  }

  /// Updates the metadata of a report.
  ///
  /// `PUT /api/v1/admin/reports/{id}`
  ///
  /// Throws a `MastodonException` on failure.
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

  /// Assigns a report to the current user.
  ///
  /// `POST /api/v1/admin/reports/{id}/assign_to_self`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminReport> assignToSelf(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id/assign_to_self',
      method: 'POST',
    );
    return MastodonAdminReport.fromJson(data!);
  }

  /// Unassigns a report.
  ///
  /// `POST /api/v1/admin/reports/{id}/unassign`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminReport> unassign(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id/unassign',
      method: 'POST',
    );
    return MastodonAdminReport.fromJson(data!);
  }

  /// Resolves a report.
  ///
  /// `POST /api/v1/admin/reports/{id}/resolve`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminReport> resolve(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id/resolve',
      method: 'POST',
    );
    return MastodonAdminReport.fromJson(data!);
  }

  /// Reopens a resolved report.
  ///
  /// `POST /api/v1/admin/reports/{id}/reopen`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminReport> reopen(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/reports/$id/reopen',
      method: 'POST',
    );
    return MastodonAdminReport.fromJson(data!);
  }
}
