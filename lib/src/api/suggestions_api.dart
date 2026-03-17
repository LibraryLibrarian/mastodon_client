import '../client/mastodon_http_client.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_suggestion.dart';

/// フォロー候補（サジェスション）に関する API クライアント
class SuggestionsApi {
  /// [MastodonHttpClient] を受け取り、サジェスション API へのアクセスを提供する
  const SuggestionsApi(this._http);

  final MastodonHttpClient _http;

  /// フォロー候補の一覧を取得する
  ///
  /// `GET /api/v2/suggestions`
  ///
  /// スタッフ推薦のアカウント、または過去にポジティブなインタラクションを
  /// 行ったがまだフォローしていないアカウントを返す。
  ///
  /// - [limit]: 最大取得件数（デフォルト: 40、上限: 80）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonSuggestion>> fetch({int? limit}) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v2/suggestions',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonSuggestion.fromJson)
        .toList();
  }

  /// v1 形式のフォロー候補一覧を取得する
  ///
  /// `GET /api/v1/suggestions`
  ///
  /// **非推奨**: Mastodon 3.4.0 で非推奨。代わりに [fetch]（v2）を使用すること。
  /// v2 と異なり、提案のソース情報（`source`）を含まず `Account` の配列を返す。
  ///
  /// - [limit]: 最大取得件数（デフォルト: 40、上限: 80）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  @Deprecated('Mastodon 3.4.0 で非推奨。代わりに fetch() (v2) を使用してください')
  Future<List<MastodonAccount>> fetchV1({int? limit}) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/suggestions',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }

  /// フォロー候補からアカウントを削除する
  ///
  /// `DELETE /api/v1/suggestions/{accountId}`
  ///
  /// 存在しない ID や候補に含まれない ID を指定しても操作は成功する。
  ///
  /// - [accountId]: 削除対象のアカウント ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> remove(String accountId) async {
    await _http.send<void>(
      '/api/v1/suggestions/$accountId',
      method: 'DELETE',
    );
  }
}
