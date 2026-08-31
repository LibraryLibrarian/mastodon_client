import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonProfile.fromJson', () {
    test('preserves nullable profile settings', () {
      final profile = MastodonProfile.fromJson(const {
        'id': '1',
        'hide_collections': null,
        'discoverable': null,
      });

      expect(profile.hideCollections, isNull);
      expect(profile.discoverable, isNull);
      expect(profile.indexable, isFalse);
      expect(profile.showMedia, isTrue);
      expect(profile.showMediaReplies, isTrue);
      expect(profile.showFeatured, isTrue);

      final json = profile.toJson();
      expect(json, containsPair('hide_collections', null));
      expect(json, containsPair('discoverable', null));
    });
  });
}
