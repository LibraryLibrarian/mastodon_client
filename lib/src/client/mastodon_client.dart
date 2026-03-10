import '../api/instance_api.dart';
import '../api/media_api.dart';
import '../api/polls_api.dart';
import '../api/statuses_api.dart';
import '../api/timelines_api.dart';
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
  MastodonClient({
    required String baseUrl,
    String? accessToken,
  }) : _http = MastodonHttpClient(
         baseUrl: baseUrl,
         accessToken: accessToken,
       );

  final MastodonHttpClient _http;

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
}
