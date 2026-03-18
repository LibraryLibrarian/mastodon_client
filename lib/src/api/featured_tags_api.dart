import '../client/mastodon_http_client.dart';
import '../models/mastodon_featured_tag.dart';
import '../models/mastodon_tag.dart';

/// API for managing featured hashtags.
class FeaturedTagsApi {
  /// Creates a [FeaturedTagsApi] instance with the given [MastodonHttpClient].
  const FeaturedTagsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the hashtags featured on the user's profile.
  ///
  /// `GET /api/v1/featured_tags`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonFeaturedTag>> fetch() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/featured_tags',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFeaturedTag.fromJson)
        .toList();
  }

  /// Features a hashtag on the user's profile.
  ///
  /// `POST /api/v1/featured_tags`
  ///
  /// [name] is the hashtag name to feature, without the `#` prefix.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonFeaturedTag> create(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/featured_tags',
      method: 'POST',
      data: <String, dynamic>{'name': name},
    );
    return MastodonFeaturedTag.fromJson(data!);
  }

  /// Removes a featured hashtag from the user's profile.
  ///
  /// `DELETE /api/v1/featured_tags/:id`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v1/featured_tags/$id',
      method: 'DELETE',
    );
  }

  /// Fetches up to 10 recently used hashtags as feature candidates.
  ///
  /// `GET /api/v1/featured_tags/suggestions`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonTag>> fetchSuggestions() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/featured_tags/suggestions',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonTag.fromJson)
        .toList();
  }
}
