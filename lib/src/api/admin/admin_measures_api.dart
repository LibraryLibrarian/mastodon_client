import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_measure.dart';
import '../../models/admin/mastodon_admin_measure_request.dart';

/// 管理者向けメジャー（定量データ）API
///
/// サーバーの定量的な統計情報（アクティブユーザー数・新規ユーザー数等）を取得する。
/// `admin:read` の OAuth スコープが必要。
class AdminMeasuresApi {
  const AdminMeasuresApi(this._http);

  final MastodonHttpClient _http;

  /// メジャーデータを取得する
  ///
  /// `POST /api/v1/admin/measures`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
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
