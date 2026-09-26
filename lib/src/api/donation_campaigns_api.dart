import '../client/mastodon_http_client.dart';

/// API client for optional instance donation campaigns.
///
/// Available since Mastodon 4.6.0.
class DonationCampaignsApi {
  const DonationCampaignsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the campaign selected for the authenticated account.
  ///
  /// Returns `null` when the instance has no active campaign (`204`). The
  /// campaign payload is intentionally untyped because Mastodon proxies an
  /// externally configured schema.
  Future<Map<String, dynamic>?> fetch() =>
      _http.send<Map<String, dynamic>>('/api/v1/donation_campaigns');
}
