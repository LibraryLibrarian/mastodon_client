import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_poll.dart';

/// アンケートに関するAPIクライアント
class PollsApi {
  const PollsApi(this._http);

  final MastodonHttpClient _http;

  /// アンケートに投票
  ///
  /// `choices` には0始まりの選択肢インデックスを指定
  ///
  /// `POST /api/v1/polls/{pollId}/votes` に送信
  ///
  /// すでに投票済みの場合は[MastodonAlreadyVotedException]をthrow
  Future<MastodonPoll> vote(String pollId, List<int> choices) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/polls/$pollId/votes',
        data: <String, dynamic>{'choices': choices},
      );
      return MastodonPoll.fromJson(response.data!);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 422) {
        final serverMessage = e.response?.data is Map<String, dynamic>
            ? (e.response!.data as Map<String, dynamic>)['error'] as String?
            : null;
        final normalized = serverMessage?.toLowerCase() ?? '';
        if (normalized.contains('already voted') ||
            normalized.contains('already_voted')) {
          throw const MastodonAlreadyVotedException();
        }
      }
      throw convertDioException(e);
    }
  }
}
