import '../client/mastodon_http_client.dart';
import '../models/mastodon_domain_block.dart';
import '../models/mastodon_extended_description.dart';
import '../models/mastodon_instance.dart';
import '../models/mastodon_instance_v1.dart';
import '../models/mastodon_privacy_policy.dart';
import '../models/mastodon_terms_of_service.dart';
import '../models/mastodon_weekly_activity.dart';

/// Instance information API.
class InstanceApi {
  const InstanceApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the instance information.
  ///
  /// `GET /api/v2/instance`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonInstance> fetch() async {
    final data = await _http.send<Map<String, dynamic>>('/api/v2/instance');
    return MastodonInstance.fromJson(data!);
  }

  /// Fetches the list of peer domains known to the instance.
  ///
  /// `GET /api/v1/instance/peers`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<String>> fetchPeers() async {
    final data = await _http.send<List<dynamic>>('/api/v1/instance/peers');
    return (data ?? const <dynamic>[]).cast<String>();
  }

  /// Fetches weekly activity statistics for the last 3 months.
  ///
  /// `GET /api/v1/instance/activity`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonWeeklyActivity>> fetchActivity() async {
    final data = await _http.send<List<dynamic>>('/api/v1/instance/activity');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonWeeklyActivity.fromJson)
        .toList();
  }

  /// Fetches the instance rules.
  ///
  /// `GET /api/v1/instance/rules`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonInstanceRule>> fetchRules() async {
    final data = await _http.send<List<dynamic>>('/api/v1/instance/rules');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonInstanceRule.fromJson)
        .toList();
  }

  /// Fetches the domains blocked by the instance.
  ///
  /// `GET /api/v1/instance/domain_blocks`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonDomainBlock>> fetchDomainBlocks() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/instance/domain_blocks',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonDomainBlock.fromJson)
        .toList();
  }

  /// Fetches the instance's extended description.
  ///
  /// `GET /api/v1/instance/extended_description`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonExtendedDescription> fetchExtendedDescription() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/extended_description',
    );
    return MastodonExtendedDescription.fromJson(data!);
  }

  /// Fetches the instance's privacy policy.
  ///
  /// `GET /api/v1/instance/privacy_policy`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPrivacyPolicy> fetchPrivacyPolicy() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/privacy_policy',
    );
    return MastodonPrivacyPolicy.fromJson(data!);
  }

  /// Fetches the instance's terms of service.
  ///
  /// `GET /api/v1/instance/terms_of_service`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonTermsOfService> fetchTermsOfService() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/terms_of_service',
    );
    return MastodonTermsOfService.fromJson(data!);
  }

  /// Fetches the terms of service for the specified effective date.
  ///
  /// `GET /api/v1/instance/terms_of_service/:date`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonTermsOfService> fetchTermsOfServiceByDate(
    String date,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/terms_of_service/$date',
    );
    return MastodonTermsOfService.fromJson(data!);
  }

  /// Fetches instance information in v1 format.
  ///
  /// `GET /api/v1/instance`
  ///
  /// **Deprecated**: Deprecated in Mastodon 4.0.0. Use [fetch] (v2) instead.
  /// Provided for compatibility with older servers that do not support v2.
  ///
  /// Throws a `MastodonException` on failure.
  @Deprecated('Deprecated in Mastodon 4.0.0. Use fetch() (v2) instead')
  Future<MastodonInstanceV1> fetchV1() async {
    final data = await _http.send<Map<String, dynamic>>('/api/v1/instance');
    return MastodonInstanceV1.fromJson(data!);
  }

  /// Fetches the language pairs supported by the translation engine.
  ///
  /// `GET /api/v1/instance/translation_languages`
  ///
  /// Returns a map with source language codes as keys and lists of
  /// supported target language codes as values.
  ///
  /// Throws a `MastodonException` on failure.
  Future<Map<String, List<String>>> fetchTranslationLanguages() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/translation_languages',
    );
    return (data ?? const <String, dynamic>{}).map(
      (key, value) => MapEntry(
        key,
        (value as List<dynamic>).cast<String>(),
      ),
    );
  }
}
