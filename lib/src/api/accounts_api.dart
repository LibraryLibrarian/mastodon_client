import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_account.dart';

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
}
