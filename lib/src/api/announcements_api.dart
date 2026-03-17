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
  /// - [withDismissed]: 現在のサーバー実装ではこのパラメータは処理されない。
  ///   送信しても無視されるため、将来のバージョンで削除予定。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonAnnouncement>> fetch({
    @Deprecated('サーバー側で未実装のため効果なし。将来削除予定') bool? withDismissed,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/announcements',
      queryParameters: <String, dynamic>{
        'with_dismissed': ?withDismissed,
      },
    );
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
    final encodedName = Uri.encodeComponent(name);
    await _http.send<dynamic>(
      '/api/v1/announcements/$id/reactions/$encodedName',
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
    final encodedName = Uri.encodeComponent(name);
    await _http.send<dynamic>(
      '/api/v1/announcements/$id/reactions/$encodedName',
      method: 'DELETE',
    );
  }
}
