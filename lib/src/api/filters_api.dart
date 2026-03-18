import '../client/mastodon_http_client.dart';
import '../models/mastodon_filter.dart';

/// API client for filters.
///
/// Provides both v2 (server-side filtering, Mastodon 4.0+) and
/// v1 (client-side filtering, deprecated) endpoints.
class FiltersApi {
  /// Creates a [FiltersApi] instance with the given [MastodonHttpClient].
  const FiltersApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches all filters.
  ///
  /// `GET /api/v2/filters`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonFilter>> fetch() async {
    final data = await _http.send<List<dynamic>>('/api/v2/filters');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFilter.fromJson)
        .toList();
  }

  /// Fetches a filter by its ID.
  ///
  /// `GET /api/v2/filters/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonFilter> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/$id',
    );
    return MastodonFilter.fromJson(data!);
  }

  /// Creates a new filter.
  ///
  /// `POST /api/v2/filters`
  ///
  /// [title] and [context] are required. [context] is one or more of
  /// `home`, `notifications`, `public`, `thread`, `account`. [filterAction]
  /// sets the action on match (`warn`, `hide`, or `blur`). [expiresIn] is
  /// the expiration in seconds; pass `null` for no expiration. Provide
  /// [keywordsAttributes] to add keywords at creation time.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonFilter> create({
    required String title,
    required List<String> context,
    String? filterAction,
    int? expiresIn,
    List<MastodonFilterKeywordParam>? keywordsAttributes,
  }) async {
    final body = <String, dynamic>{
      'title': title,
      'context': context,
      'filter_action': ?filterAction,
      'expires_in': ?expiresIn,
    };
    if (keywordsAttributes != null) {
      body['keywords_attributes'] = keywordsAttributes
          .map(
            (kw) => <String, dynamic>{
              'keyword': kw.keyword,
              if (kw.wholeWord != null) 'whole_word': kw.wholeWord,
            },
          )
          .toList();
    }
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters',
      method: 'POST',
      data: body,
    );
    return MastodonFilter.fromJson(data!);
  }

  /// Updates a filter.
  ///
  /// `PUT /api/v2/filters/{id}`
  ///
  /// All parameters are optional; only the fields provided are updated.
  /// [keywordsAttributes] may include new keywords to add, existing ones
  /// to update, or ones marked with `_destroy` to delete.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonFilter> update(
    String id, {
    String? title,
    List<String>? context,
    String? filterAction,
    int? expiresIn,
    List<MastodonFilterKeywordUpdateParam>? keywordsAttributes,
  }) async {
    final body = <String, dynamic>{
      'title': ?title,
      'filter_action': ?filterAction,
      'expires_in': ?expiresIn,
    };
    if (context != null) {
      body['context'] = context;
    }
    if (keywordsAttributes != null) {
      body['keywords_attributes'] = keywordsAttributes
          .map(
            (kw) => <String, dynamic>{
              if (kw.id != null) 'id': kw.id,
              'keyword': kw.keyword,
              if (kw.wholeWord != null) 'whole_word': kw.wholeWord,
              if (kw.destroy != null) '_destroy': kw.destroy,
            },
          )
          .toList();
    }
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/$id',
      method: 'PUT',
      data: body,
    );
    return MastodonFilter.fromJson(data!);
  }

  /// Deletes a filter.
  ///
  /// `DELETE /api/v2/filters/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v2/filters/$id',
      method: 'DELETE',
    );
  }

  /// Fetches the keywords within a filter.
  ///
  /// `GET /api/v2/filters/{filterId}/keywords`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonFilterKeyword>> fetchKeywords(String filterId) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v2/filters/$filterId/keywords',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFilterKeyword.fromJson)
        .toList();
  }

  /// Adds a keyword to a filter.
  ///
  /// `POST /api/v2/filters/{filterId}/keywords`
  ///
  /// [keyword] is required. Set [wholeWord] to `true` to match only on
  /// word boundaries.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonFilterKeyword> createKeyword(
    String filterId, {
    required String keyword,
    bool? wholeWord,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/$filterId/keywords',
      method: 'POST',
      data: <String, dynamic>{
        'keyword': keyword,
        'whole_word': ?wholeWord,
      },
    );
    return MastodonFilterKeyword.fromJson(data!);
  }

  /// Fetches a specific keyword by ID.
  ///
  /// `GET /api/v2/filters/keywords/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonFilterKeyword> fetchKeywordById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/keywords/$id',
    );
    return MastodonFilterKeyword.fromJson(data!);
  }

  /// Updates a keyword.
  ///
  /// `PUT /api/v2/filters/keywords/{id}`
  ///
  /// [keyword] is required. Set [wholeWord] to `true` to match only on
  /// word boundaries.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonFilterKeyword> updateKeyword(
    String id, {
    required String keyword,
    bool? wholeWord,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/keywords/$id',
      method: 'PUT',
      data: <String, dynamic>{
        'keyword': keyword,
        'whole_word': ?wholeWord,
      },
    );
    return MastodonFilterKeyword.fromJson(data!);
  }

  /// Deletes a keyword.
  ///
  /// `DELETE /api/v2/filters/keywords/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> deleteKeyword(String id) async {
    await _http.send<void>(
      '/api/v2/filters/keywords/$id',
      method: 'DELETE',
    );
  }

  /// Fetches the status filters within a filter.
  ///
  /// `GET /api/v2/filters/{filterId}/statuses`
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonFilterStatus>> fetchStatuses(String filterId) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v2/filters/$filterId/statuses',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFilterStatus.fromJson)
        .toList();
  }

  /// Adds a status filter to a filter.
  ///
  /// `POST /api/v2/filters/{filterId}/statuses`
  ///
  /// [statusId] is the ID of the status to filter (required).
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonFilterStatus> createStatus(
    String filterId, {
    required String statusId,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/$filterId/statuses',
      method: 'POST',
      data: <String, dynamic>{'status_id': statusId},
    );
    return MastodonFilterStatus.fromJson(data!);
  }

  /// Fetches a specific status filter by ID.
  ///
  /// `GET /api/v2/filters/statuses/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonFilterStatus> fetchStatusById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/statuses/$id',
    );
    return MastodonFilterStatus.fromJson(data!);
  }

  /// Deletes a status filter.
  ///
  /// `DELETE /api/v2/filters/statuses/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> deleteStatus(String id) async {
    await _http.send<void>(
      '/api/v2/filters/statuses/$id',
      method: 'DELETE',
    );
  }

  /// Fetches all filters (v1, deprecated).
  ///
  /// `GET /api/v1/filters`
  ///
  /// Use [fetch] (v2) instead since Mastodon 4.0.
  ///
  /// Throws a `MastodonException` on failure.
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('Deprecated in Mastodon 4.0.0. Use fetch() (v2) instead')
  Future<List<MastodonFilterV1>> fetchV1() async {
    final data = await _http.send<List<dynamic>>('/api/v1/filters');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFilterV1.fromJson)
        .toList();
  }

  /// Fetches a filter by ID (v1, deprecated).
  ///
  /// `GET /api/v1/filters/{id}`
  ///
  /// Use [fetchById] (v2) instead since Mastodon 4.0.
  ///
  /// Throws a `MastodonException` on failure.
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('Deprecated in Mastodon 4.0.0. Use fetchById() (v2) instead')
  Future<MastodonFilterV1> fetchByIdV1(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/filters/$id',
    );
    return MastodonFilterV1.fromJson(data!);
  }

  /// Creates a new filter (v1, deprecated).
  ///
  /// `POST /api/v1/filters`
  ///
  /// [phrase] and [context] are required. [context] is one or more of
  /// `home`, `notifications`, `public`, `thread`, `account`. Set
  /// [irreversible] to `true` to permanently drop matching posts from
  /// home and notifications (default: `false`). [wholeWord] enables
  /// word-boundary matching (default: `false`). [expiresIn] is the
  /// expiration in seconds; pass `null` for no expiration.
  ///
  /// Use [create] (v2) instead since Mastodon 4.0.
  ///
  /// Throws a `MastodonException` on failure.
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('Deprecated in Mastodon 4.0.0. Use create() (v2) instead')
  Future<MastodonFilterV1> createV1({
    required String phrase,
    required List<String> context,
    bool? irreversible,
    bool? wholeWord,
    int? expiresIn,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/filters',
      method: 'POST',
      data: <String, dynamic>{
        'phrase': phrase,
        'context': context,
        'irreversible': ?irreversible,
        'whole_word': ?wholeWord,
        'expires_in': ?expiresIn,
      },
    );
    return MastodonFilterV1.fromJson(data!);
  }

  /// Updates a filter (v1, deprecated).
  ///
  /// `PUT /api/v1/filters/{id}`
  ///
  /// Returns an error when attempting to change `expires_in`, `irreversible`,
  /// or `context` on a filter with multiple keywords.
  ///
  /// [phrase] and [context] are required. [irreversible] and [wholeWord]
  /// default to `false`. [expiresIn] is the expiration in seconds.
  ///
  /// Use [update] (v2) instead since Mastodon 4.0.
  ///
  /// Throws a `MastodonException` on failure.
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('Deprecated in Mastodon 4.0.0. Use update() (v2) instead')
  Future<MastodonFilterV1> updateV1(
    String id, {
    required String phrase,
    required List<String> context,
    bool? irreversible,
    bool? wholeWord,
    int? expiresIn,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/filters/$id',
      method: 'PUT',
      data: <String, dynamic>{
        'phrase': phrase,
        'context': context,
        'irreversible': ?irreversible,
        'whole_word': ?wholeWord,
        'expires_in': ?expiresIn,
      },
    );
    return MastodonFilterV1.fromJson(data!);
  }

  /// Deletes a filter (v1, deprecated).
  ///
  /// `DELETE /api/v1/filters/{id}`
  ///
  /// Deletes only the FilterKeyword. Use [delete] (v2) to delete the
  /// parent Filter itself.
  ///
  /// Use [delete] (v2) instead since Mastodon 4.0.
  ///
  /// Throws a `MastodonException` on failure.
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated('Deprecated in Mastodon 4.0.0. Use delete() (v2) instead')
  Future<void> deleteV1(String id) async {
    await _http.send<void>(
      '/api/v1/filters/$id',
      method: 'DELETE',
    );
  }
}

/// Keyword parameter for filter creation.
class MastodonFilterKeywordParam {
  /// Creates a keyword parameter with [keyword] and optional [wholeWord] flag.
  const MastodonFilterKeywordParam({
    required this.keyword,
    this.wholeWord,
  });

  /// Keyword string.
  final String keyword;

  /// Whether to consider word boundaries.
  final bool? wholeWord;
}

/// Keyword parameter for filter updates.
class MastodonFilterKeywordUpdateParam {
  /// Creates a keyword update parameter. Specify [id] for existing keywords
  /// and set [destroy] to `true` to delete them.
  const MastodonFilterKeywordUpdateParam({
    required this.keyword,
    this.id,
    this.wholeWord,
    this.destroy,
  });

  /// ID of the existing keyword (specified for updates).
  final String? id;

  /// Keyword string.
  final String keyword;

  /// Whether to consider word boundaries.
  final bool? wholeWord;

  /// Set to `true` to delete this keyword.
  final bool? destroy;
}
