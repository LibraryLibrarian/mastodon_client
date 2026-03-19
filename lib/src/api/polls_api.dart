import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../models/mastodon_poll.dart';

/// API client for polls.
class PollsApi {
  const PollsApi(this._http);

  final MastodonHttpClient _http;

  /// Fetches a poll by its ID.
  ///
  /// `GET /api/v1/polls/{id}`
  Future<MastodonPoll> fetch(String id) async {
    final data = await _http.send<Map<String, dynamic>>('/api/v1/polls/$id');
    return MastodonPoll.fromJson(data!);
  }

  /// Votes on a poll.
  ///
  /// [choices] contains zero-based option indices.
  ///
  /// `POST /api/v1/polls/{pollId}/votes`
  ///
  /// Throws [MastodonAlreadyVotedException] if already voted.
  Future<MastodonPoll> vote(String pollId, List<int> choices) async {
    try {
      final data = await _http.send<Map<String, dynamic>>(
        '/api/v1/polls/$pollId/votes',
        method: 'POST',
        data: <String, dynamic>{'choices': choices},
      );
      return MastodonPoll.fromJson(data!);
    } on MastodonValidationException catch (e) {
      final normalized = e.serverMessage?.toLowerCase() ?? '';
      if (normalized.contains('already voted') ||
          normalized.contains('already_voted')) {
        throw const MastodonAlreadyVotedException();
      }
      rethrow;
    }
  }
}
