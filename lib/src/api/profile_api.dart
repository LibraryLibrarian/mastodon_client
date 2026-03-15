import '../client/mastodon_http_client.dart';
import '../models/mastodon_account.dart';

/// プロフィール画像の管理に関する API クライアント
class ProfileApi {
  /// [MastodonHttpClient] を受け取り、プロフィール API へのアクセスを提供する
  const ProfileApi(this._http);

  final MastodonHttpClient _http;

  /// プロフィールのアバター画像を削除する
  ///
  /// `DELETE /api/v1/profile/avatar`
  ///
  /// アバターが設定されていない場合でも操作は成功する。
  /// 認証必須（`write:accounts` スコープ）。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAccount> deleteAvatar() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/profile/avatar',
      method: 'DELETE',
    );
    return MastodonAccount.fromJson(data!);
  }

  /// プロフィールのヘッダー画像を削除する
  ///
  /// `DELETE /api/v1/profile/header`
  ///
  /// ヘッダーが設定されていない場合でも操作は成功する。
  /// 認証必須（`write:accounts` スコープ）。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonAccount> deleteHeader() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/profile/header',
      method: 'DELETE',
    );
    return MastodonAccount.fromJson(data!);
  }
}
