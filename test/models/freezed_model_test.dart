import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('freezed models', () {
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
