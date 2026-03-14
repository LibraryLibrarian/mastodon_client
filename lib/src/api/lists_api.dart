import '../client/mastodon_http_client.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_account_page.dart';
import '../models/mastodon_list.dart';

/// リストの作成・管理に関する API クライアント
class ListsApi {
  /// [MastodonHttpClient] を受け取り、リスト API へのアクセスを提供する
  const ListsApi(this._http);

  final MastodonHttpClient _http;

  /// ユーザーが所有する全リストを取得する
  ///
  /// `GET /api/v1/lists`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonList>> fetch() async {
    final data = await _http.send<List<dynamic>>('/api/v1/lists');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonList.fromJson)
        .toList();
  }

  /// 指定された ID のリストを取得する
  ///
  /// `GET /api/v1/lists/{id}`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonList> fetchById(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/lists/$id',
    );
    return MastodonList.fromJson(data!);
  }

  /// 新しいリストを作成する
  ///
  /// `POST /api/v1/lists`
  ///
  /// - [title]: リストのタイトル（必須）
  /// - [repliesPolicy]: リプライ表示ポリシー。
  ///   `followed`（フォロー中へのリプライ）・`list`（リストメンバーへのリプライ）・
  ///   `none`（リプライなし）のいずれか。省略時はサーバーのデフォルト値
  /// - [exclusive]: リストメンバーの投稿をホームタイムラインから除外するかどうか
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonList> create({
    required String title,
    String? repliesPolicy,
    bool? exclusive,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/lists',
      method: 'POST',
      data: <String, dynamic>{
        'title': title,
        'replies_policy': ?repliesPolicy,
        'exclusive': ?exclusive,
      },
    );
    return MastodonList.fromJson(data!);
  }

  /// リストのプロパティを更新する
  ///
  /// `PUT /api/v1/lists/{id}`
  ///
  /// - [id]: 更新するリストの ID
  /// - [title]: リストのタイトル（必須）
  /// - [repliesPolicy]: リプライ表示ポリシー。
  ///   `followed`・`list`・`none` のいずれか
  /// - [exclusive]: リストメンバーの投稿をホームタイムラインから除外するかどうか
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonList> update(
    String id, {
    required String title,
    String? repliesPolicy,
    bool? exclusive,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/lists/$id',
      method: 'PUT',
      data: <String, dynamic>{
        'title': title,
        'replies_policy': ?repliesPolicy,
        'exclusive': ?exclusive,
      },
    );
    return MastodonList.fromJson(data!);
  }

  /// リストを削除する
  ///
  /// `DELETE /api/v1/lists/{id}`
  ///
  /// - [id]: 削除するリストの ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v1/lists/$id',
      method: 'DELETE',
    );
  }

  /// リストに所属するアカウントの一覧を取得する
  ///
  /// `GET /api/v1/lists/{id}/accounts`
  ///
  /// - [id]: 対象リストの ID
  /// - [limit]: 最大取得件数（デフォルト: 40、最大: 80、0 で全件取得）
  /// - [maxId]: ページネーション用カーソル。このID以前の結果を返す
  /// - [sinceId]: ページネーション用カーソル。このID以降の結果を返す
  /// - [minId]: ページネーション用カーソル。このIDより新しい結果を返す
  ///
  /// レスポンスの `Link` ヘッダーから次ページの `max_id` を解析し、
  /// [MastodonAccountPage.nextMaxId] に格納する。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAccountPage> fetchAccounts(
    String id, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/lists/$id/accounts',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    final accounts = (response.data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
    final nextMaxId = _parseNextMaxId(
      response.headers.map['link']?.join(','),
    );
    return MastodonAccountPage(accounts: accounts, nextMaxId: nextMaxId);
  }

  /// リストにアカウントを追加する
  ///
  /// `POST /api/v1/lists/{id}/accounts`
  ///
  /// 追加するアカウントはユーザーがフォローしている必要がある。
  ///
  /// - [id]: 対象リストの ID
  /// - [accountIds]: 追加するアカウントの ID リスト
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> addAccounts(
    String id, {
    required List<String> accountIds,
  }) async {
    await _http.send<void>(
      '/api/v1/lists/$id/accounts',
      method: 'POST',
      data: <String, dynamic>{'account_ids[]': accountIds},
    );
  }

  /// リストからアカウントを削除する
  ///
  /// `DELETE /api/v1/lists/{id}/accounts`
  ///
  /// - [id]: 対象リストの ID
  /// - [accountIds]: 削除するアカウントの ID リスト
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> removeAccounts(
    String id, {
    required List<String> accountIds,
  }) async {
    await _http.send<void>(
      '/api/v1/lists/$id/accounts',
      method: 'DELETE',
      data: <String, dynamic>{'account_ids[]': accountIds},
    );
  }

  /// `Link` レスポンスヘッダーから `rel="next"` の `max_id` クエリパラメーターを
  /// 取り出す
  ///
  /// 次ページが存在しない場合、または解析できない場合は `null` を返す。
  String? _parseNextMaxId(String? linkHeader) {
    if (linkHeader == null) return null;
    for (final segment in linkHeader.split(',')) {
      final trimmed = segment.trim();
      if (!trimmed.contains('rel="next"')) continue;
      final start = trimmed.indexOf('<');
      final end = trimmed.indexOf('>');
      if (start == -1 || end == -1 || end <= start + 1) continue;
      final url = trimmed.substring(start + 1, end);
      final maxId = Uri.tryParse(url)?.queryParameters['max_id'];
      if (maxId != null && maxId.isNotEmpty) return maxId;
    }
    return null;
  }
}
