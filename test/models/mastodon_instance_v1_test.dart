import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonInstanceV1.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/instance_v1.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      final instance = MastodonInstanceV1.fromJson(json);

      // basic fields
      expect(instance.uri, equals('mastodon.test'));
      expect(instance.title, equals('Mastodon'));
      expect(instance.shortDescription, equals(''));
      expect(instance.description, equals(''));
      expect(instance.email, equals(''));
      expect(instance.version, equals('4.6.3'));
      expect(
        instance.thumbnail,
        equals(
          'https://mastodon.test/packs/assets/preview-vSUsFXid.png',
        ),
      );
      expect(instance.languages, equals(['en']));
      expect(instance.registrations, isFalse);
      expect(instance.approvalRequired, isFalse);
      expect(instance.invitesEnabled, isTrue);
      expect(instance.contactAccount, isNull);

      // urls
      expect(instance.urls, isNotNull);
      expect(instance.urls!.streamingApi, equals('wss://mastodon.test'));

      // stats
      expect(instance.stats, isNotNull);
      expect(instance.stats!.userCount, greaterThan(0));
      expect(instance.stats!.statusCount, greaterThan(0));
      expect(instance.stats!.domainCount, equals(2));

      // configuration
      expect(instance.configuration, isNotNull);
      final config = instance.configuration!;

      expect(config.statuses, isNotNull);
      expect(config.statuses!.maxCharacters, equals(500));
      expect(config.statuses!.maxMediaAttachments, equals(4));
      expect(config.statuses!.charactersReservedPerUrl, equals(23));

      expect(config.mediaAttachments, isNotNull);
      expect(
        config.mediaAttachments!.supportedMimeTypes,
        contains('image/jpeg'),
      );
      expect(
        config.mediaAttachments!.supportedMimeTypes,
        contains('video/mp4'),
      );
      expect(config.mediaAttachments!.imageSizeLimit, equals(16777216));
      expect(config.mediaAttachments!.imageMatrixLimit, equals(33177600));
      expect(config.mediaAttachments!.videoSizeLimit, equals(103809024));
      expect(config.mediaAttachments!.videoFrameRateLimit, equals(120));
      expect(config.mediaAttachments!.videoMatrixLimit, equals(8294400));

      expect(config.polls, isNotNull);
      expect(config.polls!.maxOptions, equals(4));
      expect(config.polls!.maxCharactersPerOption, equals(50));
      expect(config.polls!.minExpiration, equals(300));
      expect(config.polls!.maxExpiration, equals(2629746));

      // rules
      // (サーバールールはWeb管理画面のみで設定可能でREST APIが無いため、
      // 閉域E2E環境では常に空になる)
      expect(instance.rules, isEmpty);
    });
  });
}
