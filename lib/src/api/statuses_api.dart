import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_preview_card.dart';
import '../models/mastodon_scheduled_status.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_status_context.dart';
import '../models/mastodon_status_create_request.dart';
import '../models/mastodon_status_create_result.dart';
import '../models/mastodon_status_edit.dart';
import '../models/mastodon_status_edit_request.dart';
import '../models/mastodon_status_source.dart';
import '../models/mastodon_translation.dart';

/// Statuses API.
class StatusesApi {
  const StatusesApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches a single status.
  ///
  /// `GET /api/v1/statuses/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatus> fetch(String id) async {
    final data = await _http.send<Map<String, dynamic>>('/api/v1/statuses/$id');
    return MastodonStatus.fromJson(data!);
  }

  /// Fetches multiple statuses at once.
  ///
  /// `GET /api/v1/statuses`
  ///
  /// Non-existent or inaccessible IDs are excluded from the results.
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonStatus>> fetchMultiple(List<String> ids) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/statuses',
      queryParameters: <String, dynamic>{'id[]': ids},
    );
    return (data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
  }

  /// Fetches the context (ancestors and descendants) of a status.
  ///
  /// `GET /api/v1/statuses/{id}/context`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatusContext> fetchContext(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/context',
    );
    return MastodonStatusContext.fromJson(data!);
  }

  /// Fetches the source information of a status.
  ///
  /// `GET /api/v1/statuses/{id}/source`
  ///
  /// Returns the plain text content for use in editing screens.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatusSource> fetchSource(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/source',
    );
    return MastodonStatusSource.fromJson(data!);
  }

  /// Fetches the edit history of a status.
  ///
  /// `GET /api/v1/statuses/{id}/history`
  ///
  /// Returns all revisions from the initial post to the current state.
  ///
  /// Throws a `MastodonException` on failure.
  Future<List<MastodonStatusEdit>> fetchHistory(String id) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/statuses/$id/history',
    );
    return (data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonStatusEdit.fromJson)
        .toList();
  }

  /// Fetches the preview card of a status.
  ///
  /// `GET /api/v1/statuses/{id}/card`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPreviewCard> fetchCard(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/card',
    );
    return MastodonPreviewCard.fromJson(data!);
  }

  /// Fetches the statuses that quote the specified status.
  ///
  /// `GET /api/v1/statuses/{id}/quotes`
  ///
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). Use [sinceId] to return only statuses newer than that
  /// ID, and [maxId] to return only statuses older than it.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonStatus>> fetchQuotes(
    String id, {
    int? limit,
    String? sinceId,
    String? maxId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/statuses/$id/quotes',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'since_id': ?sinceId,
        'max_id': ?maxId,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Boosts the specified status.
  ///
  /// `POST /api/v1/statuses/{id}/reblog`
  ///
  /// Returns a **boost wrapper status**, which differs from the original:
  /// [MastodonStatus.id] is a new ID for the boost itself,
  /// [MastodonStatus.account] is the boosting user's account,
  /// [MastodonStatus.content] is an empty string, and
  /// [MastodonStatus.reblog] contains the original status (the main
  /// payload), including the updated [MastodonStatus.reblogsCount].
  /// [MastodonStatus.reblogged] is `true`.
  ///
  /// [visibility] sets the boost visibility (uses server default when
  /// omitted).
  Future<MastodonStatus> boost(String id, {String? visibility}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/reblog',
      method: 'POST',
      data: <String, dynamic>{'visibility': ?visibility},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Removes a boost from the specified status.
  ///
  /// `POST /api/v1/statuses/{id}/unreblog`
  ///
  /// Unlike [boost], returns **the original status itself**, not a wrapper.
  /// [MastodonStatus.reblog] is `null`, [MastodonStatus.reblogged] is
  /// `false`, and [MastodonStatus.reblogsCount] reflects the updated count.
  Future<MastodonStatus> unboost(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unreblog',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Favourites the specified status.
  ///
  /// `POST /api/v1/statuses/{id}/favourite`
  ///
  /// Returns **the original status** with updated state.
  /// [MastodonStatus.favourited] is `true` and
  /// [MastodonStatus.favouritesCount] reflects the updated count.
  Future<MastodonStatus> favourite(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/favourite',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Unfavourites the specified status.
  ///
  /// `POST /api/v1/statuses/{id}/unfavourite`
  ///
  /// Returns **the original status** with updated state.
  /// [MastodonStatus.favourited] is `false` and
  /// [MastodonStatus.favouritesCount] reflects the updated count.
  Future<MastodonStatus> unfavourite(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unfavourite',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Bookmarks the specified status.
  ///
  /// `POST /api/v1/statuses/{id}/bookmark`
  ///
  /// Returns **the original status** with updated state.
  /// [MastodonStatus.bookmarked] is `true`.
  Future<MastodonStatus> bookmark(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/bookmark',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Removes a bookmark from the specified status.
  ///
  /// `POST /api/v1/statuses/{id}/unbookmark`
  ///
  /// Returns **the original status** with updated state.
  /// [MastodonStatus.bookmarked] is `false`.
  Future<MastodonStatus> unbookmark(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unbookmark',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Mutes conversation notifications for the specified status.
  ///
  /// `POST /api/v1/statuses/{id}/mute`
  ///
  /// Stops notifications for a thread the user is participating in.
  /// Returns **the original status** with [MastodonStatus.muted] set to
  /// `true`.
  Future<MastodonStatus> mute(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/mute',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Unmutes conversation notifications for the specified status.
  ///
  /// `POST /api/v1/statuses/{id}/unmute`
  ///
  /// Returns **the original status** with [MastodonStatus.muted] set to
  /// `false`.
  Future<MastodonStatus> unmute(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unmute',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Pins the specified status to the user's profile.
  ///
  /// `POST /api/v1/statuses/{id}/pin`
  ///
  /// Only the user's own statuses can be pinned. Boosts cannot be pinned.
  /// Returns **the original status** with [MastodonStatus.pinned] set to
  /// `true`.
  Future<MastodonStatus> pin(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/pin',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Unpins the specified status from the user's profile.
  ///
  /// `POST /api/v1/statuses/{id}/unpin`
  ///
  /// Returns **the original status** with [MastodonStatus.pinned] set to
  /// `false`.
  Future<MastodonStatus> unpin(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unpin',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Fetches the accounts that boosted the specified status.
  ///
  /// `GET /api/v1/statuses/{id}/reblogged_by`
  ///
  /// [limit] controls the maximum number of results (default: 40, max: 80).
  /// Use [maxId] to return results older than that ID and [sinceId] for
  /// newer results.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAccount>> fetchRebloggedBy(
    String id, {
    String? maxId,
    String? sinceId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/statuses/$id/reblogged_by',
      queryParameters: <String, dynamic>{
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'limit': ?limit,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Fetches the accounts that favourited the specified status.
  ///
  /// `GET /api/v1/statuses/{id}/favourited_by`
  ///
  /// [limit] controls the maximum number of results (default: 40, max: 80).
  /// Use [maxId] to return results older than that ID and [sinceId] for
  /// newer results.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonAccount>> fetchFavouritedBy(
    String id, {
    String? maxId,
    String? sinceId,
    int? limit,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/statuses/$id/favourited_by',
      queryParameters: <String, dynamic>{
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'limit': ?limit,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Creates a new status.
  ///
  /// `POST /api/v1/statuses`
  ///
  /// [idempotencyKey] is an arbitrary string for duplicate prevention; the
  /// server returns the same result for repeated requests with the same key.
  /// Returns [MastodonStatusScheduled] when `scheduled_at` is set in
  /// [request], or [MastodonStatusCreated] otherwise.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatusCreateResult> create(
    MastodonStatusCreateRequest request, {
    String? idempotencyKey,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses',
      method: 'POST',
      data: request.toJson(),
      headers: idempotencyKey != null
          ? {'Idempotency-Key': idempotencyKey}
          : null,
    );
    if (request.scheduledAt != null) {
      return MastodonStatusScheduled(
        MastodonScheduledStatus.fromJson(data!),
      );
    }
    return MastodonStatusCreated(MastodonStatus.fromJson(data!));
  }

  /// Edits the user's own status.
  ///
  /// `PUT /api/v1/statuses/{id}`
  ///
  /// Can modify the body, content warning, media attachments, and poll.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatus> edit(
    String id,
    MastodonStatusEditRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id',
      method: 'PUT',
      data: request.toJson(),
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Deletes the user's own status.
  ///
  /// `DELETE /api/v1/statuses/{id}`
  ///
  /// Returns a snapshot of the deleted status containing source information
  /// such as `text` and `mediaAttachments` for redraft purposes. Set
  /// [deleteMedia] to `true` to immediately delete attached media as well.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatus> delete(String id, {bool? deleteMedia}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id',
      method: 'DELETE',
      queryParameters: <String, dynamic>{
        'delete_media': ?deleteMedia,
      },
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Translates the content of a status.
  ///
  /// `POST /api/v1/statuses/{id}/translate`
  ///
  /// Only public or unlisted statuses can be translated. [lang] is the
  /// target language code in ISO 639-1 format; the user locale is used
  /// when omitted.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonTranslation> translate(String id, {String? lang}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/translate',
      method: 'POST',
      data: <String, dynamic>{
        'lang': ?lang,
      },
    );
    return MastodonTranslation.fromJson(data!);
  }

  /// Updates the interaction policy of a status.
  ///
  /// `PUT /api/v1/statuses/{id}/interaction_policy`
  ///
  /// Currently used to change the quote approval policy. [quoteApprovalPolicy]
  /// must be one of `public`, `followers`, or `nobody`.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatus> updateInteractionPolicy(
    String id, {
    required String quoteApprovalPolicy,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/interaction_policy',
      method: 'PUT',
      data: <String, dynamic>{
        'quote_approval_policy': quoteApprovalPolicy,
      },
    );
    return MastodonStatus.fromJson(data!);
  }

  /// Revokes a quote of the specified status.
  ///
  /// `POST /api/v1/statuses/{id}/quotes/{quotingStatusId}/revoke`
  ///
  /// Detaches the quoting relationship from a status that quotes the user's
  /// post. [id] is the user's status being quoted and [quotingStatusId] is
  /// the status that performs the quote.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonStatus> revokeQuote(
    String id,
    String quotingStatusId,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/quotes/$quotingStatusId/revoke',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }
}
