import '../client/mastodon_http_client.dart';
import '../models/mastodon_report.dart';
import '../models/mastodon_report_create_request.dart';

/// 通報に関する API
class ReportsApi {
  /// [MastodonHttpClient] を受け取り、通報 API へのアクセスを提供する
  const ReportsApi(this._http);

  final MastodonHttpClient _http;

  /// 通報を作成する
  ///
  /// `POST /api/v1/reports`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonReport> create(MastodonReportCreateRequest request) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/reports',
      method: 'POST',
      data: request.toJson(),
    );
    return MastodonReport.fromJson(data!);
  }
}
