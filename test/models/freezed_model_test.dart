import 'dart:io';

import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('freezed models', () {
    test('cover every JSON response model', () {
      final sources = Directory('lib/src/models')
          .listSync(recursive: true)
          .whereType<File>()
          .where(
            (file) =>
                file.path.endsWith('.dart') &&
                !file.path.endsWith('.g.dart') &&
                !file.path.endsWith('.freezed.dart'),
          );
      var jsonSerializableCount = 0;
      var freezedCount = 0;

      for (final source in sources) {
        final content = source.readAsStringSync();
        final jsonCount = RegExp(
          r'^@JsonSerializable',
          multiLine: true,
        ).allMatches(content).length;
        if (jsonCount == 0) continue;

        final fileFreezedCount = RegExp(
          r'^@Freezed\(toStringOverride: false\)$',
          multiLine: true,
        ).allMatches(content).length;
        final mixinCount = RegExp(
          r'class\s+\w+\s+with\s+_\$\w+\s*\{',
          multiLine: true,
        ).allMatches(content).length;
        final basename = source.uri.pathSegments.last.replaceFirst('.dart', '');
        final generated = File('${source.parent.path}/$basename.freezed.dart');

        expect(fileFreezedCount, jsonCount, reason: source.path);
        expect(mixinCount, jsonCount, reason: source.path);
        expect(
          content,
          contains("part '$basename.freezed.dart';"),
          reason: source.path,
        );
        expect(generated.existsSync(), isTrue, reason: generated.path);
        expect(
          generated.readAsStringSync(),
          isNot(contains('String toString()')),
          reason: generated.path,
        );

        jsonSerializableCount += jsonCount;
        freezedCount += fileFreezedCount;
      }

      expect(jsonSerializableCount, 121);
      expect(freezedCount, jsonSerializableCount);
    });

    test('keep public construction and add value semantics', () {
      const first = MastodonToken(
        accessToken: 'token',
        tokenType: 'Bearer',
        scope: 'read',
        createdAt: 1,
      );
      const second = MastodonToken(
        accessToken: 'token',
        tokenType: 'Bearer',
        scope: 'read',
        createdAt: 1,
      );
      final copied = first.copyWith(scope: 'read write');

      expect(first, second);
      expect(first.hashCode, second.hashCode);
      expect(copied.accessToken, first.accessToken);
      expect(copied.scope, 'read write');
      expect(copied, isNot(first));
    });

    test('copyWith can explicitly clear a nullable field', () {
      final marker = MastodonMarker(
        lastReadId: '1',
        version: 2,
        updatedAt: DateTime.utc(2026, 8, 19),
      );

      final copied = marker.copyWith(updatedAt: null);

      expect(copied.lastReadId, marker.lastReadId);
      expect(copied.version, marker.version);
      expect(copied.updatedAt, isNull);
    });

    test('collections use deep equality', () {
      final first = _oauthMetadata();
      final second = _oauthMetadata();

      expect(first.scopesSupported, isNot(same(second.scopesSupported)));
      expect(first, second);
      expect(first.hashCode, second.hashCode);
    });

    test('maps and nested models use deep equality', () {
      final first = MastodonInstanceRule(
        id: '1',
        text: 'Be kind',
        translations: {
          'ja': const MastodonInstanceRuleTranslation(text: '親切に'),
        },
      );
      final second = MastodonInstanceRule(
        id: '1',
        text: 'Be kind',
        translations: {
          'ja': const MastodonInstanceRuleTranslation(text: '親切に'),
        },
      );

      expect(first.translations, isNot(same(second.translations)));
      expect(first, second);
      expect(first.hashCode, second.hashCode);

      first.translations!['en'] = const MastodonInstanceRuleTranslation(
        text: 'Be kind',
      );
      expect(first, isNot(second));
    });

    test('keeps JsonKey defaults and converters', () {
      final missing = MastodonFeaturedTag.fromJson(const {
        'id': '1',
        'name': 'dart',
        'statuses_count': '42',
        'last_status_at': '2026-08-19T00:00:00.000Z',
      });
      final explicitNull = MastodonFeaturedTag.fromJson(const {
        'id': '1',
        'name': 'dart',
        'url': null,
        'statuses_count': 42,
      });

      expect(missing.url, '');
      expect(explicitNull.url, '');
      expect(missing.statusesCount, 42);
      expect(missing.lastStatusAt, DateTime.utc(2026, 8, 19));
      expect(missing.toJson()['last_status_at'], '2026-08-19T00:00:00.000Z');
    });

    test('does not expose OAuth secrets through toString', () {
      const token = MastodonToken(
        accessToken: 'sensitive-access-token',
        tokenType: 'Bearer',
        scope: 'read',
        createdAt: 1,
      );
      const application = MastodonCredentialApplication(
        id: '1',
        name: 'client',
        scopes: ['read'],
        redirectUris: ['app://callback'],
        clientId: 'client-id',
        clientSecret: 'sensitive-client-secret',
        clientSecretExpiresAt: 0,
      );

      expect(token.toString(), isNot(contains('sensitive-access-token')));
      expect(
        application.toString(),
        isNot(contains('sensitive-client-secret')),
      );
    });
  });
}

MastodonOAuthServerMetadata _oauthMetadata() => MastodonOAuthServerMetadata(
  issuer: 'https://example.com',
  serviceDocumentation: 'https://example.com/docs',
  authorizationEndpoint: 'https://example.com/oauth/authorize',
  tokenEndpoint: 'https://example.com/oauth/token',
  appRegistrationEndpoint: 'https://example.com/api/v1/apps',
  revocationEndpoint: 'https://example.com/oauth/revoke',
  scopesSupported: ['read', 'write'],
  responseTypesSupported: ['code'],
  responseModesSupported: ['query'],
  codeChallengeMethodsSupported: ['S256'],
  grantTypesSupported: ['authorization_code'],
  tokenEndpointAuthMethodsSupported: ['client_secret_post'],
);
