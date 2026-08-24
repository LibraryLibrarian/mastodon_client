import '../client/mastodon_http_client.dart';
import '../models/mastodon_annual_report.dart';

/// API client for annual usage reports (Wrapstodon).
class AnnualReportsApi {
  const AnnualReportsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches unread generated annual reports.
  Future<MastodonAnnualReportsResult> fetch() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/annual_reports',
    );
    return MastodonAnnualReportsResult.fromJson(data!);
  }

  /// Fetches the report for [year].
  Future<MastodonAnnualReportsResult> fetchForYear(int year) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/annual_reports/$year',
    );
    return MastodonAnnualReportsResult.fromJson(data!);
  }

  /// Fetches the generation state for [year].
  Future<MastodonAnnualReportState> fetchState(int year) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/annual_reports/$year/state',
    );
    return MastodonAnnualReportState.fromJson(data?['state'] as String?);
  }

  /// Starts generating the report for [year] when eligible.
  Future<void> generate(int year) =>
      _http.send<void>('/api/v1/annual_reports/$year/generate', method: 'POST');

  /// Marks the report for [year] as read.
  Future<void> markRead(int year) =>
      _http.send<void>('/api/v1/annual_reports/$year/read', method: 'POST');
}
