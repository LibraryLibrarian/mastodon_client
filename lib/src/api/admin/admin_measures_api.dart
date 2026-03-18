import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_measure.dart';
import '../../models/admin/mastodon_admin_measure_request.dart';

/// Admin measures (quantitative data) API.
///
/// Retrieves quantitative statistics about the server
/// (active users, new users, etc.).
/// Requires the `admin:read` OAuth scope.
class AdminMeasuresApi {
  const AdminMeasuresApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches measure data.
  ///
  /// `POST /api/v1/admin/measures`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonAdminMeasure>> fetch(
    MastodonAdminMeasureRequest request,
  ) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/measures',
      method: 'POST',
      data: request.toJson(),
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminMeasure.fromJson)
        .toList();
  }
}
