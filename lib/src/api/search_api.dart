import '../client/mastodon_http_client.dart';
import '../models/mastodon_search_result.dart';

/// 検索に関する API クライアント
class SearchApi {
  /// [MastodonHttpClient] を受け取り、検索 API へのアクセスを提供する
  const SearchApi(this._http);

  final MastodonHttpClient _http;

  /// アカウント・投稿・ハッシュタグを横断検索する（v2）
  ///
  /// `GET /api/v2/search`
  ///
  /// - [query]: 検索クエリ文字列（必須）
  /// - [type]: 結果を特定の種別に限定する。
  ///   `accounts`・`hashtags`・`statuses` のいずれか。
  ///   省略時は全種別を検索する
  /// - [resolve]: `true` の場合、リモートアカウントの WebFinger ルックアップ
  ///   や URL の解決を行う。**ユーザートークンが必要**（デフォルト: `false`）
  /// - [following]: `true` の場合、認証ユーザーがフォロー中の
  ///   アカウントのみを返す（デフォルト: `false`）
  /// - [accountId]: 指定した場合、そのアカウントが投稿した
  ///   ステータスのみを返す
  /// - [excludeUnreviewed]: `true` の場合、未レビューのタグを除外する。
  ///   トレンドタグの検索時に使用する（Mastodon 3.0.0 で追加）
  /// - [maxId]: この ID より小さい結果のみを返す（ページネーション）
  /// - [minId]: この ID より大きい結果のみを返す（前方ページネーション）
  /// - [limit]: カテゴリごとの最大結果数。最大 40（デフォルト: 20）
  /// - [offset]: 先頭から指定件数をスキップする。
  ///   [type] が指定されている場合のみ有効。**ユーザートークンが必要**
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonSearchResult> search(
    String query, {
    String? type,
    bool? resolve,
    bool? following,
    String? accountId,
    bool? excludeUnreviewed,
    String? maxId,
    String? minId,
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/search',
      queryParameters: <String, dynamic>{
        'q': query,
        'type': ?type,
        'resolve': ?resolve,
        'following': ?following,
        'account_id': ?accountId,
        'exclude_unreviewed': ?excludeUnreviewed,
        'max_id': ?maxId,
        'min_id': ?minId,
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return MastodonSearchResult.fromJson(data!);
  }

  /// アカウント・投稿・ハッシュタグを横断検索する（v1・非推奨）
  ///
  /// `GET /api/v1/search`
  ///
  /// **Mastodon 2.4.1 で非推奨、3.0.0 で削除済み。**
  /// 2.x 系以前のインスタンスとの互換性のために提供している。
  /// 新規利用の場合は [search] (v2) を使用すること。
  ///
  /// v2 との主な違いとして、レスポンスの `hashtags` は Tag オブジェクトではなく
  /// 単純な文字列の配列として返される。また `following` および
  /// `exclude_unreviewed` パラメータは利用できない。
  ///
  /// - [query]: 検索クエリ文字列（必須）
  /// - [type]: 結果を特定の種別に限定する。
  ///   `accounts`・`hashtags`・`statuses` のいずれか。
  ///   省略時は全種別を検索する
  /// - [resolve]: `true` の場合、リモートアカウントの WebFinger ルックアップ
  ///   を行う（デフォルト: `false`）
  /// - [accountId]: 指定した場合、そのアカウントが投稿した
  ///   ステータスのみを返す
  /// - [maxId]: この ID より小さい結果のみを返す（ページネーション）
  /// - [minId]: この ID より大きい結果のみを返す（前方ページネーション）
  /// - [limit]: カテゴリごとの最大結果数。最大 40（デフォルト: 20）
  /// - [offset]: 先頭から指定件数をスキップする。
  ///   [type] が指定されている場合のみ有効
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  @Deprecated(
    'Mastodon 3.0.0 で削除済み。代わりに search() (v2) を使用してください',
  )
  Future<MastodonSearchResultV1> searchV1(
    String query, {
    String? type,
    bool? resolve,
    String? accountId,
    String? maxId,
    String? minId,
    int? limit,
    int? offset,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/search',
      queryParameters: <String, dynamic>{
        'q': query,
        'type': ?type,
        'resolve': ?resolve,
        'account_id': ?accountId,
        'max_id': ?maxId,
        'min_id': ?minId,
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return MastodonSearchResultV1.fromJson(data!);
  }
}
