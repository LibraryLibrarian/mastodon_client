import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_account_create_request.dart';
import '../models/mastodon_credential_account.dart';
import '../models/mastodon_credential_account_update_request.dart';
import '../models/mastodon_familiar_followers.dart';
import '../models/mastodon_featured_tag.dart';
import '../models/mastodon_identity_proof.dart';
import '../models/mastodon_list.dart';
import '../models/mastodon_page.dart';
import '../models/mastodon_relationship.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_token.dart';

/// API client for retrieving and managing account information.
class AccountsApi {
  /// Creates an [AccountsApi] instance with the given [MastodonHttpClient].
  const AccountsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches account information by ID.
  ///
  /// `GET /api/v1/accounts/{accountId}`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonAccount> fetchById(String accountId) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$accountId',
    );
    return MastodonAccount.fromJson(data!);
  }

  /// Verifies the authenticated user's credentials.
  ///
  /// `GET /api/v1/accounts/verify_credentials`
  ///
  /// Returns a [MastodonCredentialAccount] as defined by the official spec.
  /// Includes additional information only available to the authenticated user,
  /// such as `source` and `role`.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonCredentialAccount> verifyCredentials() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/verify_credentials',
    );
    return MastodonCredentialAccount.fromJson(data!);
  }

  /// Looks up an account by its `acct` string.
  ///
  /// `GET /api/v1/accounts/lookup?acct={acct}`
  ///
  /// Falls back to [search] when the server returns 404, 405, 410, or 501,
  /// and returns the first result whose `acct` field matches
  /// (case-insensitive).
  /// Throws [MastodonNotFoundException] if no matching account is found after
  /// the fallback.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonAccount> lookup(String acct) async {
    try {
      final data = await _http.send<Map<String, dynamic>>(
        '/api/v1/accounts/lookup',
        queryParameters: <String, dynamic>{'acct': acct},
      );
      return MastodonAccount.fromJson(data!);
    } on MastodonApiException catch (e) {
      if (e.statusCode == 404 ||
          e.statusCode == 405 ||
          e.statusCode == 410 ||
          e.statusCode == 501) {
        return _lookupViaSearch(acct);
      }
      rethrow;
    }
  }

  /// Searches for accounts by keyword.
  ///
  /// `GET /api/v1/accounts/search?q={query}&resolve={resolve}&limit={limit}`
  ///
  /// [query] is the search string. [limit] controls the maximum number of
  /// results (uses server default when omitted), and [offset] skips that
  /// many results from the beginning. When [resolve] is `true`, remote
  /// accounts are resolved via WebFinger. When [following] is `true`,
  /// only accounts the user is already following are returned.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<List<MastodonAccount>> search(
    String query, {
    int? limit,
    int? offset,
    bool? resolve,
    bool? following,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/search',
      queryParameters: <String, dynamic>{
        'q': query,
        'resolve': ?resolve,
        'following': ?following,
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }

  /// Fetches the followers of the specified account.
  ///
  /// `GET /api/v1/accounts/{accountId}/followers`
  ///
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). Use [maxId], [sinceId], and [minId] for pagination:
  /// pass the `nextMaxId` from the previous response as [maxId] to page
  /// backward, or use [minId] for forward pagination.
  ///
  /// Returns an empty [MastodonPage] for private accounts (HTTP 403).
  /// Throws a subclass of [MastodonException] on other failures.
  Future<MastodonPage<MastodonAccount>> fetchFollowers(
    String accountId, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$accountId/followers',
    limit: limit,
    maxId: maxId,
    sinceId: sinceId,
    minId: minId,
  );

  /// Fetches the accounts followed by the specified account.
  ///
  /// `GET /api/v1/accounts/{accountId}/following`
  ///
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). Use [maxId], [sinceId], and [minId] for pagination:
  /// pass the `nextMaxId` from the previous response as [maxId] to page
  /// backward, or use [minId] for forward pagination.
  ///
  /// Returns an empty [MastodonPage] for private accounts (HTTP 403).
  /// Throws a subclass of [MastodonException] on other failures.
  Future<MastodonPage<MastodonAccount>> fetchFollowing(
    String accountId, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$accountId/following',
    limit: limit,
    maxId: maxId,
    sinceId: sinceId,
    minId: minId,
  );

  /// Fetches the statuses posted by the specified account.
  ///
  /// `GET /api/v1/accounts/{accountId}/statuses`
  ///
  /// [limit] controls the maximum number of results (uses server default
  /// when omitted). Pass the last status ID as [maxId] to page backward,
  /// or use [minId] for forward pagination; [sinceId] returns only statuses
  /// newer than that ID. Set [excludeReplies] or [excludeReblogs] to `true`
  /// to omit replies or boosts respectively. [onlyMedia] restricts results
  /// to statuses with media attachments, [pinned] to pinned statuses only,
  /// and [tagged] filters to statuses containing the specified hashtag.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonPage<MastodonStatus>> fetchStatuses(
    String accountId, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
    bool? excludeReplies,
    bool? excludeReblogs,
    bool? onlyMedia,
    bool? pinned,
    String? tagged,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/accounts/$accountId/statuses',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'min_id': ?minId,
        'exclude_replies': ?excludeReplies,
        'exclude_reblogs': ?excludeReblogs,
        'only_media': ?onlyMedia,
        'pinned': ?pinned,
        'tagged': ?tagged,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Updates the authenticated user's profile information.
  ///
  /// `PATCH /api/v1/accounts/update_credentials`
  ///
  /// Specify only the fields to update in [request].
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonCredentialAccount> updateCredentials(
    MastodonCredentialAccountUpdateRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/update_credentials',
      method: 'PATCH',
      data: request.toJson(),
    );
    return MastodonCredentialAccount.fromJson(data!);
  }

  /// Registers a new account.
  ///
  /// `POST /api/v1/accounts`
  ///
  /// Requires an app token. Returns a [MastodonToken] associated with the
  /// newly created user on success.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonToken> create(MastodonAccountCreateRequest request) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts',
      method: 'POST',
      data: request.toJson(),
    );
    return MastodonToken.fromJson(data!);
  }

  /// Fetches multiple accounts by their IDs.
  ///
  /// `GET /api/v1/accounts?id[]={id}`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<List<MastodonAccount>> fetchMultiple(List<String> ids) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts',
      queryParameters: <String, dynamic>{'id[]': ids},
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }

  /// Follows the specified account.
  ///
  /// `POST /api/v1/accounts/{id}/follow`
  ///
  /// [reblogs] controls whether boosts appear on the home timeline.
  /// Set [notify] to `true` to receive notifications when the account
  /// posts. [languages] restricts the followed content to the given
  /// ISO 639-1 language codes.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> follow(
    String id, {
    bool? reblogs,
    bool? notify,
    List<String>? languages,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/follow',
      method: 'POST',
      data: <String, dynamic>{
        'reblogs': ?reblogs,
        'notify': ?notify,
        'languages': ?languages,
      },
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Unfollows the specified account.
  ///
  /// `POST /api/v1/accounts/{id}/unfollow`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> unfollow(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unfollow',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Removes the specified account from the user's followers.
  ///
  /// `POST /api/v1/accounts/{id}/remove_from_followers`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> removeFromFollowers(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/remove_from_followers',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Blocks the specified account.
  ///
  /// `POST /api/v1/accounts/{id}/block`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> block(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/block',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Unblocks the specified account.
  ///
  /// `POST /api/v1/accounts/{id}/unblock`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> unblock(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unblock',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Mutes the specified account.
  ///
  /// `POST /api/v1/accounts/{id}/mute`
  ///
  /// [notifications] controls whether notifications are also muted
  /// (defaults to `true`). [duration] sets the mute duration in seconds;
  /// pass `0` or omit it for an indefinite mute.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> mute(
    String id, {
    bool? notifications,
    int? duration,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/mute',
      method: 'POST',
      data: <String, dynamic>{
        'notifications': ?notifications,
        'duration': ?duration,
      },
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Unmutes the specified account.
  ///
  /// `POST /api/v1/accounts/{id}/unmute`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> unmute(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unmute',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Pins the specified account on the user's profile.
  ///
  /// `POST /api/v1/accounts/{id}/pin`
  ///
  /// **Deprecated**: Use [endorse] since Mastodon 4.4.0.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  @Deprecated('Use endorse() since Mastodon 4.4.0')
  Future<MastodonRelationship> pin(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/pin',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Unpins the specified account from the user's profile.
  ///
  /// `POST /api/v1/accounts/{id}/unpin`
  ///
  /// **Deprecated**: Use [unendorse] since Mastodon 4.4.0.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  @Deprecated('Use unendorse() since Mastodon 4.4.0')
  Future<MastodonRelationship> unpin(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unpin',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Features the specified account on the user's profile.
  ///
  /// `POST /api/v1/accounts/{id}/endorse`
  ///
  /// The target account must be followed beforehand.
  /// Returns HTTP 422 if the account is not followed.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> endorse(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/endorse',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Removes the specified account from the user's profile features.
  ///
  /// `POST /api/v1/accounts/{id}/unendorse`
  ///
  /// Succeeds even if the account is not currently featured.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> unendorse(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unendorse',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Fetches the accounts featured by the specified account.
  ///
  /// `GET /api/v1/accounts/{id}/endorsements`
  ///
  /// [limit] controls the maximum number of results (server default is 40).
  /// Pass the `nextMaxId` from the previous response as [maxId] to page
  /// backward; use [sinceId] to receive only newer results, or [minId]
  /// for forward pagination.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonPage<MastodonAccount>> fetchEndorsements(
    String id, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$id/endorsements',
    limit: limit,
    maxId: maxId,
    sinceId: sinceId,
    minId: minId,
  );

  /// Sets a private note on the specified account.
  ///
  /// `POST /api/v1/accounts/{id}/note`
  ///
  /// [comment] is the note content. Pass `null` or an empty string to
  /// remove the note.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<MastodonRelationship> setNote(
    String id, {
    String? comment,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/note',
      method: 'POST',
      data: <String, dynamic>{
        'comment': ?comment,
      },
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// Fetches relationships with multiple accounts.
  ///
  /// `GET /api/v1/accounts/relationships?id[]={id}`
  ///
  /// [ids] is the list of target account IDs. Set [withSuspended] to `true`
  /// to include suspended accounts in the results.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<List<MastodonRelationship>> fetchRelationships(
    List<String> ids, {
    bool? withSuspended,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/relationships',
      queryParameters: <String, dynamic>{
        'id[]': ids,
        'with_suspended': ?withSuspended,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonRelationship.fromJson)
        .toList();
  }

  /// Fetches familiar followers (mutual followees) of the specified accounts.
  ///
  /// `GET /api/v1/accounts/familiar_followers?id[]={id}`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<List<MastodonFamiliarFollowers>> fetchFamiliarFollowers(
    List<String> ids,
  ) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/familiar_followers',
      queryParameters: <String, dynamic>{'id[]': ids},
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFamiliarFollowers.fromJson)
        .toList();
  }

  /// Fetches the featured tags of the specified account.
  ///
  /// `GET /api/v1/accounts/{id}/featured_tags`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<List<MastodonFeaturedTag>> fetchFeaturedTags(String id) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/$id/featured_tags',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFeaturedTag.fromJson)
        .toList();
  }

  /// Fetches the lists that contain the specified account.
  ///
  /// `GET /api/v1/accounts/{id}/lists`
  ///
  /// Throws a subclass of [MastodonException] on failure.
  Future<List<MastodonList>> fetchLists(String id) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/$id/lists',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonList.fromJson)
        .toList();
  }

  /// Fetches the identity proofs of the specified account.
  ///
  /// `GET /api/v1/accounts/{id}/identity_proofs`
  ///
  /// **Deprecated**: Always returns an empty array since Mastodon 3.5.0.
  ///
  /// Throws a subclass of [MastodonException] on failure.
  @Deprecated('Always returns an empty array since Mastodon 3.5.0')
  Future<List<MastodonIdentityProof>> fetchIdentityProofs(String id) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/$id/identity_proofs',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonIdentityProof.fromJson)
        .toList();
  }

  Future<MastodonAccount> _lookupViaSearch(String acct) async {
    final results = await search(acct);
    final target = acct.toLowerCase();
    final match = results.where(
      (a) => a.acct.toLowerCase() == target,
    );
    if (match.isNotEmpty) {
      return match.first;
    }
    throw const MastodonNotFoundException(
      message: 'Account not found',
    );
  }

  Future<MastodonPage<MastodonAccount>> _fetchAccountPage(
    String path, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    try {
      final response = await _http.sendRaw<List<dynamic>>(
        path,
        queryParameters: <String, dynamic>{
          'limit': ?limit,
          'max_id': ?maxId,
          'since_id': ?sinceId,
          'min_id': ?minId,
        },
      );
      final linkHeader = response.headers.map['link']?.join(',');
      final items = (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonAccount.fromJson)
          .toList();
      return MastodonPage(
        items: items,
        nextMaxId: parseNextMaxId(linkHeader),
        prevMinId: parsePrevMinId(linkHeader),
      );
    } on MastodonForbiddenException {
      return const MastodonPage(items: []);
    }
  }
}
