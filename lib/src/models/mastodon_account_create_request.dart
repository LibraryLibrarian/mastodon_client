/// アカウント登録リクエストのパラメーター
///
/// `POST /api/v1/accounts` のリクエストボディに対応する。
class MastodonAccountCreateRequest {
  /// アカウント登録リクエストのパラメーターを生成する
  const MastodonAccountCreateRequest({
    required this.username,
    required this.email,
    required this.password,
    required this.agreement,
    required this.locale,
    this.reason,
    this.dateOfBirth,
  });

  /// 希望するユーザー名
  final String username;

  /// メールアドレス
  final String email;

  /// パスワード
  final String password;

  /// サーバー利用規約への同意
  final bool agreement;

  /// ユーザーのロケール（ISO 639-1 形式）
  final String locale;

  /// 登録理由（承認制インスタンスで要求される場合がある）
  final String? reason;

  /// 生年月日（`YYYY-MM-DD` 形式）
  final String? dateOfBirth;

  /// リクエストボディ用の JSON マップを返す
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'agreement': agreement,
      'locale': locale,
      if (reason != null) 'reason': reason,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
    };
  }
}
