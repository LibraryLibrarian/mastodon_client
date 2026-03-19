/// Parameters for an account registration request.
///
/// Corresponds to the request body for `POST /api/v1/accounts`.
class MastodonAccountCreateRequest {
  /// Creates parameters for an account registration request.
  const MastodonAccountCreateRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.agreement,
    required this.locale,
    this.reason,
    this.dateOfBirth,
  });

  /// Desired username.
  final String username;

  /// Email address.
  final String email;

  /// Password.
  final String password;

  /// Agreement to the server's terms of service.
  final bool agreement;

  /// Locale of the user (ISO 639-1 format).
  final String locale;

  /// Reason for registration (may be required on approval-based instances).
  final String? reason;

  /// Date of birth (`YYYY-MM-DD` format).
  final String? dateOfBirth;

  /// Returns a JSON map for the request body.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'agreement': agreement,
      'locale': locale,
      if (reason != null) 'reason': reason,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
    };
  }
}
