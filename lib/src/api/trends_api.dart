import '../client/mastodon_http_client.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_trends_link.dart';

/// トレンドに関する API クライアント
///
/// 全エンドポイントが認証不要の公開 API。
class TrendsApi {
  /// [MastodonHttpClient] を受け取り、トレンド API へのアクセスを提供する
  const TrendsApi(this._http);

  final MastodonHttpClient _http;

  /// トレンドタグを取得する
  ///
  /// `GET /api/v1/trends/tags`
  ///
  /// 過去1週間で使用頻度が増加しているタグを内部トレンドスコア順に返す。
  ///
  /// - [limit]: 最大取得件数（デフォルト: 10、上限: 20）
  /// - [offset]: スキップ件数（ページネーション用）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonTag>> fetchTags({
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/trends/tags',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonTag.fromJson)
        .toList();
  }

  /// トレンド投稿を取得する
  ///
  /// `GET /api/v1/trends/statuses`
  ///
  /// 他の投稿よりも多くのインタラクションを受けている投稿を返す。
  ///
  /// - [limit]: 最大取得件数（デフォルト: 20、上限: 40）
  /// - [offset]: スキップ件数（ページネーション用）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonStatus>> fetchStatuses({
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/trends/statuses',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
  }

  /// トレンドリンクを取得する
  ///
  /// `GET /api/v1/trends/links`
  ///
  /// ネットワーク全体で高頻度に共有されているリンクを返す。
  ///
  /// - [limit]: 最大取得件数（デフォルト: 10、上限: 20）
  /// - [offset]: スキップ件数（ページネーション用）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonTrendsLink>> fetchLinks({
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/trends/links',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonTrendsLink.fromJson)
        .toList();
  }
}
