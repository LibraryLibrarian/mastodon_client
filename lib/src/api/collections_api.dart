import '../client/mastodon_http_client.dart';
import '../models/mastodon_collection.dart';

/// API client for Mastodon collections.
///
/// Available since Mastodon 4.6.0.
class CollectionsApi {
  const CollectionsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches collections owned by [accountId].
  Future<List<MastodonCollection>> fetchForAccount(
    String accountId, {
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$accountId/collections',
      queryParameters: {'limit': ?limit, 'offset': ?offset},
    );
    return ((data?['collections'] as List<dynamic>?) ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(MastodonCollection.fromJson)
        .toList(growable: false);
  }

  /// Fetches collections in which the authenticated account is featured.
  Future<List<MastodonCollection>> fetchFeaturingAccount(
    String accountId, {
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$accountId/in_collections',
      queryParameters: {'limit': ?limit, 'offset': ?offset},
    );
    return ((data?['collections'] as List<dynamic>?) ?? const <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(MastodonCollection.fromJson)
        .toList(growable: false);
  }

  /// Fetches a collection and its visible accounts.
  Future<MastodonCollectionDetail> fetch(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/collections/$id',
    );
    return MastodonCollectionDetail.fromJson(data!);
  }

  /// Creates a collection owned by the authenticated account.
  Future<MastodonCollection> create(
    MastodonCollectionCreateRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/collections',
      method: 'POST',
      data: request.toJson(),
    );
    return MastodonCollection.fromJson(
      data!['collection']! as Map<String, dynamic>,
    );
  }

  /// Updates a collection owned by the authenticated account.
  Future<MastodonCollection> update(
    String id,
    MastodonCollectionUpdateRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/collections/$id',
      method: 'PATCH',
      data: request.toJson(),
    );
    return MastodonCollection.fromJson(
      data!['collection']! as Map<String, dynamic>,
    );
  }

  /// Deletes a collection owned by the authenticated account.
  Future<void> delete(String id) =>
      _http.send<void>('/api/v1/collections/$id', method: 'DELETE');

  /// Adds [accountId] to a collection.
  Future<MastodonCollectionItem> addAccount(
    String collectionId,
    String accountId,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/collections/$collectionId/items',
      method: 'POST',
      data: {'account_id': accountId},
    );
    return MastodonCollectionItem.fromJson(
      data!['collection_item']! as Map<String, dynamic>,
    );
  }

  /// Removes an item from a collection owned by the authenticated account.
  Future<void> removeItem(String collectionId, String itemId) =>
      _http.send<void>(
        '/api/v1/collections/$collectionId/items/$itemId',
        method: 'DELETE',
      );

  /// Revokes the authenticated account's inclusion in a collection.
  Future<void> revokeItem(String collectionId, String itemId) =>
      _http.send<void>(
        '/api/v1/collections/$collectionId/items/$itemId/revoke',
        method: 'POST',
      );
}
