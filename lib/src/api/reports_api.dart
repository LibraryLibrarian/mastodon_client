import '../client/mastodon_http_client.dart';
import '../models/mastodon_report.dart';
import '../models/mastodon_report_create_request.dart';

/// Reports API.
class ReportsApi {
  /// Creates a [ReportsApi] instance with the given [MastodonHttpClient].
  const ReportsApi(this._http);

  final MastodonHttpClient _http;

  /// Creates a report.
  ///
  /// `POST /api/v1/reports`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonReport> create(MastodonReportCreateRequest request) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/reports',
      method: 'POST',
      data: request.toJson(),
    );
    return MastodonReport.fromJson(data!);
  }
}
