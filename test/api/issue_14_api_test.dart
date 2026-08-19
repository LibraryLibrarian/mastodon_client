import 'package:mastodon_client/mastodon_client.dart';
import 'package:mastodon_client/src/api/accounts_api.dart';
import 'package:mastodon_client/src/api/annual_reports_api.dart';
import 'package:mastodon_client/src/api/collections_api.dart';
import 'package:mastodon_client/src/api/conversations_api.dart';
import 'package:mastodon_client/src/api/domain_blocks_api.dart';
import 'package:mastodon_client/src/api/donation_campaigns_api.dart';
import 'package:mastodon_client/src/api/grouped_notifications_api.dart';
import 'package:mastodon_client/src/api/instance_api.dart';
import 'package:mastodon_client/src/api/notifications_api.dart';
import 'package:mastodon_client/src/api/oauth_api.dart';
import 'package:mastodon_client/src/api/profile_api.dart';
import 'package:test/test.dart';

import '../helpers/recording_http_client.dart';

void main() {
  group('CollectionsApi', () {
    test('covers collection and item routes', () async {
      final collection = <String, dynamic>{'id': '1', 'name': 'People'};
      final http = RecordingHttpClient([
        {
          'collections': [collection],
        },
        {
          'collections': [collection],
        },
        {'collection': collection, 'accounts': <dynamic>[]},
        {'collection': collection},
        {'collection': collection},
        null,
        {
          'collection_item': {
            'id': '2',
            'state': 'pending',
            'created_at': '2026-08-19T00:00:00.000Z',
            'account_id': '3',
          },
        },
      ]);
      final api = CollectionsApi(http);

      expect(
        await api.fetchForAccount('3', limit: 10, offset: 2),
        hasLength(1),
      );
      expect(await api.fetchFeaturingAccount('3'), hasLength(1));
      expect((await api.fetch('1')).collection.id, '1');
      await api.create(
        const MastodonCollectionCreateRequest(
          name: 'People',
          sensitive: false,
          discoverable: true,
        ),
      );
      await api.update(
        '1',
        const MastodonCollectionUpdateRequest(name: 'Friends'),
      );
      await api.delete('1');
      expect((await api.addAccount('1', '3')).accountId, '3');
      await api.removeItem('1', '2');
      await api.revokeItem('1', '2');

      expect(
        http.requests.map((request) => '${request.method} ${request.path}'),
        [
          'GET /api/v1/accounts/3/collections',
          'GET /api/v1/accounts/3/in_collections',
          'GET /api/v1/collections/1',
          'POST /api/v1/collections',
          'PATCH /api/v1/collections/1',
          'DELETE /api/v1/collections/1',
          'POST /api/v1/collections/1/items',
          'DELETE /api/v1/collections/1/items/2',
          'POST /api/v1/collections/1/items/2/revoke',
        ],
      );
    });
  });

  test('ProfileApi fetches and updates the editable profile', () async {
    final profile = <String, dynamic>{
      'id': '1',
      'display_name': 'Alice',
      'note': 'raw',
      'formatted_note': '<p>raw</p>',
      'fields': <dynamic>[],
      'formatted_fields': <dynamic>[],
      'locked': false,
      'bot': false,
      'hide_collections': false,
      'discoverable': true,
      'indexable': true,
      'show_media': true,
      'show_media_replies': true,
      'show_featured': true,
    };
    final http = RecordingHttpClient([profile, profile]);
    final api = ProfileApi(http);

    expect((await api.fetch()).formattedNote, '<p>raw</p>');
    await api.update(
      const MastodonProfileUpdateRequest(
        avatarDescription: 'Portrait',
        showFeatured: false,
      ),
    );

    expect(http.requests.last.method, 'PATCH');
    expect(http.requests.last.data, {
      'avatar_description': 'Portrait',
      'show_featured': false,
    });
  });

  test('AnnualReportsApi covers all annual report routes', () async {
    final result = {
      'annual_reports': <dynamic>[],
      'accounts': <dynamic>[],
      'statuses': <dynamic>[],
    };
    final http = RecordingHttpClient([
      result,
      result,
      {'state': 'eligible'},
    ]);
    final api = AnnualReportsApi(http);

    expect((await api.fetch()).annualReports, isEmpty);
    await api.fetchForYear(2026);
    expect(await api.fetchState(2026), MastodonAnnualReportState.eligible);
    await api.generate(2026);
    await api.markRead(2026);

    expect(
      http.requests.map((request) => '${request.method} ${request.path}'),
      [
        'GET /api/v1/annual_reports',
        'GET /api/v1/annual_reports/2026',
        'GET /api/v1/annual_reports/2026/state',
        'POST /api/v1/annual_reports/2026/generate',
        'POST /api/v1/annual_reports/2026/read',
      ],
    );
  });

  test('single-purpose endpoints use their server routes', () async {
    final http = RecordingHttpClient([
      [
        {'code': 'ja', 'name': '日本語'},
      ],
      ['mastodon.social'],
      {'following_count': 2, 'followers_count': 3},
      <String, dynamic>{'id': 'campaign'},
    ]);

    expect((await InstanceApi(http).fetchLanguages()).single.code, 'ja');
    expect(await InstanceApi(http).searchPeers('mast'), ['mastodon.social']);
    expect(
      (await DomainBlocksApi(http).preview('example.org')).followersCount,
      3,
    );
    expect((await DonationCampaignsApi(http).fetch())?['id'], 'campaign');
    await AccountsApi(http).subscribeToEmailUpdates('1', 'reader@example.org');
    await GroupedNotificationsApi(http).clear();

    expect(http.requests[1].queryParameters, {'q': 'mast'});
    expect(http.requests[2].queryParameters, {'domain': 'example.org'});
    expect(http.requests[4].data, {'email': 'reader@example.org'});
  });

  test(
    'conversation unread and v1 notification policy are supported',
    () async {
      final conversation = <String, dynamic>{
        'id': '1',
        'unread': true,
        'accounts': <dynamic>[],
      };
      final policy = <String, dynamic>{
        'filter_not_following': true,
        'filter_not_followers': false,
        'filter_new_accounts': true,
        'filter_private_mentions': false,
        'filter_bots': true,
      };
      final http = RecordingHttpClient([conversation, policy, policy]);

      expect((await ConversationsApi(http).markAsUnread('1')).unread, isTrue);
      final fetched = await NotificationsApi(http).fetchPolicyV1();
      expect(fetched.filterBots, isTrue);
      await NotificationsApi(http).updatePolicyV1(fetched);

      expect(http.requests.first.path, '/api/v1/conversations/1/unread');
      expect(http.requests.last.method, 'PATCH');
    },
  );

  test('OAuthApi supports introspection and token info', () async {
    final http = RecordingHttpClient([
      {'active': true, 'scope': 'read', 'client_id': 'client'},
      {'resource_owner_id': '1'},
    ]);
    final api = OAuthApi(http);

    final result = await api.introspectToken(
      token: 'token',
      clientId: 'client',
      clientSecret: 'secret',
    );
    expect(result.active, isTrue);
    expect((await api.fetchTokenInfo())['resource_owner_id'], '1');
    expect(
      http.requests.first.contentType,
      'application/x-www-form-urlencoded',
    );
  });
}
