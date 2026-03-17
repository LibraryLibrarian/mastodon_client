import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_preview_card_provider.dart';
import '../../models/admin/mastodon_admin_tag.dart';
import '../../models/admin/mastodon_admin_trends_link.dart';
import '../../models/mastodon_status.dart';

/// 管理者向けトレンド API
///
/// 未承認・未レビューを含むトレンド情報の取得およびモデレーションを行う。
/// 読み取りには `admin:read` 、書き込みには `admin:write` の OAuth スコープが必要。
///
/// approve / reject 系のエンドポイントは公式ドキュメント未掲載だが
/// Mastodon サーバーに実装されており、Web UI のトレンドモデレーションで使用されている。
class AdminTrendsApi {
  const AdminTrendsApi(this._http);

  final MastodonHttpClient _http;

  /// トレンドリンクを取得する（未承認含む）
  ///
  /// `GET /api/v1/admin/trends/links`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAdminTrendsLink>> fetchLinks() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/trends/links',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminTrendsLink.fromJson)
        .toList();
  }

  /// トレンドリンクを承認する
  ///
  /// `POST /api/v1/admin/trends/links/:id/approve`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminTrendsLink> approveLink({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/links/$id/approve',
      method: 'POST',
    );
    return MastodonAdminTrendsLink.fromJson(data!);
  }

  /// トレンドリンクを拒否する
  ///
  /// `POST /api/v1/admin/trends/links/:id/reject`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminTrendsLink> rejectLink({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/links/$id/reject',
      method: 'POST',
    );
    return MastodonAdminTrendsLink.fromJson(data!);
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

  /// トレンドステータスを承認する
  ///
  /// `POST /api/v1/admin/trends/statuses/:id/approve`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonStatus> approveStatus({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/statuses/$id/approve',
      method: 'POST',
    );
    return MastodonStatus.fromJson(data!);
  }

  /// トレンドステータスを拒否する
  ///
  /// `POST /api/v1/admin/trends/statuses/:id/reject`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonStatus> rejectStatus({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/statuses/$id/reject',
      method: 'POST',
    );
    return MastodonStatus.fromJson(data!);
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

  /// トレンドタグを承認する
  ///
  /// `POST /api/v1/admin/trends/tags/:id/approve`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminTag> approveTag({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/tags/$id/approve',
      method: 'POST',
    );
    return MastodonAdminTag.fromJson(data!);
  }

  /// トレンドタグを拒否する
  ///
  /// `POST /api/v1/admin/trends/tags/:id/reject`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminTag> rejectTag({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/tags/$id/reject',
      method: 'POST',
    );
    return MastodonAdminTag.fromJson(data!);
  }

  /// トレンドリンクの発行元一覧を取得する
  ///
  /// `GET /api/v1/admin/trends/links/publishers`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAdminPreviewCardProvider>> fetchPublishers() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/trends/links/publishers',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminPreviewCardProvider.fromJson)
        .toList();
  }

  /// トレンドリンクの発行元を承認する
  ///
  /// `POST /api/v1/admin/trends/links/publishers/:id/approve`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminPreviewCardProvider> approvePublisher({
    required String id,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/links/publishers/$id/approve',
      method: 'POST',
    );
    return MastodonAdminPreviewCardProvider.fromJson(data!);
  }

  /// トレンドリンクの発行元を拒否する
  ///
  /// `POST /api/v1/admin/trends/links/publishers/:id/reject`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAdminPreviewCardProvider> rejectPublisher({
    required String id,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/links/publishers/$id/reject',
      method: 'POST',
    );
    return MastodonAdminPreviewCardProvider.fromJson(data!);
  }
}
