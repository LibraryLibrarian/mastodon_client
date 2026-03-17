import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_cohort.dart';
import '../../models/admin/mastodon_admin_retention_request.dart';

/// 管理者向けリテンション API
///
/// ユーザーリテンションのコホートデータを生成する。
/// `admin:read` の OAuth スコープが必要。
class AdminRetentionApi {
  const AdminRetentionApi(this._http);

  final MastodonHttpClient _http;

  /// リテンションデータを取得する
  ///
  /// `POST /api/v1/admin/retention`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
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
