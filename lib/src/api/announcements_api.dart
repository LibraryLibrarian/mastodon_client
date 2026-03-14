import '../client/mastodon_http_client.dart';
import '../models/mastodon_announcement.dart';

/// サーバーのお知らせに関する API
class AnnouncementsApi {
  const AnnouncementsApi(this._http);
  final MastodonHttpClient _http;

  /// アクティブなお知らせ一覧を取得する
  ///
  /// `GET /api/v1/announcements`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAnnouncement>> fetch() async {
    final data = await _http.send<List<dynamic>>('/api/v1/announcements');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAnnouncement.fromJson)
        .toList();
  }

  /// お知らせを既読にする
  ///
  /// `POST /api/v1/announcements/:id/dismiss`
  ///
  /// - [id]: お知らせのID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> dismiss(String id) async {
    await _http.send<dynamic>(
      '/api/v1/announcements/$id/dismiss',
      method: 'POST',
    );
  }

  /// お知らせにリアクションを追加する
  ///
  /// `PUT /api/v1/announcements/:id/reactions/:name`
  ///
  /// - [id]: お知らせのID
  /// - [name]: Unicode 絵文字またはカスタム絵文字のショートコード
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> addReaction(String id, String name) async {
    await _http.send<dynamic>(
      '/api/v1/announcements/$id/reactions/$name',
      method: 'PUT',
    );
  }

  /// お知らせからリアクションを削除する
  ///
  /// `DELETE /api/v1/announcements/:id/reactions/:name`
  ///
  /// - [id]: お知らせのID
  /// - [name]: Unicode 絵文字またはカスタム絵文字のショートコード
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> removeReaction(String id, String name) async {
    await _http.send<dynamic>(
      '/api/v1/announcements/$id/reactions/$name',
      method: 'DELETE',
    );
  }
}
