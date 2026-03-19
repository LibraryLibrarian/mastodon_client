import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_conversation.dart';
import '../models/mastodon_page.dart';

/// API for direct message conversations.
class ConversationsApi {
  /// Creates a [ConversationsApi] instance with the given [MastodonHttpClient].
  const ConversationsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches a list of conversations.
  ///
  /// `GET /api/v1/conversations`
  ///
  /// [limit] controls the maximum number of results (default: 20, max: 40).
  /// Use [maxId] to return conversations older than that ID, [sinceId] for
  /// conversations after that ID, and [minId] for immediate forward
  /// pagination.
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonPage<MastodonConversation>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/conversations',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonConversation.fromJson)
        .toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// Deletes a conversation.
  ///
  /// `DELETE /api/v1/conversations/{id}`
  ///
  /// Throws a `MastodonException` on failure.
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v1/conversations/$id',
      method: 'DELETE',
    );
  }

  /// Marks a conversation as read.
  ///
  /// `POST /api/v1/conversations/{id}/read`
  ///
  /// Throws a `MastodonException` on failure.
  Future<MastodonConversation> markAsRead(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/conversations/$id/read',
      method: 'POST',
    );
    return MastodonConversation.fromJson(data!);
  }
}
