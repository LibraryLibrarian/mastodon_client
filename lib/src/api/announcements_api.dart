import '../client/mastodon_http_client.dart';
import '../models/mastodon_announcement.dart';

/// Server announcements API.
class AnnouncementsApi {
  const AnnouncementsApi(this._http);
  final MastodonHttpClient _http;

  /// Fetches a list of active announcements.
  ///
  /// `GET /api/v1/announcements`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonAnnouncement>> fetch({
    @Deprecated(
      'Not implemented server-side; has no effect. '
      'Will be removed in the future',
    )
    bool? withDismissed,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/announcements',
      queryParameters: <String, dynamic>{
        'with_dismissed': ?withDismissed,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAnnouncement.fromJson)
        .toList();
  }

  /// Dismisses an announcement (marks it as read).
  ///
  /// `POST /api/v1/announcements/:id/dismiss`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> dismiss(String id) async {
    await _http.send<dynamic>(
      '/api/v1/announcements/$id/dismiss',
      method: 'POST',
    );
  }

  /// Adds a reaction to an announcement.
  ///
  /// `PUT /api/v1/announcements/:id/reactions/:name`
  ///
  /// [name] is a Unicode emoji character or a custom emoji shortcode.
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> addReaction(String id, String name) async {
    final encodedName = Uri.encodeComponent(name);
    await _http.send<dynamic>(
      '/api/v1/announcements/$id/reactions/$encodedName',
      method: 'PUT',
    );
  }

  /// Removes a reaction from an announcement.
  ///
  /// `DELETE /api/v1/announcements/:id/reactions/:name`
  ///
  /// [name] is a Unicode emoji character or a custom emoji shortcode.
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> removeReaction(String id, String name) async {
    final encodedName = Uri.encodeComponent(name);
    await _http.send<dynamic>(
      '/api/v1/announcements/$id/reactions/$encodedName',
      method: 'DELETE',
    );
  }
}
