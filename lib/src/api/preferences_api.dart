import '../client/mastodon_http_client.dart';
import '../models/mastodon_preferences.dart';
import 'accounts_api.dart' show AccountsApi;

/// ユーザー設定の取得に関するAPI
///
/// 設定の変更は [AccountsApi.updateCredentials] を通じて行う。
class PreferencesApi {
  /// [MastodonHttpClient] を受け取り、プリファレンスAPIへのアクセスを提供する
  const PreferencesApi(this._http);

  final MastodonHttpClient _http;

  /// ユーザーのアカウント設定を取得する
  ///
  /// `GET /api/v1/preferences`
  ///
  /// 投稿のデフォルト公開範囲・言語・閲覧注意設定や、
  /// メディア展開設定・CW展開設定などを含む。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPreferences> fetch() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/preferences',
    );
    return MastodonPreferences.fromJson(data!);
  }
}
