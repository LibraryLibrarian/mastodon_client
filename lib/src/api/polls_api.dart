import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../models/mastodon_poll.dart';

/// アンケートに関するAPIクライアント
class PollsApi {
  const PollsApi(this._http);

  final MastodonHttpClient _http;

  /// 指定されたIDのアンケートを取得
  ///
  /// `GET /api/v1/polls/{id}`
  Future<MastodonPoll> fetch(String id) async {
    final data = await _http.send<Map<String, dynamic>>('/api/v1/polls/$id');
    return MastodonPoll.fromJson(data!);
  }

  /// アンケートに投票
  ///
  /// `choices` には0始まりの選択肢インデックスを指定
  ///
  /// `POST /api/v1/polls/{pollId}/votes` に送信
  ///
  /// すでに投票済みの場合は[MastodonAlreadyVotedException]をthrow
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
