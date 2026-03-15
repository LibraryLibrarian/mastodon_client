import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_tag.dart';
import '../../models/mastodon_status.dart';
import '../../models/mastodon_trends_link.dart';

/// 管理者向けトレンド API
///
/// 未承認・未レビューを含むトレンド情報を取得する。
/// `admin:read` の OAuth スコープが必要。
class AdminTrendsApi {
  const AdminTrendsApi(this._http);

  final MastodonHttpClient _http;

  /// トレンドリンクを取得する（未承認含む）
  ///
  /// `GET /api/v1/admin/trends/links`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonTrendsLink>> fetchLinks() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/trends/links',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonTrendsLink.fromJson)
        .toList();
  }

  /// トレンドステータスを取得する（未承認含む）
  ///
  /// `GET /api/v1/admin/trends/statuses`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonStatus>> fetchStatuses() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/trends/statuses',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
  }

  /// トレンドタグを取得する（未レビュー含む）
  ///
  /// `GET /api/v1/admin/trends/tags`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAdminTag>> fetchTags() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/trends/tags',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminTag.fromJson)
        .toList();
  }
}
