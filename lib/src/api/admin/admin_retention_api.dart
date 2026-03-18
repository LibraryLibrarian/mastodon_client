import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_cohort.dart';
import '../../models/admin/mastodon_admin_retention_request.dart';

/// Admin retention API.
///
/// Generates user retention cohort data.
/// Requires the `admin:read` OAuth scope.
class AdminRetentionApi {
  const AdminRetentionApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches retention data.
  ///
  /// `POST /api/v1/admin/retention`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonAdminCohort>> fetch(
    MastodonAdminRetentionRequest request,
  ) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/retention',
      method: 'POST',
      data: request.toJson(),
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminCohort.fromJson)
        .toList();
  }
}
