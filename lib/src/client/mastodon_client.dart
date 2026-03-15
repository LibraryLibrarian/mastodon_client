import '../api/accounts_api.dart';
import '../api/announcements_api.dart';
import '../api/async_refreshes_api.dart';
import '../api/blocks_api.dart';
import '../api/bookmarks_api.dart';
import '../api/conversations_api.dart';
import '../api/custom_emojis_api.dart';
import '../api/directory_api.dart';
import '../api/domain_blocks_api.dart';
import '../api/emails_api.dart';
import '../api/favourites_api.dart';
import '../api/featured_tags_api.dart';
import '../api/filters_api.dart';
import '../api/follow_requests_api.dart';
import '../api/followed_tags_api.dart';
import '../api/grouped_notifications_api.dart';
import '../api/health_api.dart';
import '../api/instance_api.dart';
import '../api/lists_api.dart';
import '../api/markers_api.dart';
import '../api/media_api.dart';
import '../api/mutes_api.dart';
import '../api/notifications_api.dart';
import '../api/oembed_api.dart';
import '../api/polls_api.dart';
import '../api/preferences_api.dart';
import '../api/profile_api.dart';
import '../api/push_api.dart';
import '../api/reports_api.dart';
import '../api/scheduled_statuses_api.dart';
import '../api/search_api.dart';
import '../api/statuses_api.dart';
import '../api/suggestions_api.dart';
import '../api/tags_api.dart';
import '../api/timelines_api.dart';
import '../api/trends_api.dart';
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

  /// サーバーのお知らせに関するAPI
  AnnouncementsApi get announcements => AnnouncementsApi(_http);

  /// 非同期リフレッシュのステータス確認に関するAPI（実験的）
  AsyncRefreshesApi get asyncRefreshes => AsyncRefreshesApi(_http);

  /// ブロック中アカウントの一覧取得に関するAPI
  BlocksApi get blocks => BlocksApi(_http);

  /// ブックマークした投稿の一覧取得に関するAPI
  BookmarksApi get bookmarks => BookmarksApi(_http);

  /// ダイレクトメッセージの会話に関するAPI
  ConversationsApi get conversations => ConversationsApi(_http);

  /// カスタム絵文字に関するAPI
  CustomEmojisApi get customEmojis => CustomEmojisApi(_http);

  /// プロフィールディレクトリに関するAPI
  DirectoryApi get directory => DirectoryApi(_http);

  /// ユーザーレベルのドメインブロック管理に関するAPI
  DomainBlocksApi get domainBlocks => DomainBlocksApi(_http);

  /// メール確認に関するAPI
  EmailsApi get emails => EmailsApi(_http);

  /// お気に入りした投稿の一覧取得に関するAPI
  FavouritesApi get favourites => FavouritesApi(_http);

  /// 注目ハッシュタグの管理に関するAPI
  FeaturedTagsApi get featuredTags => FeaturedTagsApi(_http);

  /// フィルターに関するAPI（v2 + v1 非推奨メソッド）
  FiltersApi get filters => FiltersApi(_http);

  /// フォローリクエストの管理に関するAPI
  FollowRequestsApi get followRequests => FollowRequestsApi(_http);

  /// フォロー中のハッシュタグの一覧取得に関するAPI
  FollowedTagsApi get followedTags => FollowedTagsApi(_http);

  /// グループ化通知に関するAPI（v2）
  GroupedNotificationsApi get groupedNotifications =>
      GroupedNotificationsApi(_http);

  /// サーバーヘルスチェックに関するAPI
  HealthApi get health => HealthApi(_http);

  /// インスタンス情報に関するAPI
  InstanceApi get instance => InstanceApi(_http);

  /// リストの作成・管理に関するAPI
  ListsApi get lists => ListsApi(_http);

  /// タイムラインの既読位置マーカーに関するAPI
  MarkersApi get markers => MarkersApi(_http);

  /// メディアアップロードに関するAPI
  MediaApi get media => MediaApi(_http);

  /// ミュート中アカウントの一覧取得に関するAPI
  MutesApi get mutes => MutesApi(_http);

  /// 通知に関するAPI
  NotificationsApi get notifications => NotificationsApi(_http);

  /// OEmbed 情報の取得に関するAPI
  OEmbedApi get oembed => OEmbedApi(_http);

  /// 投票に関するAPI
  PollsApi get polls => PollsApi(_http);

  /// Web Push 通知サブスクリプションに関するAPI
  PushApi get push => PushApi(_http);

  /// ユーザー設定の取得に関するAPI
  PreferencesApi get preferences => PreferencesApi(_http);

  /// プロフィール画像の管理に関するAPI
  ProfileApi get profile => ProfileApi(_http);

  /// 通報に関するAPI
  ReportsApi get reports => ReportsApi(_http);

  /// 予約投稿の管理に関するAPI
  ScheduledStatusesApi get scheduledStatuses => ScheduledStatusesApi(_http);

  /// 検索に関するAPI
  SearchApi get search => SearchApi(_http);

  /// 投稿（Status）に関するAPI
  StatusesApi get statuses => StatusesApi(_http);

  /// フォロー候補（サジェスション）に関するAPI
  SuggestionsApi get suggestions => SuggestionsApi(_http);

  /// ハッシュタグ情報の取得・フォロー操作に関するAPI
  TagsApi get tags => TagsApi(_http);

  /// タイムライン取得に関するAPI
  TimelinesApi get timelines => TimelinesApi(_http);

  /// トレンド（タグ・投稿・リンク）に関するAPI
  TrendsApi get trends => TrendsApi(_http);
}
