import 'package:mastodon_client/mastodon_client.dart';
import 'package:test/test.dart';

void main() {
  group('MastodonTermsOfService.fromJson', () {
    test('deserializes effective terms of service', () {
      final json = <String, dynamic>{
        'effective_date': '2024-01-01',
        'effective': true,
        'content': '<p>By using this service you agree to our terms.</p>',
        'succeeded_by': null,
      };
      final tos = MastodonTermsOfService.fromJson(json);

      expect(tos.effectiveDate, '2024-01-01');
      expect(tos.effective, isTrue);
      expect(
        tos.content,
        '<p>By using this service you agree to our terms.</p>',
      );
      expect(tos.succeededBy, isNull);
    });

    test('deserializes superseded terms of service', () {
      final json = <String, dynamic>{
        'effective_date': '2023-06-01',
        'effective': false,
        'content': '<p>Old terms of service.</p>',
        'succeeded_by': '2024-01-01',
      };
      final tos = MastodonTermsOfService.fromJson(json);

      expect(tos.effectiveDate, '2023-06-01');
      expect(tos.effective, isFalse);
      expect(tos.content, '<p>Old terms of service.</p>');
      expect(tos.succeededBy, '2024-01-01');
    });

    test('effective defaults to false when omitted', () {
      final json = <String, dynamic>{
        'effective_date': '2025-03-01',
        'content': '<p>Terms.</p>',
      };
      final tos = MastodonTermsOfService.fromJson(json);

      expect(tos.effectiveDate, '2025-03-01');
      expect(tos.effective, isFalse);
      expect(tos.content, '<p>Terms.</p>');
      expect(tos.succeededBy, isNull);
    });

    test('content defaults to empty string when omitted', () {
      final json = <String, dynamic>{
        'effective_date': '2025-01-01',
        'effective': true,
      };
      final tos = MastodonTermsOfService.fromJson(json);

      expect(tos.content, '');
      expect(tos.effective, isTrue);
    });
  });
}
