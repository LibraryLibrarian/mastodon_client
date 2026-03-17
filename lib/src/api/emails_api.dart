import '../client/mastodon_http_client.dart';

/// メール確認に関する API クライアント
class EmailsApi {
  /// [MastodonHttpClient] を受け取り、メール API へのアクセスを提供する
  const EmailsApi(this._http);

  final MastodonHttpClient _http;

  /// 確認メールを再送信する
  ///
  /// `POST /api/v1/emails/confirmations`
  ///
  /// [email] を指定した場合、未確認ユーザーのメールアドレスを更新してから
  /// 確認メールを再送信する。
  ///
  /// 認証必須（未確認ユーザーを作成したクライアントのトークンが必要）。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> resendConfirmation({String? email}) async {
    await _http.send<dynamic>(
      '/api/v1/emails/confirmations',
      method: 'POST',
      data: <String, dynamic>{
        'email': ?email,
      },
    );
  }

  Future<void> checkConfirmation() async {
    await _http.send<dynamic>(
      '/api/v1/emails/check_confirmation',
    );
  }
}
