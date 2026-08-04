import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonDomainBlock.fromJson', () {
    test('deserializes suspend severity', () {
      final json = <String, dynamic>{
        'domain': 'spam.example.com',
        'digest':
            'a3b4c5d6e7f8a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a1b2c3d4e5f6a7b8',
        'severity': 'suspend',
        'comment': 'Known spam instance',
      };
      final block = MastodonDomainBlock.fromJson(json);

      expect(block.domain, 'spam.example.com');
      expect(
        block.digest,
        'a3b4c5d6e7f8a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a1b2c3d4e5f6a7b8',
      );
      expect(block.severity, MastodonDomainBlockSeverity.suspend);
      expect(block.comment, 'Known spam instance');
    });

    test('deserializes silence severity', () {
      final json = <String, dynamic>{
        'domain': 'noisy.example.org',
        'digest':
            'b1c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2',
        'severity': 'silence',
        'comment': 'Excessive noise, silenced',
      };
      final block = MastodonDomainBlock.fromJson(json);

      expect(block.domain, 'noisy.example.org');
      expect(block.severity, MastodonDomainBlockSeverity.silence);
      expect(block.comment, 'Excessive noise, silenced');
    });

    test('deserializes with null comment', () {
      final json = <String, dynamic>{
        'domain': 'blocked.example.net',
        'digest':
            'c2d3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3',
        'severity': 'suspend',
        'comment': null,
      };
      final block = MastodonDomainBlock.fromJson(json);

      expect(block.domain, 'blocked.example.net');
      expect(block.severity, MastodonDomainBlockSeverity.suspend);
      expect(block.comment, isNull);
    });

    test('deserializes unknown severity as unknown', () {
      final json = <String, dynamic>{
        'domain': 'future.example.com',
        'digest':
            'd3e4f5a6b7c8d9e0f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4',
        'severity': 'noop',
        'comment': null,
      };
      final block = MastodonDomainBlock.fromJson(json);

      expect(block.domain, 'future.example.com');
      expect(block.severity, MastodonDomainBlockSeverity.unknown);
    });
  });
}
