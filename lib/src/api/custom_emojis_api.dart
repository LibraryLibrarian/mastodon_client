import '../client/mastodon_http_client.dart';
import '../models/mastodon_custom_emoji.dart';

/// Custom emojis API.
class CustomEmojisApi {
  const CustomEmojisApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches a list of custom emojis available on the server.
  ///
  /// `GET /api/v1/custom_emojis`
  ///
  /// No authentication required.
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonCustomEmoji>> fetch() async {
    final data = await _http.send<List<dynamic>>('/api/v1/custom_emojis');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonCustomEmoji.fromJson)
        .toList();
  }
}
