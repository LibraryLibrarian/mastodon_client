import '../../client/mastodon_http_client.dart';
import '../../models/admin/mastodon_admin_preview_card_provider.dart';
import '../../models/admin/mastodon_admin_tag.dart';
import '../../models/admin/mastodon_admin_trends_link.dart';
import '../../models/mastodon_status.dart';

/// Admin trends API.
///
/// Retrieves and moderates trend information including unapproved/unreviewed items.
/// Read endpoints require `admin:read`, write endpoints require `admin:write`
/// OAuth scopes.
///
/// The approve/reject endpoints are not listed in the official documentation
/// but are implemented in the Mastodon server and used by the Web UI
/// for trend moderation.
class AdminTrendsApi {
  const AdminTrendsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches trending links (including unapproved).
  ///
  /// `GET /api/v1/admin/trends/links`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonAdminTrendsLink>> fetchLinks() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/trends/links',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminTrendsLink.fromJson)
        .toList();
  }

  /// Approves a trending link.
  ///
  /// `POST /api/v1/admin/trends/links/:id/approve`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminTrendsLink> approveLink({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/links/$id/approve',
      method: 'POST',
    );
    return MastodonAdminTrendsLink.fromJson(data!);
  }

  /// Rejects a trending link.
  ///
  /// `POST /api/v1/admin/trends/links/:id/reject`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminTrendsLink> rejectLink({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/links/$id/reject',
      method: 'POST',
    );
    return MastodonAdminTrendsLink.fromJson(data!);
  }

  /// Fetches trending statuses (including unapproved).
  ///
  /// `GET /api/v1/admin/trends/statuses`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonStatus>> fetchStatuses() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/trends/statuses',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
  }

  /// Approves a trending status.
  ///
  /// `POST /api/v1/admin/trends/statuses/:id/approve`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatus> approveStatus({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/statuses/$id/approve',
      method: 'POST',
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Rejects a trending status.
  ///
  /// `POST /api/v1/admin/trends/statuses/:id/reject`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatus> rejectStatus({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/statuses/$id/reject',
      method: 'POST',
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Fetches trending tags (including unreviewed).
  ///
  /// `GET /api/v1/admin/trends/tags`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonAdminTag>> fetchTags() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/trends/tags',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminTag.fromJson)
        .toList();
  }

  /// Approves a trending tag.
  ///
  /// `POST /api/v1/admin/trends/tags/:id/approve`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminTag> approveTag({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/tags/$id/approve',
      method: 'POST',
    );
    return MastodonAdminTag.fromJson(data!);
  }

  /// Rejects a trending tag.
  ///
  /// `POST /api/v1/admin/trends/tags/:id/reject`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminTag> rejectTag({required String id}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/tags/$id/reject',
      method: 'POST',
    );
    return MastodonAdminTag.fromJson(data!);
  }

  /// Fetches the list of trending link publishers.
  ///
  /// `GET /api/v1/admin/trends/links/publishers`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonAdminPreviewCardProvider>> fetchPublishers() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/admin/trends/links/publishers',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAdminPreviewCardProvider.fromJson)
        .toList();
  }

  /// Approves a trending link publisher.
  ///
  /// `POST /api/v1/admin/trends/links/publishers/:id/approve`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonAdminPreviewCardProvider> approvePublisher({
    required String id,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/admin/trends/links/publishers/$id/approve',
      method: 'POST',
    );
    return MastodonAdminPreviewCardProvider.fromJson(data!);
  }

  /// Rejects a trending link publisher.
  ///
  /// `POST /api/v1/admin/trends/links/publishers/:id/reject`
  ///
  /// Throws a `MastodonException` on failure.
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
