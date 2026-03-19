import '../client/mastodon_http_client.dart';
import '../models/mastodon_tag.dart';

/// API for retrieving hashtag info and follow/feature operations.
class TagsApi {
  /// Creates a [TagsApi] instance with the given [MastodonHttpClient].
  const TagsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches information about the specified hashtag.
  ///
  /// `GET /api/v1/tags/:name`
  ///
  /// [name] is case-insensitive. When using an authenticated token, the
  /// follow status (`following`) is also included.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonTag> fetch(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name',
    );
    return MastodonTag.fromJson(data!);
  }

  /// Follows a hashtag.
  ///
  /// `POST /api/v1/tags/:name/follow`
  ///
  /// Posts containing the followed tag will appear on the home timeline.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonTag> follow(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name/follow',
      method: 'POST',
    );
    return MastodonTag.fromJson(data!);
  }

  /// Unfollows a hashtag.
  ///
  /// `POST /api/v1/tags/:name/unfollow`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonTag> unfollow(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name/unfollow',
      method: 'POST',
    );
    return MastodonTag.fromJson(data!);
  }

  /// Features a hashtag on the user's profile.
  ///
  /// `POST /api/v1/tags/:id/feature`
  ///
  /// Available since Mastodon 4.4.0.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonTag> feature(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name/feature',
      method: 'POST',
    );
    return MastodonTag.fromJson(data!);
  }

  /// Removes a featured hashtag from the user's profile.
  ///
  /// `POST /api/v1/tags/:id/unfeature`
  ///
  /// Available since Mastodon 4.4.0.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonTag> unfeature(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name/unfeature',
      method: 'POST',
    );
    return MastodonTag.fromJson(data!);
  }
}
