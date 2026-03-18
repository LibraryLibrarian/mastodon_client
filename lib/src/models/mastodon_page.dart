/// Generic model representing a paginated list result.
///
/// Holds next-page and previous-page cursor values from the Mastodon API's
/// cursor-based pagination (`Link` header).
class MastodonPage<T> {
  /// Creates with [items] as the page contents, and [nextMaxId] and [prevMinId]
  /// as pagination cursors.
  const MastodonPage({
    required this.items,
    this.nextMaxId,
    this.prevMinId,
  });

  /// List of items in the page.
  final List<T> items;

  /// `max_id` cursor for fetching the next page. `null` if no next page exists.
  final String? nextMaxId;

  /// `min_id` cursor for fetching the previous page. `null` if no previous
  /// page exists.
  final String? prevMinId;
}
