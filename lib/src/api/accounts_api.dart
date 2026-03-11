import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_account_create_request.dart';
import '../models/mastodon_account_page.dart';
import '../models/mastodon_credential_account_update_request.dart';
import '../models/mastodon_familiar_followers.dart';
import '../models/mastodon_featured_tag.dart';
import '../models/mastodon_list.dart';
import '../models/mastodon_relationship.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_token.dart';

/// アカウント情報の取得・操作を行う API クライアント
class AccountsApi {
  /// [MastodonHttpClient] を受け取り、アカウント API へのアクセスを提供する
  const AccountsApi(this._http);

  final MastodonHttpClient _http;

  /// ID を指定してアカウント情報を取得する
  ///
  /// `GET /api/v1/accounts/{accountId}`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccount> fetchById(String accountId) async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/accounts/$accountId',
      );
      return MastodonAccount.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 認証済みユーザー自身のアカウント情報を取得する
  ///
  /// `GET /api/v1/accounts/verify_credentials`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccount> verifyCredentials() async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/accounts/verify_credentials',
      );
      return MastodonAccount.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// `acct` 文字列からアカウントを検索して取得する
  ///
  /// `GET /api/v1/accounts/lookup?acct={acct}`
  ///
  /// 404・405・410・501 が返された場合は [search] にフォールバックし、
  /// `acct` フィールドが一致（大文字小文字を無視）する最初の結果を返す。
  /// フォールバック後も一致するアカウントが見つからない場合は
  /// [MastodonNotFoundException] を throw する。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccount> lookup(String acct) async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/accounts/lookup',
        queryParameters: <String, dynamic>{'acct': acct},
      );
      return MastodonAccount.fromJson(response.data!);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 404 ||
          statusCode == 405 ||
          statusCode == 410 ||
          statusCode == 501) {
        return _lookupViaSearch(acct);
      }
      throw convertDioException(e);
    }
  }

  /// キーワードでアカウントを検索する
  ///
  /// `GET /api/v1/accounts/search?q={query}&resolve={resolve}&limit={limit}`
  ///
  /// - [query]: 検索クエリ文字列
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [resolve]: リモートアカウントを WebFinger で解決するかどうか
  ///   （デフォルト: `false`）
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonAccount>> search(
    String query, {
    int? limit,
    bool resolve = false,
  }) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/accounts/search',
        queryParameters: <String, dynamic>{
          'q': query,
          'resolve': resolve,
          'limit': ?limit,
        },
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonAccount.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントのフォロワー一覧を取得する
  ///
  /// `GET /api/v1/accounts/{accountId}/followers`
  ///
  /// - [accountId]: 対象アカウントの ID
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [maxId]: ページネーション用カーソル。直前のレスポンスの `nextMaxId` を渡す
  ///
  /// 非公開アカウント（HTTP 403）の場合は空の [MastodonAccountPage] を返す。
  /// それ以外の失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccountPage> fetchFollowers(
    String accountId, {
    int? limit,
    String? maxId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$accountId/followers',
    limit: limit,
    maxId: maxId,
  );

  /// 指定アカウントのフォロー中一覧を取得する
  ///
  /// `GET /api/v1/accounts/{accountId}/following`
  ///
  /// - [accountId]: 対象アカウントの ID
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [maxId]: ページネーション用カーソル。直前のレスポンスの `nextMaxId` を渡す
  ///
  /// 非公開アカウント（HTTP 403）の場合は空の [MastodonAccountPage] を返す。
  /// それ以外の失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccountPage> fetchFollowing(
    String accountId, {
    int? limit,
    String? maxId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$accountId/following',
    limit: limit,
    maxId: maxId,
  );

  /// 指定アカウントの投稿一覧を取得する
  ///
  /// `GET /api/v1/accounts/{accountId}/statuses`
  ///
  /// - [accountId]: 対象アカウントの ID
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [maxId]: ページネーション用カーソル。前回取得した末尾の投稿 ID を渡す
  /// - [excludeReplies]: `true` のとき返信投稿を除外する（デフォルト: `false`）
  /// - [excludeReblogs]: `true` のときブースト投稿を除外する（デフォルト: `false`）
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonStatus>> fetchStatuses(
    String accountId, {
    int? limit,
    String? maxId,
    bool excludeReplies = false,
    bool excludeReblogs = false,
  }) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/accounts/$accountId/statuses',
        queryParameters: <String, dynamic>{
          'limit': ?limit,
          'max_id': ?maxId,
          'exclude_replies': excludeReplies,
          'exclude_reblogs': excludeReblogs,
        },
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonStatus.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// ログイン中ユーザーのプロフィール情報を更新する
  ///
  /// `PATCH /api/v1/accounts/update_credentials`
  ///
  /// [request] に更新したいフィールドのみを指定する。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccount> updateCredentials(
    MastodonCredentialAccountUpdateRequest request,
  ) async {
    try {
      final response = await _http.dio.patch<Map<String, dynamic>>(
        '/api/v1/accounts/update_credentials',
        data: request.toJson(),
      );
      return MastodonAccount.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 新規アカウントを登録する
  ///
  /// `POST /api/v1/accounts`
  ///
  /// アプリトークンを用いてリクエストする必要がある。
  /// 成功時はユーザーに紐づく [MastodonToken] を返す。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonToken> create(MastodonAccountCreateRequest request) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts',
        data: request.toJson(),
      );
      return MastodonToken.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 複数の ID を指定してアカウント情報をまとめて取得する
  ///
  /// `GET /api/v1/accounts?id[]={id}`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonAccount>> fetchMultiple(List<String> ids) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/accounts',
        queryParameters: <String, dynamic>{'id[]': ids},
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonAccount.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントをフォローする
  ///
  /// `POST /api/v1/accounts/{id}/follow`
  ///
  /// - [id]: 対象アカウントの ID
  /// - [reblogs]: ブースト投稿をホームタイムラインに表示するかどうか
  /// - [notify]: 投稿時に通知を受け取るかどうか
  /// - [languages]: フォローする言語のリスト（ISO 639-1 形式）
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> follow(
    String id, {
    bool? reblogs,
    bool? notify,
    List<String>? languages,
  }) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/follow',
        data: <String, dynamic>{
          'reblogs': ?reblogs,
          'notify': ?notify,
          'languages[]': ?languages,
        },
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントのフォローを解除する
  ///
  /// `POST /api/v1/accounts/{id}/unfollow`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> unfollow(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/unfollow',
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントを自分のフォロワーから削除する
  ///
  /// `POST /api/v1/accounts/{id}/remove_from_followers`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> removeFromFollowers(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/remove_from_followers',
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントをブロックする
  ///
  /// `POST /api/v1/accounts/{id}/block`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> block(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/block',
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントのブロックを解除する
  ///
  /// `POST /api/v1/accounts/{id}/unblock`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> unblock(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/unblock',
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントをミュートする
  ///
  /// `POST /api/v1/accounts/{id}/mute`
  ///
  /// - [id]: 対象アカウントの ID
  /// - [notifications]: 通知もミュートするかどうか（デフォルト: `true`）
  /// - [duration]: ミュート期間（秒）。`0` または未指定で無期限
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> mute(
    String id, {
    bool? notifications,
    int? duration,
  }) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/mute',
        data: <String, dynamic>{
          'notifications': ?notifications,
          'duration': ?duration,
        },
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントのミュートを解除する
  ///
  /// `POST /api/v1/accounts/{id}/unmute`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> unmute(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/unmute',
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントをプロフィールで紹介（ピン）する
  ///
  /// `POST /api/v1/accounts/{id}/pin`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> pin(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/pin',
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントのプロフィール紹介（ピン）を解除する
  ///
  /// `POST /api/v1/accounts/{id}/unpin`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> unpin(String id) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/unpin',
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントにプライベートメモを設定する
  ///
  /// `POST /api/v1/accounts/{id}/note`
  ///
  /// - [id]: 対象アカウントの ID
  /// - [comment]: メモの内容。`null` または空文字でメモを削除する
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> setNote(
    String id, {
    String? comment,
  }) async {
    try {
      final response = await _http.dio.post<Map<String, dynamic>>(
        '/api/v1/accounts/$id/note',
        data: <String, dynamic>{
          'comment': ?comment,
        },
      );
      return MastodonRelationship.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 複数アカウントとのリレーションシップをまとめて取得する
  ///
  /// `GET /api/v1/accounts/relationships?id[]={id}`
  ///
  /// - [ids]: 対象アカウントの ID リスト
  /// - [withSuspended]: 凍結アカウントを含めるかどうか
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonRelationship>> fetchRelationships(
    List<String> ids, {
    bool? withSuspended,
  }) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/accounts/relationships',
        queryParameters: <String, dynamic>{
          'id[]': ids,
          'with_suspended': ?withSuspended,
        },
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonRelationship.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントをフォローしている共通フォロイーを取得する
  ///
  /// `GET /api/v1/accounts/familiar_followers?id[]={id}`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonFamiliarFollowers>> fetchFamiliarFollowers(
    List<String> ids,
  ) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/accounts/familiar_followers',
        queryParameters: <String, dynamic>{'id[]': ids},
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonFamiliarFollowers.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントの紹介タグ一覧を取得する
  ///
  /// `GET /api/v1/accounts/{id}/featured_tags`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonFeaturedTag>> fetchFeaturedTags(String id) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/accounts/$id/featured_tags',
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonFeaturedTag.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定アカウントが属するリスト一覧を取得する
  ///
  /// `GET /api/v1/accounts/{id}/lists`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonList>> fetchLists(String id) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/accounts/$id/lists',
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonList.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  Future<MastodonAccount> _lookupViaSearch(String acct) async {
    final results = await search(acct);
    final target = acct.toLowerCase();
    final match = results.where(
      (a) => a.acct.toLowerCase() == target,
    );
    if (match.isNotEmpty) {
      return match.first;
    }
    throw const MastodonNotFoundException(
      message: 'Account not found',
    );
  }

  Future<MastodonAccountPage> _fetchAccountPage(
    String path, {
    int? limit,
    String? maxId,
  }) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        path,
        queryParameters: <String, dynamic>{
          'limit': ?limit,
          'max_id': ?maxId,
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        return const MastodonAccountPage(accounts: []);
      }
      throw convertDioException(e);
    }
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
