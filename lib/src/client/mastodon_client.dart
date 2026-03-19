import '../api/accounts_api.dart';
import '../api/admin/admin_accounts_api.dart';
import '../api/admin/admin_canonical_email_blocks_api.dart';
import '../api/admin/admin_dimensions_api.dart';
import '../api/admin/admin_domain_allows_api.dart';
import '../api/admin/admin_domain_blocks_api.dart';
import '../api/admin/admin_email_domain_blocks_api.dart';
import '../api/admin/admin_ip_blocks_api.dart';
import '../api/admin/admin_measures_api.dart';
import '../api/admin/admin_reports_api.dart';
import '../api/admin/admin_retention_api.dart';
import '../api/admin/admin_tags_api.dart';
import '../api/admin/admin_trends_api.dart';
import '../api/announcements_api.dart';
import '../api/apps_api.dart';
import '../api/async_refreshes_api.dart';
import '../api/blocks_api.dart';
import '../api/bookmarks_api.dart';
import '../api/conversations_api.dart';
import '../api/custom_emojis_api.dart';
import '../api/directory_api.dart';
import '../api/domain_blocks_api.dart';
import '../api/emails_api.dart';
import '../api/endorsements_api.dart';
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
import '../api/oauth_api.dart';
import '../api/oembed_api.dart';
import '../api/polls_api.dart';
import '../api/preferences_api.dart';
import '../api/profile_api.dart';
import '../api/proofs_api.dart';
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

/// Main entry point for the Mastodon API client.
///
/// Each API category is exposed as a property and used as a namespace.
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
  /// Creates a [MastodonClient].
  ///
  /// [baseUrl] must be the host URL including the scheme
  /// (e.g. `https://mastodon.social`). [accessToken] can be omitted when
  /// only using endpoints that do not require authentication. Set
  /// [enableLog] to `false` to disable HTTP log output, or pass a custom
  /// [logger] to redirect log output to a different destination.
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

  /// Account information API.
  AccountsApi get accounts => AccountsApi(_http);

  /// Admin account management API.
  AdminAccountsApi get adminAccounts => AdminAccountsApi(_http);

  /// Admin canonical email block management API.
  AdminCanonicalEmailBlocksApi get adminCanonicalEmailBlocks =>
      AdminCanonicalEmailBlocksApi(_http);

  /// Admin dimensions (dimensional data) API.
  AdminDimensionsApi get adminDimensions => AdminDimensionsApi(_http);

  /// Admin domain allow management API.
  AdminDomainAllowsApi get adminDomainAllows => AdminDomainAllowsApi(_http);

  /// Admin domain block management API.
  AdminDomainBlocksApi get adminDomainBlocks => AdminDomainBlocksApi(_http);

  /// Admin email domain block management API.
  AdminEmailDomainBlocksApi get adminEmailDomainBlocks =>
      AdminEmailDomainBlocksApi(_http);

  /// Admin IP block management API.
  AdminIpBlocksApi get adminIpBlocks => AdminIpBlocksApi(_http);

  /// Admin measures (quantitative data) API.
  AdminMeasuresApi get adminMeasures => AdminMeasuresApi(_http);

  /// Admin report management API.
  AdminReportsApi get adminReports => AdminReportsApi(_http);

  /// Admin retention API.
  AdminRetentionApi get adminRetention => AdminRetentionApi(_http);

  AdminTagsApi get adminTags => AdminTagsApi(_http);

  /// Admin trends API.
  AdminTrendsApi get adminTrends => AdminTrendsApi(_http);

  /// Server announcements API.
  AnnouncementsApi get announcements => AnnouncementsApi(_http);

  /// OAuth application registration and verification API.
  AppsApi get apps => AppsApi(_http);

  /// Async refresh status checking API (experimental).
  AsyncRefreshesApi get asyncRefreshes => AsyncRefreshesApi(_http);

  /// Blocked accounts listing API.
  BlocksApi get blocks => BlocksApi(_http);

  /// Bookmarked statuses listing API.
  BookmarksApi get bookmarks => BookmarksApi(_http);

  /// Direct message conversations API.
  ConversationsApi get conversations => ConversationsApi(_http);

  /// Custom emoji API.
  CustomEmojisApi get customEmojis => CustomEmojisApi(_http);

  /// Profile directory API.
  DirectoryApi get directory => DirectoryApi(_http);

  /// User-level domain block management API.
  DomainBlocksApi get domainBlocks => DomainBlocksApi(_http);

  /// Email confirmation API.
  EmailsApi get emails => EmailsApi(_http);

  /// Featured accounts (endorsements) listing API.
  EndorsementsApi get endorsements => EndorsementsApi(_http);

  /// Favourited statuses listing API.
  FavouritesApi get favourites => FavouritesApi(_http);

  /// Featured tags management API.
  FeaturedTagsApi get featuredTags => FeaturedTagsApi(_http);

  /// Filters API (v2 + v1 deprecated methods).
  FiltersApi get filters => FiltersApi(_http);

  /// Follow request management API.
  FollowRequestsApi get followRequests => FollowRequestsApi(_http);

  /// Followed hashtags listing API.
  FollowedTagsApi get followedTags => FollowedTagsApi(_http);

  /// Grouped notifications API (v2).
  GroupedNotificationsApi get groupedNotifications =>
      GroupedNotificationsApi(_http);

  /// Server health check API.
  HealthApi get health => HealthApi(_http);

  /// Instance information API.
  InstanceApi get instance => InstanceApi(_http);

  /// List creation and management API.
  ListsApi get lists => ListsApi(_http);

  /// Timeline read position markers API.
  MarkersApi get markers => MarkersApi(_http);

  /// Media upload API.
  MediaApi get media => MediaApi(_http);

  /// Muted accounts listing API.
  MutesApi get mutes => MutesApi(_http);

  /// Notifications API.
  NotificationsApi get notifications => NotificationsApi(_http);

  /// OAuth token operations API.
  OAuthApi get oauth => OAuthApi(_http);

  /// OEmbed information retrieval API.
  OEmbedApi get oembed => OEmbedApi(_http);

  /// Polls API.
  PollsApi get polls => PollsApi(_http);

  /// Web Push notification subscription API.
  PushApi get push => PushApi(_http);

  /// User preferences retrieval API.
  PreferencesApi get preferences => PreferencesApi(_http);

  /// Identity proofs API.
  ///
  /// **Deprecated**: The identity proofs feature was removed in Mastodon 3.5.0.
  // ignore: remove_deprecations_in_breaking_versions
  @Deprecated(
    'Removed in Mastodon 3.5.0. Only use for compatibility with older servers.',
  )
  ProofsApi get proofs => ProofsApi(_http);

  /// Profile image management API.
  ProfileApi get profile => ProfileApi(_http);

  /// Reports API.
  ReportsApi get reports => ReportsApi(_http);

  /// Scheduled statuses management API.
  ScheduledStatusesApi get scheduledStatuses => ScheduledStatusesApi(_http);

  /// Search API.
  SearchApi get search => SearchApi(_http);

  /// Statuses API.
  StatusesApi get statuses => StatusesApi(_http);

  /// Follow suggestions API.
  SuggestionsApi get suggestions => SuggestionsApi(_http);

  /// Hashtag information retrieval and follow operations API.
  TagsApi get tags => TagsApi(_http);

  /// Timelines API.
  TimelinesApi get timelines => TimelinesApi(_http);

  /// Trends (tags, statuses, and links) API.
  TrendsApi get trends => TrendsApi(_http);
}
