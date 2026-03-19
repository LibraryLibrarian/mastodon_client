/// Parsing utility for `Link` response headers.
///
/// Extracts cursor values for `max_id` (next page) and `min_id` / `since_id`
/// (previous page) from the `Link` header used by Mastodon API pagination.
library;

/// Extracts the `max_id` query parameter from the `rel="next"` `Link` header.
///
/// Returns `null` if no next page exists or the header cannot be parsed.
String? parseNextMaxId(String? linkHeader) {
  return _extractQueryParam(linkHeader, 'next', 'max_id');
}

/// Extracts the previous-direction cursor value from the `rel="prev"`
/// `Link` header.
///
/// Since endpoints may use either `min_id` or `since_id`, this method
/// looks for `min_id` first and falls back to `since_id` if not found.
/// Returns `null` if no previous page exists or the header cannot be parsed.
String? parsePrevMinId(String? linkHeader) {
  return _extractQueryParam(linkHeader, 'prev', 'min_id') ??
      _extractQueryParam(linkHeader, 'prev', 'since_id');
}

String? _extractQueryParam(String? linkHeader, String rel, String param) {
  if (linkHeader == null) return null;
  for (final segment in linkHeader.split(',')) {
    final trimmed = segment.trim();
    if (!trimmed.contains('rel="$rel"')) continue;
    final start = trimmed.indexOf('<');
    final end = trimmed.indexOf('>');
    if (start == -1 || end == -1 || end <= start + 1) continue;
    final url = trimmed.substring(start + 1, end);
    final value = Uri.tryParse(url)?.queryParameters[param];
    if (value != null && value.isNotEmpty) return value;
  }
  return null;
}
