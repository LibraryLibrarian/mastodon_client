import '../api/accounts_api.dart';
import '../api/instance_api.dart';
import '../api/media_api.dart';
import '../api/notifications_api.dart';
import '../api/polls_api.dart';
import '../api/statuses_api.dart';
import '../api/timelines_api.dart';
import '../logging/logger.dart';
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
///
/// final info = await client.instance.fetch();
/// ```
class MastodonClient {
  /// [baseUrl] にはスキームを含むホスト URL（例: `https://mastodon.social`）を指定する
  ///
  /// [accessToken] は認証が不要なエンドポイントのみ利用する場合は省略可能
  ///
  /// [enableLog] を `false` にするとHTTPログ出力を無効化する
  ///
  /// [logger] にカスタムロガーを渡すことでログ出力先を差し替え可能
  MastodonClient({
    required String baseUrl,
    String? accessToken,
    bool enableLog = true,
    Logger? logger,
  }) : _http = MastodonHttpClient(
         baseUrl: baseUrl,
         accessToken: accessToken,
         enableLog: enableLog,
         logger: logger,
       );

  final MastodonHttpClient _http;

  /// アカウント情報に関するAPI
  AccountsApi get accounts => AccountsApi(_http);

  /// インスタンス情報に関するAPI
  InstanceApi get instance => InstanceApi(_http);

  /// タイムライン取得に関するAPI
  TimelinesApi get timelines => TimelinesApi(_http);

  /// 投稿（Status）に関するAPI
  StatusesApi get statuses => StatusesApi(_http);

  /// メディアアップロードに関するAPI
  MediaApi get media => MediaApi(_http);

  /// 投票に関するAPI
  PollsApi get polls => PollsApi(_http);

  /// 通知に関するAPI
  NotificationsApi get notifications => NotificationsApi(_http);
}
