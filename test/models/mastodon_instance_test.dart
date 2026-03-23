import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonInstance.fromJson - instance_v2.json', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/instance_v2.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final instance = MastodonInstance.fromJson(json);

      expect(instance.domain, 'localhost:3001');
      expect(instance.title, 'Mastodon');
      expect(instance.version, '4.5.7');
      expect(instance.sourceUrl, 'https://github.com/mastodon/mastodon');
      expect(instance.description, '');
      expect(instance.languages, ['en']);
      expect(instance.apiVersionMastodon, 7);

      // rules
      expect(instance.rules, hasLength(2));
      expect(instance.rules.first.id, '1');
      expect(instance.rules.first.text, 'Be respectful to others');
      expect(instance.rules[1].id, '2');
      expect(instance.rules[1].text, 'No spam or advertising');

      // thumbnail
      expect(instance.thumbnail, isNotNull);
      expect(
        instance.thumbnail!.url,
        'https://localhost:3001/packs/assets/preview-vSUsFXid.png',
      );

      // icon
      expect(instance.icon, isNotNull);
      expect(instance.icon, hasLength(9));
      expect(instance.icon!.first.size, '36x36');

      // usage
      expect(instance.usage, isNotNull);
      expect(instance.usage!.activeMonth, 0);

      // configuration
      final config = instance.configuration;
      expect(config.urls.streaming, 'wss://localhost:3001');
      expect(config.translationEnabled, false);
      expect(config.vapidPublicKey, isNotNull);

      expect(config.statuses, isNotNull);
      expect(config.statuses!.maxCharacters, 500);
      expect(config.statuses!.maxMediaAttachments, 4);
      expect(config.statuses!.charactersReservedPerUrl, 23);

      expect(config.mediaAttachments, isNotNull);
      expect(config.mediaAttachments!.imageSizeLimit, 16777216);
      expect(config.mediaAttachments!.videoSizeLimit, 103809024);
      expect(config.mediaAttachments!.supportedMimeTypes, isNotEmpty);

      expect(config.polls, isNotNull);
      expect(config.polls!.maxOptions, 4);
      expect(config.polls!.maxCharactersPerOption, 50);
      expect(config.polls!.minExpiration, 300);
      expect(config.polls!.maxExpiration, 2629746);

      expect(config.timelinesAccess, isNotNull);
      expect(config.timelinesAccess!.liveFeeds, isNotNull);
      expect(
        config.timelinesAccess!.liveFeeds!.local,
        MastodonTimelineAccessLevel.public,
      );
      expect(
        config.timelinesAccess!.liveFeeds!.remote,
        MastodonTimelineAccessLevel.public,
      );

      // registrations
      expect(instance.registrations, isNotNull);
      expect(instance.registrations!.enabled, false);
      expect(instance.registrations!.approvalRequired, false);

      // contact
      expect(instance.contact, isNotNull);
      expect(instance.contact!.email, '');
      expect(instance.contact!.account, isNull);
    });
  });

  group('MastodonInstanceV1.fromJson - instance_v1.json', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/instance_v1.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final instance = MastodonInstanceV1.fromJson(json);

      expect(instance.uri, 'localhost:3001');
      expect(instance.title, 'Mastodon');
      expect(instance.version, '4.5.7');
      expect(instance.email, '');
      expect(instance.shortDescription, '');
      expect(instance.description, '');
      expect(instance.registrations, false);
      expect(instance.approvalRequired, false);
      expect(instance.invitesEnabled, true);
      expect(instance.languages, ['en']);
      expect(
        instance.thumbnail,
        'https://localhost:3001/packs/assets/preview-vSUsFXid.png',
      );
      expect(instance.contactAccount, isNull);

      // urls
      expect(instance.urls, isNotNull);
      expect(instance.urls!.streamingApi, 'wss://localhost:3001');

      // stats
      expect(instance.stats, isNotNull);
      expect(instance.stats!.userCount, 2);
      expect(instance.stats!.statusCount, 7);
      expect(instance.stats!.domainCount, 2);

      // rules
      expect(instance.rules, hasLength(2));
      expect(instance.rules.first.id, '1');
      expect(instance.rules.first.text, 'Be respectful to others');

      // configuration
      expect(instance.configuration, isNotNull);
      expect(instance.configuration!.statuses, isNotNull);
      expect(instance.configuration!.statuses!.maxCharacters, 500);
      expect(instance.configuration!.statuses!.maxMediaAttachments, 4);
      expect(instance.configuration!.polls, isNotNull);
      expect(instance.configuration!.polls!.maxOptions, 4);
    });
  });
}
