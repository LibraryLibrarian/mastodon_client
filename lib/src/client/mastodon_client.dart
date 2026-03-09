import 'mastodon_http_client.dart';

/// Mastodon API クライアントのメインエントリーポイント
///
/// 各 API カテゴリはプロパティとして公開され、名前空間として利用する
///
/// ```dart
/// final client = MastodonClient(
///   baseUrl: 'https://mastodon.social',
///   accessToken: 'your_token',
/// );
/// ```
class MastodonClient {
  /// [baseUrl] にはスキームを含むホスト URL（例: `https://mastodon.social`）を指定する。
  /// [accessToken] は認証が不要なエンドポイントのみ利用する場合は省略可能。
  MastodonClient({
    required String baseUrl,
    String? accessToken,
  }) : http = MastodonHttpClient(
         baseUrl: baseUrl,
         accessToken: accessToken,
       );

  /// パッケージ内部の API モジュールが共有する HTTP クライアント。
  /// 直接利用せず、各 API プロパティ経由でアクセスすること。
  final MastodonHttpClient http;

  // API サブモジュールはここに順次追加される。
  // 例: TimelinesApi get timelines => TimelinesApi(http);
}
