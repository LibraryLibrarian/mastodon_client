import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_account_page.dart';
import '../models/mastodon_status.dart';

/// アカウント情報を取得するAPIクライアント
class AccountsApi {
  /// [MastodonHttpClient]を受け取り、アカウントAPIへのアクセスを提供
  const AccountsApi(this._http);

  final MastodonHttpClient _http;

  /// IDを指定してアカウント情報を取得
  ///
  /// `GET /api/v1/accounts/{accountId}`
  ///
  /// 失敗時は[MastodonException]のサブクラスをthrow
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

  /// 認証済みユーザー自身のアカウント情報を取得
  ///
  /// `GET /api/v1/accounts/verify_credentials`
  ///
  /// 失敗時は[MastodonException]のサブクラスをthrow
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

  /// `acct` 文字列からアカウントを検索して取得
  ///
  /// `GET /api/v1/accounts/lookup?acct={acct}`
  ///
  /// 404・405・410・501 が返された場合は [search] にフォールバックし、
  /// `acct` フィールドが一致（大文字小文字を無視）する最初の結果を返す。
  /// フォールバック後も一致するアカウントが見つからない場合は
  /// [MastodonNotFoundException]をthrow。
  ///
  /// 失敗時は[MastodonException]のサブクラスをthrow
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

  /// キーワードでアカウントを検索
  ///
  /// `GET /api/v1/accounts/search?q={query}&resolve={resolve}&limit={limit}`
  ///
  /// - [query]: 検索クエリ文字列
  /// - [limit]: 最大取得件数（デフォルト: 5）
  /// - [resolve]: リモートアカウントをWebFingerで解決するかどうか（デフォルト: `true`）
  ///
  /// 失敗時は[MastodonException]のサブクラスをthrow
  Future<List<MastodonAccount>> search(
    String query, {
    int limit = 5,
    bool resolve = true,
  }) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/accounts/search',
        queryParameters: <String, dynamic>{
          'q': query,
          'resolve': resolve,
          'limit': limit,
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

  /// 指定アカウントのフォロワー一覧を取得
  ///
  /// `GET /api/v1/accounts/{accountId}/followers`
  ///
  /// - [accountId]: 対象アカウントの ID
  /// - [limit]: 最大取得件数（デフォルト: 40）
  /// - [maxId]: ページネーション用カーソル。直前のレスポンスの `nextMaxId` を渡す
  ///
  /// 非公開アカウント（HTTP 403）の場合は空の [MastodonAccountPage] を返す。
  /// それ以外の失敗時は [MastodonException] のサブクラスをthrow。
  Future<MastodonAccountPage> fetchFollowers(
    String accountId, {
    int limit = 40,
    String? maxId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$accountId/followers',
    limit: limit,
    maxId: maxId,
  );

  /// 指定アカウントのフォロー中一覧を取得
  ///
  /// `GET /api/v1/accounts/{accountId}/following`
  ///
  /// - [accountId]: 対象アカウントの ID
  /// - [limit]: 最大取得件数（デフォルト: 40）
  /// - [maxId]: ページネーション用カーソル。直前のレスポンスの `nextMaxId` を渡す
  ///
  /// 非公開アカウント（HTTP 403）の場合は空の [MastodonAccountPage] を返す。
  /// それ以外の失敗時は [MastodonException] のサブクラスをthrow。
  Future<MastodonAccountPage> fetchFollowing(
    String accountId, {
    int limit = 40,
    String? maxId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$accountId/following',
    limit: limit,
    maxId: maxId,
  );

  /// 指定アカウントの投稿一覧を取得
  ///
  /// `GET /api/v1/accounts/{accountId}/statuses`
  ///
  /// - [accountId]: 対象アカウントの ID
  /// - [limit]: 最大取得件数（デフォルト: 30）
  /// - [maxId]: ページネーション用カーソル。前回取得した末尾の投稿 ID を渡す
  /// - [excludeReplies]: `true` のとき返信投稿を除外する（デフォルト: `false`）
  /// - [excludeReblogs]: `true` のときブースト投稿を除外する（デフォルト: `false`）
  ///
  /// 失敗時は [MastodonException] のサブクラスをthrow。
  Future<List<MastodonStatus>> fetchStatuses(
    String accountId, {
    int limit = 30,
    String? maxId,
    bool excludeReplies = false,
    bool excludeReblogs = false,
  }) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/accounts/$accountId/statuses',
        queryParameters: <String, dynamic>{
          'limit': limit,
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
    required int limit,
    String? maxId,
  }) async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        path,
        queryParameters: <String, dynamic>{
          'limit': limit,
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

  /// `Link` レスポンスヘッダーから `rel="next"` の `max_id` クエリパラメーターを取り出す
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
