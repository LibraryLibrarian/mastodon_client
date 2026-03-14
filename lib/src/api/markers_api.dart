import '../client/mastodon_http_client.dart';
import '../models/mastodon_marker.dart';

/// タイムラインの既読位置マーカーに関するAPI
class MarkersApi {
  /// [MastodonHttpClient] を受け取り、マーカーAPIへのアクセスを提供する
  const MarkersApi(this._http);

  final MastodonHttpClient _http;

  /// 保存済みのタイムライン既読位置を取得する
  ///
  /// `GET /api/v1/markers`
  ///
  /// - [timelines]: マーカーを取得するタイムラインのリスト。
  ///   指定可能な値: `home`、`notifications`。
  ///   未指定の場合は空のマップが返る。
  ///
  /// 返り値はタイムライン名をキー、[MastodonMarker] を値とするマップ。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<Map<String, MastodonMarker>> fetch(List<String> timelines) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/markers',
      queryParameters: <String, dynamic>{'timeline[]': timelines},
    );
    if (data == null) return const {};
    return data.map(
      (key, value) => MapEntry(
        key,
        MastodonMarker.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  /// タイムラインの既読位置を保存する
  ///
  /// `POST /api/v1/markers`
  ///
  /// - [homeLastReadId]: ホームタイムラインで最後に既読にしたステータスの ID
  /// - [notificationsLastReadId]: 最後に既読にした通知の ID
  ///
  /// いずれか1つ以上を指定する。
  ///
  /// 返り値は更新されたマーカーを含むマップ。
  ///
  /// `409 Conflict` が返る場合は書き込み競合が発生しているため再試行が必要。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<Map<String, MastodonMarker>> save({
    String? homeLastReadId,
    String? notificationsLastReadId,
  }) async {
    final body = <String, dynamic>{
      'home[last_read_id]': ?homeLastReadId,
      'notifications[last_read_id]': ?notificationsLastReadId,
    };
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/markers',
      method: 'POST',
      data: body,
    );
    if (data == null) return const {};
    return data.map(
      (key, value) => MapEntry(
        key,
        MastodonMarker.fromJson(value as Map<String, dynamic>),
      ),
    );
  }
}
