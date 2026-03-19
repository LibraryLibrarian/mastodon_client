import '../client/mastodon_http_client.dart';

/// API client for email confirmation.
class EmailsApi {
  /// Creates an [EmailsApi] instance with the given [MastodonHttpClient].
  const EmailsApi(this._http);

  final MastodonHttpClient _http;

  /// Resends the confirmation email.
  ///
  /// `POST /api/v1/emails/confirmations`
  ///
  /// When [email] is specified, updates the unconfirmed user's email address
  /// before resending the confirmation email.
  ///
  /// Requires authentication (token from the client that created
  /// the unconfirmed user).
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> resendConfirmation({String? email}) async {
    await _http.send<dynamic>(
      '/api/v1/emails/confirmations',
      method: 'POST',
      data: <String, dynamic>{
        'email': ?email,
      },
    );
  }

  /// Checks whether the email address has been confirmed.
  ///
  /// `GET /api/v1/emails/check_confirmation`
  ///
  /// Requires authentication (token from the client that created
  /// the unconfirmed user).
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> checkConfirmation() async {
    await _http.send<dynamic>(
      '/api/v1/emails/check_confirmation',
    );
  }
}
