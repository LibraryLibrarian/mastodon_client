import '../client/mastodon_http_client.dart';
import '../models/mastodon_proof.dart';

/// API client for identity proofs.
///
/// **Deprecated**: Identity proof functionality was removed in Mastodon 3.5.0.
/// Provided only for compatibility with older server versions.
@Deprecated(
  'Removed in Mastodon 3.5.0. For compatibility with older servers only',
)
class ProofsApi {
  /// Creates a [ProofsApi] instance with the given [MastodonHttpClient].
  @Deprecated(
    'Removed in Mastodon 3.5.0. For compatibility with older servers only',
  )
  const ProofsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches user proof information for the specified identity provider.
  ///
  /// `GET /api/proofs`
  ///
  /// [provider] is the identity provider name (case-sensitive, e.g.
  /// `keybase`) and [username] is the username on that provider.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonProof> fetch({
    required String provider,
    required String username,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/proofs',
      queryParameters: <String, dynamic>{
        'provider': provider,
        'username': username,
      },
    );
    return MastodonProof.fromJson(data!);
  }
}
