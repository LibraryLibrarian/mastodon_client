import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_dimension.dart';
import '../../models/admin/mastodon_admin_dimension_request.dart';

/// Admin dimensions (qualitative data) API.
///
/// Retrieves qualitative statistics about the server
/// (language distribution, software versions, etc.).
/// Requires the `admin:read` OAuth scope.
class AdminDimensionsApi {
  const AdminDimensionsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches dimension data.
  ///
  /// `POST /api/v1/admin/dimensions`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonAdminDimension>> fetch(
    MastodonAdminDimensionRequest request,
  ) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/dimensions',
      method: 'POST',
      data: request.toJson(),
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminDimension.fromJson)
        .toList();
  }
}
