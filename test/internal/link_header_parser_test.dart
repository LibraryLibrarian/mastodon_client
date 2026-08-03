import 'package:mastodon_client/src/internal/link_header_parser.dart';
import 'package:test/test.dart';

void main() {
  group('parseNextMaxId', () {
    test('extracts max_id from a header with both next and prev', () {
      const header =
          '<https://mastodon.test/api/v1/timelines/home?max_id=100>; '
          'rel="next", '
          '<https://mastodon.test/api/v1/timelines/home?min_id=200>; '
          'rel="prev"';
      expect(parseNextMaxId(header), '100');
    });

    test('extracts max_id from a header with only rel="next"', () {
      const header =
          '<https://mastodon.test/api/v1/timelines/home?max_id=100>; '
          'rel="next"';
      expect(parseNextMaxId(header), '100');
    });

    test('returns null when only rel="prev" is present', () {
      const header =
          '<https://mastodon.test/api/v1/timelines/home?min_id=200>; '
          'rel="prev"';
      expect(parseNextMaxId(header), isNull);
    });

    test('returns null when the header is null', () {
      expect(parseNextMaxId(null), isNull);
    });

    test('returns null when the header is an empty string', () {
      expect(parseNextMaxId(''), isNull);
    });

    test('returns null when the next URL has no max_id query parameter', () {
      const header =
          '<https://mastodon.test/api/v1/timelines/home>; rel="next"';
      expect(parseNextMaxId(header), isNull);
    });

    test('returns null when the segment is malformed (missing angle '
        'brackets)', () {
      const header =
          'https://mastodon.test/api/v1/timelines/home?max_id=1, '
          'rel="next"';
      expect(parseNextMaxId(header), isNull);
    });

    test('handles the rel="prev" segment appearing before rel="next"', () {
      const header =
          '<https://mastodon.test/api/v1/timelines/home?min_id=200>; '
          'rel="prev", '
          '<https://mastodon.test/api/v1/timelines/home?max_id=100>; '
          'rel="next"';
      expect(parseNextMaxId(header), '100');
    });
  });

  group('parsePrevMinId', () {
    test('extracts min_id when present', () {
      const header =
          '<https://mastodon.test/api/v1/timelines/home?min_id=200>; '
          'rel="prev"';
      expect(parsePrevMinId(header), '200');
    });

    test('falls back to since_id when min_id is absent', () {
      const header =
          '<https://mastodon.test/api/v1/notifications?since_id=50>; '
          'rel="prev"';
      expect(parsePrevMinId(header), '50');
    });

    test('prefers min_id over since_id when both are present', () {
      const header =
          '<https://mastodon.test/api/v1/timelines/home?min_id=200&'
          'since_id=50>; rel="prev"';
      expect(parsePrevMinId(header), '200');
    });

    test('returns null when only rel="next" is present', () {
      const header =
          '<https://mastodon.test/api/v1/timelines/home?max_id=100>; '
          'rel="next"';
      expect(parsePrevMinId(header), isNull);
    });

    test('returns null when the header is null', () {
      expect(parsePrevMinId(null), isNull);
    });
  });
}
