import 'dart:convert';
import 'dart:io';

import 'package:mastodon_client/mastodon_client.dart';
import 'package:mastodon_client/src/api/instance_api.dart';
import 'package:test/test.dart';

import '../helpers/recording_http_client.dart';

void main() {
  group('MastodonServerCapabilities', () {
    test('uses api_versions.mastodon as the primary signal', () {
      const capabilities = MastodonServerCapabilities(
        apiVersionMastodon: 10,
        version: 'compatible-fork',
      );

      expect(
        capabilities.supportFor(MastodonCapability.collections),
        MastodonCapabilitySupport.supported,
      );
      expect(
        capabilities.supportFor(MastodonCapability.quotePosts),
        MastodonCapabilitySupport.supported,
      );
    });

    for (final requirement
        in <
          ({
            MastodonCapability capability,
            int apiVersion,
            String previousVersion,
            String minimumVersion,
          })
        >[
          (
            capability: MastodonCapability.tagFeaturing,
            apiVersion: 6,
            previousVersion: '4.3.9',
            minimumVersion: '4.4.0',
          ),
          (
            capability: MastodonCapability.quotePosts,
            apiVersion: 7,
            previousVersion: '4.4.23',
            minimumVersion: '4.5.0',
          ),
          (
            capability: MastodonCapability.collections,
            apiVersion: 10,
            previousVersion: '4.5.16',
            minimumVersion: '4.6.0',
          ),
        ]) {
      test('${requirement.capability.name} honors both lower bounds', () {
        final belowApiVersion = MastodonServerCapabilities(
          apiVersionMastodon: requirement.apiVersion - 1,
          version: requirement.minimumVersion,
        );
        final atApiVersion = MastodonServerCapabilities(
          apiVersionMastodon: requirement.apiVersion,
          version: requirement.previousVersion,
        );
        final belowVersion = MastodonServerCapabilities(
          apiVersionMastodon: null,
          version: requirement.previousVersion,
        );
        final atVersion = MastodonServerCapabilities(
          apiVersionMastodon: null,
          version: requirement.minimumVersion,
        );

        expect(
          belowApiVersion.supportFor(requirement.capability),
          MastodonCapabilitySupport.unsupported,
        );
        expect(
          atApiVersion.supportFor(requirement.capability),
          MastodonCapabilitySupport.supported,
        );
        expect(
          belowVersion.supportFor(requirement.capability),
          MastodonCapabilitySupport.unsupported,
        );
        expect(
          atVersion.supportFor(requirement.capability),
          MastodonCapabilitySupport.supported,
        );
      });
    }

    test('uses the version string when the API version is absent', () {
      const capabilities = MastodonServerCapabilities(
        apiVersionMastodon: null,
        version: '4.5.0+fork',
      );

      expect(
        capabilities.supportFor(MastodonCapability.quotePosts),
        MastodonCapabilitySupport.supported,
      );
      expect(
        capabilities.supportFor(MastodonCapability.collections),
        MastodonCapabilitySupport.unsupported,
      );
    });

    test('returns unknown for invalid metadata', () {
      const missingApiVersion = MastodonServerCapabilities(
        apiVersionMastodon: 0,
        version: '4.6.0',
      );
      const unparseableVersion = MastodonServerCapabilities(
        apiVersionMastodon: null,
        version: 'compatible-fork',
      );

      expect(
        missingApiVersion.supportFor(MastodonCapability.collections),
        MastodonCapabilitySupport.unknown,
      );
      expect(
        unparseableVersion.supportFor(MastodonCapability.collections),
        MastodonCapabilitySupport.unknown,
      );
    });
  });

  group('InstanceApi.detectCapabilities', () {
    test('uses v2 instance metadata when available', () async {
      final instance = _fixture('instance_v2.json')
        ..['version'] = '4.2.0'
        ..['api_versions'] = <String, dynamic>{'mastodon': 10};
      final http = RecordingHttpClient([instance]);

      final capabilities = await InstanceApi(http).detectCapabilities();

      expect(
        capabilities.supportFor(MastodonCapability.collections),
        MastodonCapabilitySupport.supported,
      );
      expect(http.requests.single.path, '/api/v2/instance');
    });

    test('falls back to v1 only when the v2 endpoint is absent', () async {
      final instanceV1 = _fixture('instance_v1.json')..['version'] = '4.4.0';
      final http = RecordingHttpClient([
        const MastodonNotFoundException(endpoint: '/api/v2/instance'),
        instanceV1,
      ]);

      final capabilities = await InstanceApi(http).detectCapabilities();

      expect(
        capabilities.supportFor(MastodonCapability.tagFeaturing),
        MastodonCapabilitySupport.supported,
      );
      expect(http.requests.map((request) => request.path), [
        '/api/v2/instance',
        '/api/v1/instance',
      ]);
    });

    test('does not hide non-404 failures', () async {
      final http = RecordingHttpClient([
        const MastodonNetworkException(message: 'offline'),
      ]);

      await expectLater(
        InstanceApi(http).detectCapabilities(),
        throwsA(isA<MastodonNetworkException>()),
      );
      expect(http.requests.single.path, '/api/v2/instance');
    });
  });
}

Map<String, dynamic> _fixture(String name) =>
    jsonDecode(File('test/fixtures/$name').readAsStringSync())
        as Map<String, dynamic>;
