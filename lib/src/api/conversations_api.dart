import '../client/mastodon_http_client.dart';
import '../models/mastodon_conversation.dart';

/// ダイレクトメッセージの会話に関するAPI
class ConversationsApi {
  /// [MastodonHttpClient] を受け取り、会話 API へのアクセスを提供する
  const ConversationsApi(this._http);

  final MastodonHttpClient _http;

  /// 会話一覧を取得する
  ///
  /// `GET /api/v1/conversations`
  ///
  /// - [limit]: 最大取得件数（デフォルト: 20、上限: 40）
  /// - [maxId]: このIDより古い会話を取得する（ページネーション用カーソル）
  /// - [sinceId]: このID以降の会話を取得する
  /// - [minId]: このID直後の会話を取得する
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonConversation>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/conversations',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonConversation.fromJson)
        .toList();
  }

  /// 会話を削除する
  ///
  /// `DELETE /api/v1/conversations/{id}`
  ///
  /// - [id]: 削除する会話の ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v1/conversations/$id',
      method: 'DELETE',
    );
  }

  /// 会話を既読にする
  ///
  /// `POST /api/v1/conversations/{id}/read`
  ///
  /// - [id]: 既読にする会話の ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonConversation> markAsRead(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/conversations/$id/read',
      method: 'POST',
    );
    return MastodonConversation.fromJson(data!);
  }
}
