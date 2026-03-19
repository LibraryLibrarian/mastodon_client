import '../client/mastodon_http_client.dart';
import '../models/mastodon_oembed.dart';

/// API client for OEmbed information.
class OEmbedApi {
  /// Creates an [OEmbedApi] instance with the given [MastodonHttpClient].
  const OEmbedApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches OEmbed metadata for a status.
  ///
  /// `GET /api/oembed`
  ///
  /// No authentication required.
  ///
  /// [url] is required. [maxwidth] sets the iframe width in pixels
  /// (default: 400) and [maxheight] sets the height.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonOEmbed> fetch(
    String url, {
    int? maxwidth,
    int? maxheight,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/oembed',
      queryParameters: <String, dynamic>{
        'url': url,
        'maxwidth': ?maxwidth,
        'maxheight': ?maxheight,
      },
    );
    return MastodonOEmbed.fromJson(data!);
  }
}
