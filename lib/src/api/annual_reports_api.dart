import '../client/mastodon_http_client.dart';
import '../models/mastodon_annual_report.dart';

/// API client for annual usage reports (Wrapstodon).
class AnnualReportsApi {
  const AnnualReportsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches unread generated annual reports.
  ///
  /// Available since Mastodon 4.3.0.
  Future<MastodonAnnualReportsResult> fetch() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/annual_reports',
    );
    return MastodonAnnualReportsResult.fromJson(data!);
  }

  /// Fetches the report for [year].
  ///
  /// Available since Mastodon 4.4.0.
  Future<MastodonAnnualReportsResult> fetchForYear(int year) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/annual_reports/$year',
    );
    return MastodonAnnualReportsResult.fromJson(data!);
  }

  /// Fetches the generation state for [year].
  ///
  /// Available since Mastodon 4.6.0.
  Future<MastodonAnnualReportState> fetchState(int year) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/annual_reports/$year/state',
    );
    return MastodonAnnualReportState.fromJson(data?['state'] as String?);
  }

  /// Starts generating the report for [year] when eligible.
  ///
  /// Available since Mastodon 4.6.0.
  Future<void> generate(int year) =>
      _http.send<void>('/api/v1/annual_reports/$year/generate', method: 'POST');

  /// Marks the report for [year] as read.
  ///
  /// Available since Mastodon 4.3.0.
  Future<void> markRead(int year) =>
      _http.send<void>('/api/v1/annual_reports/$year/read', method: 'POST');
}
