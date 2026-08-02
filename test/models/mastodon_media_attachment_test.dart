import 'dart:convert';
import 'dart:io';
import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonMediaAttachment.fromJson', () {
    test('deserializes from fixture', () {
      final file = File('test/fixtures/media_attachment.json');
      final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
      final attachment = MastodonMediaAttachment.fromJson(json);

      expect(attachment.id, equals('116278608326522926'));
      expect(attachment.type, equals(MastodonMediaType.image));
      expect(
        attachment.url,
        equals(
          'https://localhost:3001/system/media_attachments/files/116/278/608/326/522/926/original/12c78247380f1a10.png',
        ),
      );
      expect(
        attachment.previewUrl,
        equals(
          'https://localhost:3001/system/media_attachments/files/116/278/608/326/522/926/small/12c78247380f1a10.png',
        ),
      );
      expect(attachment.remoteUrl, isNull);
      expect(
        attachment.description,
        equals('Test image for fixture collection'),
      );
      expect(
        attachment.blurhash,
        equals('U2TI:j|cfQ|c|cjtfQjtfQfQfQfQ|cjtfQjt'),
      );
    });
  });
}
