import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonOAuthServerMetadata.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/oauth_server_metadata.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final obj = MastodonOAuthServerMetadata.fromJson(json);

      expect(obj.issuer, 'https://localhost:3001/');
      expect(
        obj.authorizationEndpoint,
        'https://localhost:3001/oauth/authorize',
      );
      expect(obj.tokenEndpoint, 'https://localhost:3001/oauth/token');
      expect(obj.revocationEndpoint, 'https://localhost:3001/oauth/revoke');
      expect(
        obj.userinfoEndpoint,
        'https://localhost:3001/oauth/userinfo',
      );
      expect(
        obj.appRegistrationEndpoint,
        'https://localhost:3001/api/v1/apps',
      );
      expect(
        obj.serviceDocumentation,
        'https://docs.joinmastodon.org/',
      );
      expect(obj.scopesSupported, contains('read'));
      expect(obj.scopesSupported, contains('write'));
      expect(obj.scopesSupported, contains('push'));
      expect(obj.responseTypesSupported, ['code']);
      expect(
        obj.responseModesSupported,
        containsAll(['query', 'fragment', 'form_post']),
      );
      expect(
        obj.grantTypesSupported,
        containsAll(['authorization_code', 'client_credentials']),
      );
      expect(
        obj.tokenEndpointAuthMethodsSupported,
        containsAll(['client_secret_basic', 'client_secret_post']),
      );
      expect(obj.codeChallengeMethodsSupported, ['S256']);
    });
  });
}
