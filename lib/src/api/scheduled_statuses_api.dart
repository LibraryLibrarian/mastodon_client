import '../client/mastodon_http_client.dart';
import '../models/mastodon_scheduled_status.dart';

/// 予約投稿の管理に関するAPI
class ScheduledStatusesApi {
  /// [MastodonHttpClient] を受け取り、予約投稿APIへのアクセスを提供する
  const ScheduledStatusesApi(this._http);

  final MastodonHttpClient _http;

  /// 認証済みユーザーの予約投稿一覧を取得する
  ///
  /// `GET /api/v1/scheduled_statuses`
  ///
  /// - [limit]: 最大取得件数（デフォルト: 20、上限: 40）
  /// - [maxId]: このIDより古い結果を返す（ページネーション用カーソル）
  /// - [sinceId]: このIDより新しい結果を返す
  /// - [minId]: このIDより新しい結果を返す（逆順）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonScheduledStatus>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/scheduled_statuses',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonScheduledStatus.fromJson)
        .toList();
  }

  /// 指定IDの予約投稿を取得する
  ///
  /// `GET /api/v1/scheduled_statuses/:id`
  ///
  /// - [id]: 予約投稿のデータベース ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonScheduledStatus> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/scheduled_statuses/$id',
    );
    return MastodonScheduledStatus.fromJson(data!);
  }

  /// 予約投稿の公開予定日時を変更する
  ///
  /// `PUT /api/v1/scheduled_statuses/:id`
  ///
  /// - [id]: 予約投稿のデータベース ID
  /// - [scheduledAt]: 新しい公開予定日時（ISO 8601 形式）。
  ///   現在時刻から少なくとも5分以上先でなければならない。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonScheduledStatus> update(
    String id, {
    required String scheduledAt,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/scheduled_statuses/$id',
      method: 'PUT',
      data: <String, dynamic>{'scheduled_at': scheduledAt},
    );
    return MastodonScheduledStatus.fromJson(data!);
  }

  /// 予約投稿をキャンセル（削除）する
  ///
  /// `DELETE /api/v1/scheduled_statuses/:id`
  ///
  /// - [id]: 削除する予約投稿のデータベース ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v1/scheduled_statuses/$id',
      method: 'DELETE',
    );
  }
}
