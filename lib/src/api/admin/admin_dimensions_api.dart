import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_dimension.dart';
import '../../models/admin/mastodon_admin_dimension_request.dart';

/// 管理者向けディメンション（次元データ）API
///
/// サーバーの定性的な統計情報（言語分布・ソフトウェアバージョン等）を取得する。
/// `admin:read` の OAuth スコープが必要。
class AdminDimensionsApi {
  const AdminDimensionsApi(this._http);

  final MastodonHttpClient _http;

  /// ディメンションデータを取得する
  ///
  /// `POST /api/v1/admin/dimensions`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
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
