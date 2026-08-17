import 'dart:convert';
import 'dart:io';

import 'package:mastodon_client/mastodon_client.dart';
import 'package:mastodon_client/src/streaming/internal/streaming_event_decoder.dart';
import 'package:test/test.dart';

void main() {
  test('decodes an envelope with a double-encoded status payload', () {
    final status = jsonDecode(
      File('test/fixtures/status.json').readAsStringSync(),
    );
    final message = MastodonStreamingMessage.fromRaw(
      jsonEncode({
        'stream': ['public'],
        'event': 'update',
        'payload': jsonEncode(status),
      }),
    );

    final event = decodeMastodonStreamEvent(message);

    expect(message.stream, ['public']);
    expect(message.payload, isA<String>());
    expect(
      event,
      isA<MastodonUpdateEvent>().having(
        (event) => event.status.id,
        'status.id',
        (status as Map<String, dynamic>)['id'],
      ),
    );
  });

  test('keeps a numeric delete payload as a String', () {
    final message = MastodonStreamingMessage.fromRaw(
      jsonEncode({
        'stream': ['user'],
        'event': 'delete',
        'payload': '999888777',
      }),
    );

    final event = decodeMastodonStreamEvent(message);

    expect(
      event,
      isA<MastodonDeleteEvent>()
          .having((event) => event.statusId, 'statusId', '999888777')
          .having((event) => event.statusId, 'runtimeType', isA<String>()),
    );
  });

  test('decodes the streaming announcement reaction model', () {
    final reaction = jsonDecode(
      File(
        'test/fixtures/streaming_announcement_reaction.json',
      ).readAsStringSync(),
    );
    final message = MastodonStreamingMessage.fromRaw(
      jsonEncode({
        'stream': ['user'],
        'event': 'announcement.reaction',
        'payload': jsonEncode(reaction),
      }),
    );

    final event = decodeMastodonStreamEvent(message);

    expect(
      event,
      isA<MastodonAnnouncementReactionEvent>().having(
        (event) => event.reaction.announcementId,
        'announcementId',
        (reaction as Map<String, dynamic>)['announcement_id'],
      ),
    );
  });

  test('preserves unknown events and their raw payload', () {
    final message = MastodonStreamingMessage.fromRaw(
      jsonEncode({
        'stream': ['user'],
        'event': 'pleroma.custom',
        'payload': '{"custom":true}',
      }),
    );

    final event = decodeMastodonStreamEvent(message);

    expect(
      event,
      isA<MastodonUnknownStreamEvent>()
          .having((event) => event.event, 'event', 'pleroma.custom')
          .having((event) => event.rawPayload, 'rawPayload', '{"custom":true}'),
    );
  });

  test('falls back to Unknown when a known payload cannot be parsed', () {
    final message = MastodonStreamingMessage.fromRaw(
      jsonEncode({
        'stream': ['user'],
        'event': 'notification',
        'payload': '{bad json',
      }),
    );

    expect(
      decodeMastodonStreamEvent(message),
      isA<MastodonUnknownStreamEvent>().having(
        (event) => event.event,
        'event',
        'notification',
      ),
    );
  });

  test('ignores payloads for payload-free events', () {
    final merged = MastodonStreamingMessage.fromRaw(
      jsonEncode({
        'stream': ['user'],
        'event': 'notifications_merged',
        'payload': '1',
      }),
    );
    final filters = MastodonStreamingMessage.fromRaw(
      jsonEncode({
        'stream': ['user'],
        'event': 'filters_changed',
      }),
    );

    expect(
      decodeMastodonStreamEvent(merged),
      isA<MastodonNotificationsMergedEvent>(),
    );
    expect(
      decodeMastodonStreamEvent(filters),
      isA<MastodonFiltersChangedEvent>(),
    );
  });
}
