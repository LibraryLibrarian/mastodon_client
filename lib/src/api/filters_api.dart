import '../client/mastodon_http_client.dart';
import '../models/mastodon_filter.dart';

/// フィルターに関する API クライアント
///
/// v2（サーバーサイドフィルタリング、Mastodon 4.0+）と
/// v1（クライアントサイドフィルタリング、非推奨）の両方を提供する。
class FiltersApi {
  /// [MastodonHttpClient] を受け取り、フィルター API へのアクセスを提供する
  const FiltersApi(this._http);

  final MastodonHttpClient _http;

  /// 全フィルターを取得する
  ///
  /// `GET /api/v2/filters`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonFilter>> fetch() async {
    final data = await _http.send<List<dynamic>>('/api/v2/filters');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFilter.fromJson)
        .toList();
  }

  /// 指定された ID のフィルターを取得する
  ///
  /// `GET /api/v2/filters/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonFilter> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/$id',
    );
    return MastodonFilter.fromJson(data!);
  }

  /// フィルターを新規作成する
  ///
  /// `POST /api/v2/filters`
  ///
  /// - [title]: フィルターグループの名前（必須）
  /// - [context]: 適用コンテキスト（必須）。
  ///   `home`, `notifications`, `public`, `thread`, `account` のうち1つ以上
  /// - [filterAction]: マッチ時のアクション（`warn` / `hide` / `blur`）
  /// - [expiresIn]: 有効期限（秒）。`null` で無期限
  /// - [keywordsAttributes]: 作成時に追加するキーワードのリスト
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonFilter> create({
    required String title,
    required List<String> context,
    String? filterAction,
    int? expiresIn,
    List<MastodonFilterKeywordParam>? keywordsAttributes,
  }) async {
    final body = <String, dynamic>{
      'title': title,
      'context': context,
      'filter_action': ?filterAction,
      'expires_in': ?expiresIn,
    };
    if (keywordsAttributes != null) {
      body['keywords_attributes'] = keywordsAttributes
          .map(
            (kw) => <String, dynamic>{
              'keyword': kw.keyword,
              if (kw.wholeWord != null) 'whole_word': kw.wholeWord,
            },
          )
          .toList();
    }
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters',
      method: 'POST',
      data: body,
    );
    return MastodonFilter.fromJson(data!);
  }

  /// フィルターを更新する
  ///
  /// `PUT /api/v2/filters/{id}`
  ///
  /// - [id]: 更新するフィルターの ID
  /// - [title]: フィルターグループの名前
  /// - [context]: 適用コンテキスト
  /// - [filterAction]: マッチ時のアクション
  /// - [expiresIn]: 有効期限（秒）
  /// - [keywordsAttributes]: 追加・更新・削除するキーワードのリスト
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonFilter> update(
    String id, {
    String? title,
    List<String>? context,
    String? filterAction,
    int? expiresIn,
    List<MastodonFilterKeywordUpdateParam>? keywordsAttributes,
  }) async {
    final body = <String, dynamic>{
      'title': ?title,
      'filter_action': ?filterAction,
      'expires_in': ?expiresIn,
    };
    if (context != null) {
      body['context'] = context;
    }
    if (keywordsAttributes != null) {
      body['keywords_attributes'] = keywordsAttributes
          .map(
            (kw) => <String, dynamic>{
              if (kw.id != null) 'id': kw.id,
              'keyword': kw.keyword,
              if (kw.wholeWord != null) 'whole_word': kw.wholeWord,
              if (kw.destroy != null) '_destroy': kw.destroy,
            },
          )
          .toList();
    }
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/$id',
      method: 'PUT',
      data: body,
    );
    return MastodonFilter.fromJson(data!);
  }

  /// フィルターを削除する
  ///
  /// `DELETE /api/v2/filters/{id}`
  ///
  /// - [id]: 削除するフィルターの ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v2/filters/$id',
      method: 'DELETE',
    );
  }

  /// フィルター内のキーワード一覧を取得する
  ///
  /// `GET /api/v2/filters/{filterId}/keywords`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonFilterKeyword>> fetchKeywords(String filterId) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v2/filters/$filterId/keywords',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFilterKeyword.fromJson)
        .toList();
  }

  /// フィルターにキーワードを追加する
  ///
  /// `POST /api/v2/filters/{filterId}/keywords`
  ///
  /// - [filterId]: 対象フィルターの ID
  /// - [keyword]: キーワード文字列（必須）
  /// - [wholeWord]: 単語境界を考慮するかどうか
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonFilterKeyword> createKeyword(
    String filterId, {
    required String keyword,
    bool? wholeWord,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/$filterId/keywords',
      method: 'POST',
      data: <String, dynamic>{
        'keyword': keyword,
        'whole_word': ?wholeWord,
      },
    );
    return MastodonFilterKeyword.fromJson(data!);
  }

  /// 特定のキーワードを取得する
  ///
  /// `GET /api/v2/filters/keywords/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonFilterKeyword> fetchKeywordById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/keywords/$id',
    );
    return MastodonFilterKeyword.fromJson(data!);
  }

  /// キーワードを更新する
  ///
  /// `PUT /api/v2/filters/keywords/{id}`
  ///
  /// - [id]: 更新する FilterKeyword の ID
  /// - [keyword]: キーワード文字列（必須）
  /// - [wholeWord]: 単語境界を考慮するかどうか
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonFilterKeyword> updateKeyword(
    String id, {
    required String keyword,
    bool? wholeWord,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/keywords/$id',
      method: 'PUT',
      data: <String, dynamic>{
        'keyword': keyword,
        'whole_word': ?wholeWord,
      },
    );
    return MastodonFilterKeyword.fromJson(data!);
  }

  /// キーワードを削除する
  ///
  /// `DELETE /api/v2/filters/keywords/{id}`
  ///
  /// - [id]: 削除する FilterKeyword の ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> deleteKeyword(String id) async {
    await _http.send<void>(
      '/api/v2/filters/keywords/$id',
      method: 'DELETE',
    );
  }

  /// フィルター内のステータスフィルター一覧を取得する
  ///
  /// `GET /api/v2/filters/{filterId}/statuses`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonFilterStatus>> fetchStatuses(String filterId) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v2/filters/$filterId/statuses',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFilterStatus.fromJson)
        .toList();
  }

  /// フィルターにステータスフィルターを追加する
  ///
  /// `POST /api/v2/filters/{filterId}/statuses`
  ///
  /// - [filterId]: 対象フィルターの ID
  /// - [statusId]: フィルター対象のステータス ID（必須）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonFilterStatus> createStatus(
    String filterId, {
    required String statusId,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/$filterId/statuses',
      method: 'POST',
      data: <String, dynamic>{'status_id': statusId},
    );
    return MastodonFilterStatus.fromJson(data!);
  }

  /// 特定のステータスフィルターを取得する
  ///
  /// `GET /api/v2/filters/statuses/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonFilterStatus> fetchStatusById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v2/filters/statuses/$id',
    );
    return MastodonFilterStatus.fromJson(data!);
  }

  /// ステータスフィルターを削除する
  ///
  /// `DELETE /api/v2/filters/statuses/{id}`
  ///
  /// - [id]: 削除する FilterStatus の ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> deleteStatus(String id) async {
    await _http.send<void>(
      '/api/v2/filters/statuses/$id',
      method: 'DELETE',
    );
  }

  /// 全フィルターを取得する（v1・非推奨）
  ///
  /// `GET /api/v1/filters`
  ///
  /// Mastodon 4.0 以降は [fetch]（v2）の使用を推奨。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  @Deprecated('Mastodon 4.0.0 で非推奨。代わりに fetch() (v2) を使用してください')
  Future<List<MastodonFilterV1>> fetchV1() async {
    final data = await _http.send<List<dynamic>>('/api/v1/filters');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFilterV1.fromJson)
        .toList();
  }

  /// 指定された ID のフィルターを取得する（v1・非推奨）
  ///
  /// `GET /api/v1/filters/{id}`
  ///
  /// - [id]: FilterKeyword の ID
  ///
  /// Mastodon 4.0 以降は [fetchById]（v2）の使用を推奨。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  @Deprecated('Mastodon 4.0.0 で非推奨。代わりに fetchById() (v2) を使用してください')
  Future<MastodonFilterV1> fetchByIdV1(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/filters/$id',
    );
    return MastodonFilterV1.fromJson(data!);
  }

  /// フィルターを新規作成する（v1・非推奨）
  ///
  /// `POST /api/v1/filters`
  ///
  /// - [phrase]: フィルター対象のテキスト（必須）
  /// - [context]: 適用コンテキスト（必須）。
  ///   `home`, `notifications`, `public`, `thread`, `account` のうち1つ以上
  /// - [irreversible]: ホーム・通知で不可逆的に除外するか（デフォルト: `false`）
  /// - [wholeWord]: 単語境界を考慮するか（デフォルト: `false`）
  /// - [expiresIn]: 有効期限（秒）。`null` で無期限
  ///
  /// Mastodon 4.0 以降は [create]（v2）の使用を推奨。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  @Deprecated('Mastodon 4.0.0 で非推奨。代わりに create() (v2) を使用してください')
  Future<MastodonFilterV1> createV1({
    required String phrase,
    required List<String> context,
    bool? irreversible,
    bool? wholeWord,
    int? expiresIn,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/filters',
      method: 'POST',
      data: <String, dynamic>{
        'phrase': phrase,
        'context': context,
        'irreversible': ?irreversible,
        'whole_word': ?wholeWord,
        'expires_in': ?expiresIn,
      },
    );
    return MastodonFilterV1.fromJson(data!);
  }

  /// フィルターを更新する（v1・非推奨）
  ///
  /// `PUT /api/v1/filters/{id}`
  ///
  /// 複数キーワードを持つフィルターの `expires_in`, `irreversible`, `context`
  /// を変更しようとするとエラーが返る。
  ///
  /// - [id]: 更新する FilterKeyword の ID
  /// - [phrase]: フィルター対象のテキスト（必須）
  /// - [context]: 適用コンテキスト（必須）
  /// - [irreversible]: ホーム・通知で不可逆的に除外するか（デフォルト: `false`）
  /// - [wholeWord]: 単語境界を考慮するか（デフォルト: `false`）
  /// - [expiresIn]: 有効期限（秒）
  ///
  /// Mastodon 4.0 以降は [update]（v2）の使用を推奨。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  @Deprecated('Mastodon 4.0.0 で非推奨。代わりに update() (v2) を使用してください')
  Future<MastodonFilterV1> updateV1(
    String id, {
    required String phrase,
    required List<String> context,
    bool? irreversible,
    bool? wholeWord,
    int? expiresIn,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/filters/$id',
      method: 'PUT',
      data: <String, dynamic>{
        'phrase': phrase,
        'context': context,
        'irreversible': ?irreversible,
        'whole_word': ?wholeWord,
        'expires_in': ?expiresIn,
      },
    );
    return MastodonFilterV1.fromJson(data!);
  }

  /// フィルターを削除する（v1・非推奨）
  ///
  /// `DELETE /api/v1/filters/{id}`
  ///
  /// FilterKeyword のみを削除する。親 Filter 自体の削除には v2 の [delete] が必要。
  ///
  /// - [id]: 削除する Filter の ID
  ///
  /// Mastodon 4.0 以降は [delete]（v2）の使用を推奨。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  @Deprecated('Mastodon 4.0.0 で非推奨。代わりに delete() (v2) を使用してください')
  Future<void> deleteV1(String id) async {
    await _http.send<void>(
      '/api/v1/filters/$id',
      method: 'DELETE',
    );
  }
}

/// フィルター作成時のキーワードパラメーター
class MastodonFilterKeywordParam {
  /// [keyword] にキーワード文字列、[wholeWord] に単語境界考慮フラグを指定する
  const MastodonFilterKeywordParam({
    required this.keyword,
    this.wholeWord,
  });

  /// キーワード文字列
  final String keyword;

  /// 単語境界を考慮するかどうか
  final bool? wholeWord;
}

/// フィルター更新時のキーワードパラメーター
class MastodonFilterKeywordUpdateParam {
  /// 既存キーワードの更新には [id] を指定し、削除には [destroy] を `true` にする
  const MastodonFilterKeywordUpdateParam({
    required this.keyword,
    this.id,
    this.wholeWord,
    this.destroy,
  });

  /// 既存キーワードの ID（更新時に指定）
  final String? id;

  /// キーワード文字列
  final String keyword;

  /// 単語境界を考慮するかどうか
  final bool? wholeWord;

  /// `true` に設定するとこのキーワードを削除する
  final bool? destroy;
}
