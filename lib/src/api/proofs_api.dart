import '../client/mastodon_http_client.dart';
import '../models/mastodon_proof.dart';

/// 本人確認証明（Identity Proofs）に関する API クライアント
///
/// **非推奨**: Mastodon 3.5.0 以降では本人確認証明機能は削除されている。
/// 古いサーバーバージョンとの互換性のために提供される。
@Deprecated('Mastodon 3.5.0 で削除済み。古いサーバーとの互換性のためのみ使用')
class ProofsApi {
  /// [MastodonHttpClient] を受け取り、Proofs API へのアクセスを提供する
  @Deprecated('Mastodon 3.5.0 で削除済み。古いサーバーとの互換性のためのみ使用')
  const ProofsApi(this._http);

  final MastodonHttpClient _http;

  /// 指定した本人確認プロバイダーのユーザー証明情報を取得する
  ///
  /// `GET /api/proofs`
  ///
  /// - [provider]: 本人確認プロバイダー名（大文字小文字を区別、例: `keybase`）
  /// - [username]: プロバイダー上のユーザー名
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonProof> fetch({
    required String provider,
    required String username,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/proofs',
      queryParameters: <String, dynamic>{
        'provider': provider,
        'username': username,
      },
    );
    return MastodonProof.fromJson(data!);
  }
}
