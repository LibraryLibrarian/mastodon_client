import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_status.dart';

/// Timelines API.
class TimelinesApi {
  const TimelinesApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches the home timeline.
  ///
  /// `GET /api/v1/timelines/home`
  ///
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). Use [sinceId] for newer statuses, [maxId] for older
  /// ones, and [minId] for forward pagination.
  Future<MastodonPage<MastodonStatus>> fetchHome({
    int? limit,
    String? sinceId,
    String? maxId,
    String? minId,
  }) => _fetchTimeline(
    '/api/v1/timelines/home',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
  );

  /// Fetches the local timeline.
  ///
  /// `GET /api/v1/timelines/public?local=true`
  ///
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). Use [sinceId] for newer statuses, [maxId] for older
  /// ones, and [minId] for forward pagination. Set [onlyMedia] to `true`
  /// to return only statuses with media attachments.
  Future<MastodonPage<MastodonStatus>> fetchLocal({
    int? limit,
    String? sinceId,
    String? maxId,
    String? minId,
    bool? onlyMedia,
  }) => _fetchTimeline(
    '/api/v1/timelines/public',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
    extraQuery: {
      'local': true,
      'only_media': ?onlyMedia,
    },
  );

  /// Fetches the federated timeline.
  ///
  /// `GET /api/v1/timelines/public`
  ///
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). Use [sinceId] for newer statuses, [maxId] for older
  /// ones, and [minId] for forward pagination. Set [onlyMedia] to `true`
  /// to return only statuses with media attachments, or [remoteOnly] to
  /// `true` to return only remote statuses.
  Future<MastodonPage<MastodonStatus>> fetchFederated({
    int? limit,
    String? sinceId,
    String? maxId,
    String? minId,
    bool? onlyMedia,
    bool? remoteOnly,
  }) => _fetchTimeline(
    '/api/v1/timelines/public',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
    extraQuery: {
      'only_media': ?onlyMedia,
      'remote': ?remoteOnly,
    },
  );

  /// Fetches the timeline for the specified hashtag.
  ///
  /// `GET /api/v1/timelines/tag/:hashtag`
  ///
  /// [hashtag] is the tag to filter on, without the `#` prefix. [limit]
  /// controls the maximum number of results (uses server default when
  /// omitted). Use [sinceId] for newer statuses, [maxId] for older ones,
  /// and [minId] for forward pagination. Set [localOnly] or [remoteOnly]
  /// to restrict to local or remote statuses respectively, and [onlyMedia]
  /// to require media attachments. [any] also includes statuses with any
  /// of those additional tags, [all] requires all of them, and [none]
  /// excludes statuses containing any of them.
  Future<MastodonPage<MastodonStatus>> fetchHashtag(
    String hashtag, {
    int? limit,
    String? sinceId,
    String? maxId,
    String? minId,
    bool? localOnly,
    bool? remoteOnly,
    bool? onlyMedia,
    List<String>? any,
    List<String>? all,
    List<String>? none,
  }) => _fetchTimeline(
    '/api/v1/timelines/tag/$hashtag',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
    extraQuery: {
      'local': ?localOnly,
      'remote': ?remoteOnly,
      'only_media': ?onlyMedia,
      if (any != null && any.isNotEmpty) 'any[]': any,
      if (all != null && all.isNotEmpty) 'all[]': all,
      if (none != null && none.isNotEmpty) 'none[]': none,
    },
  );

  /// Fetches the timeline for the specified list.
  ///
  /// `GET /api/v1/timelines/list/:list_id`
  ///
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). Use [sinceId] for newer statuses, [maxId] for older
  /// ones, and [minId] for forward pagination.
  Future<MastodonPage<MastodonStatus>> fetchList(
    String listId, {
    int? limit,
    String? sinceId,
    String? maxId,
    String? minId,
  }) => _fetchTimeline(
    '/api/v1/timelines/list/$listId',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
  );

  /// Fetches the timeline of statuses related to the specified URL.
  ///
  /// `GET /api/v1/timelines/link`
  ///
  /// [url] is required. [limit] controls the maximum number of results
  /// (uses server default when omitted). Use [sinceId] for newer statuses,
  /// [maxId] for older ones, and [minId] for forward pagination.
  Future<MastodonPage<MastodonStatus>> fetchLink(
    String url, {
    int? limit,
    String? sinceId,
    String? maxId,
    String? minId,
  }) => _fetchTimeline(
    '/api/v1/timelines/link',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
    extraQuery: {'url': url},
  );

  /// Fetches the direct message timeline.
  ///
  /// `GET /api/v1/timelines/direct`
  ///
  /// **Deprecated**: Deprecated in Mastodon 2.6.0, removed in 3.0.0.
  /// Use the Conversations API instead.
  ///
  /// [limit] controls the maximum number of results (default: 20, max: 40).
  /// Use [sinceId] for newer statuses, [maxId] for older ones, and [minId]
  /// for forward pagination.
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated(
    'Removed in Mastodon 3.0.0. Use ConversationsApi instead',
  )
  Future<MastodonPage<MastodonStatus>> fetchDirect({
    int? limit,
    String? sinceId,
    String? maxId,
    String? minId,
  }) => _fetchTimeline(
    '/api/v1/timelines/direct',
    limit: limit,
    sinceId: sinceId,
    maxId: maxId,
    minId: minId,
  );

  Future<MastodonPage<MastodonStatus>> _fetchTimeline(
    String path, {
    int? limit,
    String? sinceId,
    String? maxId,
    String? minId,
    Map<String, dynamic>? extraQuery,
  }) async {
    final query = <String, dynamic>{
      'limit': ?limit,
      if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
      if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
      if (minId != null && minId.isNotEmpty) 'min_id': minId,
      ...?extraQuery,
    };
    final response = await _http.sendRaw<List<dynamic>>(
      path,
      queryParameters: query,
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList(growable: false);
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }
}
