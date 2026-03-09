import 'mastodon_account.dart';

/// タイムラインの公開アクセスレベル。
enum MastodonTimelineAccessLevel {
  /// 未認証ユーザーを含む誰でも閲覧可能
  public,

  /// 認証済みユーザーのみ閲覧可能
  authenticated,

  /// 無効（閲覧不可）
  disabled
  ;

  static MastodonTimelineAccessLevel fromString(String? value) {
    return switch (value) {
      'public' => MastodonTimelineAccessLevel.public,
      'authenticated' => MastodonTimelineAccessLevel.authenticated,
      'disabled' => MastodonTimelineAccessLevel.disabled,
      _ => MastodonTimelineAccessLevel.public,
    };
  }
}

/// ライブフィード（リアルタイムタイムライン）のアクセス設定
class MastodonTimelineLiveFeeds {
  const MastodonTimelineLiveFeeds({
    required this.local,
    required this.remote,
  });

  factory MastodonTimelineLiveFeeds.fromJson(Map<String, dynamic> json) {
    return MastodonTimelineLiveFeeds(
      local: MastodonTimelineAccessLevel.fromString(
        json['local'] as String?,
      ),
      remote: MastodonTimelineAccessLevel.fromString(
        json['remote'] as String?,
      ),
    );
  }

  /// ローカルタイムラインのアクセスレベル
  final MastodonTimelineAccessLevel local;

  /// 連合タイムラインのアクセスレベル
  final MastodonTimelineAccessLevel remote;
}

/// ハッシュタグフィードのアクセス設定
class MastodonTimelineHashtagFeeds {
  const MastodonTimelineHashtagFeeds({
    required this.local,
    required this.remote,
  });

  factory MastodonTimelineHashtagFeeds.fromJson(Map<String, dynamic> json) {
    return MastodonTimelineHashtagFeeds(
      local: MastodonTimelineAccessLevel.fromString(
        json['local'] as String?,
      ),
      remote: MastodonTimelineAccessLevel.fromString(
        json['remote'] as String?,
      ),
    );
  }

  final MastodonTimelineAccessLevel local;
  final MastodonTimelineAccessLevel remote;
}

/// インスタンスのタイムラインアクセス設定（`configuration.timelines_access`）
class MastodonTimelinesAccess {
  const MastodonTimelinesAccess({
    this.liveFeeds,
    this.hashtagFeeds,
  });

  factory MastodonTimelinesAccess.fromJson(Map<String, dynamic> json) {
    return MastodonTimelinesAccess(
      liveFeeds: json['live_feeds'] != null
          ? MastodonTimelineLiveFeeds.fromJson(
              json['live_feeds'] as Map<String, dynamic>,
            )
          : null,
      hashtagFeeds: json['hashtag_feeds'] != null
          ? MastodonTimelineHashtagFeeds.fromJson(
              json['hashtag_feeds'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// ライブフィードのアクセス設定nullの場合は両タイムラインともpublicとみなす
  final MastodonTimelineLiveFeeds? liveFeeds;

  /// ハッシュタグフィードのアクセス設定
  final MastodonTimelineHashtagFeeds? hashtagFeeds;
}

/// インスタンスのURL設定（`configuration.urls`）
class MastodonInstanceUrls {
  const MastodonInstanceUrls({
    this.streaming,
    this.status,
    this.about,
    this.privacyPolicy,
    this.termsOfService,
  });

  factory MastodonInstanceUrls.fromJson(Map<String, dynamic> json) {
    return MastodonInstanceUrls(
      streaming: json['streaming'] as String?,
      status: json['status'] as String?,
      about: json['about'] as String?,
      privacyPolicy: json['privacy_policy'] as String?,
      termsOfService: json['terms_of_service'] as String?,
    );
  }

  /// WebSocketストリーミングの接続先URL
  final String? streaming;

  /// インスタンスのステータスページURL
  final String? status;

  /// インスタンスの概要ページURL
  final String? about;

  /// プライバシーポリシーのURL
  final String? privacyPolicy;

  /// 利用規約のURL
  final String? termsOfService;
}

/// 投稿に関する制限設定（`configuration.statuses`）
class MastodonStatusesConfiguration {
  const MastodonStatusesConfiguration({
    required this.maxCharacters,
    required this.maxMediaAttachments,
    required this.charactersReservedPerUrl,
  });

  factory MastodonStatusesConfiguration.fromJson(Map<String, dynamic> json) {
    return MastodonStatusesConfiguration(
      maxCharacters: json['max_characters'] as int? ?? 500,
      maxMediaAttachments: json['max_media_attachments'] as int? ?? 4,
      charactersReservedPerUrl:
          json['characters_reserved_per_url'] as int? ?? 23,
    );
  }

  /// 投稿の最大文字数
  final int maxCharacters;

  /// 添付メディアの最大件数
  final int maxMediaAttachments;

  /// URLが消費する文字数
  final int charactersReservedPerUrl;
}

/// メディア添付に関する制限設定（`configuration.media_attachments`）
class MastodonMediaConfiguration {
  const MastodonMediaConfiguration({
    required this.supportedMimeTypes,
    this.descriptionLimit,
    this.imageSizeLimit,
    this.imageMatrixLimit,
    this.videoSizeLimit,
    this.videoFrameRateLimit,
    this.videoMatrixLimit,
  });

  factory MastodonMediaConfiguration.fromJson(Map<String, dynamic> json) {
    return MastodonMediaConfiguration(
      supportedMimeTypes:
          (json['supported_mime_types'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      descriptionLimit: json['description_limit'] as int?,
      imageSizeLimit: json['image_size_limit'] as int?,
      imageMatrixLimit: json['image_matrix_limit'] as int?,
      videoSizeLimit: json['video_size_limit'] as int?,
      videoFrameRateLimit: json['video_frame_rate_limit'] as int?,
      videoMatrixLimit: json['video_matrix_limit'] as int?,
    );
  }

  /// 受け付けるMIMEタイプのリスト
  final List<String> supportedMimeTypes;

  /// メディアの代替テキストの最大文字数
  final int? descriptionLimit;

  /// 画像の最大ファイルサイズ（バイト）
  final int? imageSizeLimit;

  /// 画像の最大ピクセル数（幅 × 高さ）
  final int? imageMatrixLimit;

  /// 動画の最大ファイルサイズ（バイト）
  final int? videoSizeLimit;

  /// 動画の最大フレームレート
  final int? videoFrameRateLimit;

  /// 動画の最大ピクセル数（幅 × 高さ）
  final int? videoMatrixLimit;
}

/// 投票に関する制限設定（`configuration.polls`）
class MastodonPollsConfiguration {
  const MastodonPollsConfiguration({
    required this.maxOptions,
    required this.maxCharactersPerOption,
    required this.minExpiration,
    required this.maxExpiration,
  });

  factory MastodonPollsConfiguration.fromJson(Map<String, dynamic> json) {
    return MastodonPollsConfiguration(
      maxOptions: json['max_options'] as int? ?? 4,
      maxCharactersPerOption: json['max_characters_per_option'] as int? ?? 50,
      minExpiration: json['min_expiration'] as int? ?? 300,
      maxExpiration: json['max_expiration'] as int? ?? 2629746,
    );
  }

  /// 投票の最大選択肢数
  final int maxOptions;

  /// 各選択肢の最大文字数
  final int maxCharactersPerOption;

  /// 投票の最短期間（秒）
  final int minExpiration;

  /// 投票の最長期間（秒）
  final int maxExpiration;
}

/// アカウントに関する制限設定（`configuration.accounts`）
class MastodonAccountsConfiguration {
  const MastodonAccountsConfiguration({
    required this.maxFeaturedTags,
    required this.maxPinnedStatuses,
    required this.maxProfileFields,
    required this.profileFieldNameLimit,
    required this.profileFieldValueLimit,
  });

  factory MastodonAccountsConfiguration.fromJson(Map<String, dynamic> json) {
    return MastodonAccountsConfiguration(
      maxFeaturedTags: json['max_featured_tags'] as int? ?? 10,
      maxPinnedStatuses: json['max_pinned_statuses'] as int? ?? 5,
      maxProfileFields: json['max_profile_fields'] as int? ?? 4,
      profileFieldNameLimit: json['profile_field_name_limit'] as int? ?? 255,
      profileFieldValueLimit: json['profile_field_value_limit'] as int? ?? 255,
    );
  }

  /// フィーチャータグの最大件数
  final int maxFeaturedTags;

  /// ピン留め投稿の最大件数
  final int maxPinnedStatuses;

  /// プロフィールフィールドの最大件数
  final int maxProfileFields;

  /// プロフィールフィールドのラベル最大文字数
  final int profileFieldNameLimit;

  /// プロフィールフィールドの値最大文字数
  final int profileFieldValueLimit;
}

/// インスタンスの各種制限・設定（`configuration`）
class MastodonInstanceConfiguration {
  const MastodonInstanceConfiguration({
    required this.urls,
    this.statuses,
    this.mediaAttachments,
    this.polls,
    this.accounts,
    this.timelinesAccess,
    this.translationEnabled,
    this.limitedFederation,
    this.vapidPublicKey,
  });

  factory MastodonInstanceConfiguration.fromJson(Map<String, dynamic> json) {
    return MastodonInstanceConfiguration(
      urls: json['urls'] != null
          ? MastodonInstanceUrls.fromJson(
              json['urls'] as Map<String, dynamic>,
            )
          : const MastodonInstanceUrls(),
      statuses: json['statuses'] != null
          ? MastodonStatusesConfiguration.fromJson(
              json['statuses'] as Map<String, dynamic>,
            )
          : null,
      mediaAttachments: json['media_attachments'] != null
          ? MastodonMediaConfiguration.fromJson(
              json['media_attachments'] as Map<String, dynamic>,
            )
          : null,
      polls: json['polls'] != null
          ? MastodonPollsConfiguration.fromJson(
              json['polls'] as Map<String, dynamic>,
            )
          : null,
      accounts: json['accounts'] != null
          ? MastodonAccountsConfiguration.fromJson(
              json['accounts'] as Map<String, dynamic>,
            )
          : null,
      timelinesAccess: json['timelines_access'] != null
          ? MastodonTimelinesAccess.fromJson(
              json['timelines_access'] as Map<String, dynamic>,
            )
          : null,
      translationEnabled:
          (json['translation'] as Map<String, dynamic>?)?['enabled'] as bool?,
      limitedFederation: json['limited_federation'] as bool?,
      vapidPublicKey:
          (json['vapid'] as Map<String, dynamic>?)?['public_key'] as String?,
    );
  }

  /// URL設定（ストリーミングURLを含む）
  final MastodonInstanceUrls urls;

  /// 投稿制限設定
  final MastodonStatusesConfiguration? statuses;

  /// メディア添付制限設定
  final MastodonMediaConfiguration? mediaAttachments;

  /// 投票制限設定
  final MastodonPollsConfiguration? polls;

  /// アカウント制限設定
  final MastodonAccountsConfiguration? accounts;

  /// タイムラインのアクセス設定nullの場合は両タイムラインともpublicとみなす
  final MastodonTimelinesAccess? timelinesAccess;

  /// 翻訳機能が有効かどうか
  final bool? translationEnabled;

  /// 連合を制限しているかどうか（Mastodon 4.3+）
  final bool? limitedFederation;

  /// VAPID公開鍵（WebPush通知用）
  final String? vapidPublicKey;
}

/// インスタンスのサムネイル画像情報（`thumbnail`）
class MastodonInstanceThumbnail {
  const MastodonInstanceThumbnail({required this.url, this.blurhash});

  factory MastodonInstanceThumbnail.fromJson(Map<String, dynamic> json) {
    return MastodonInstanceThumbnail(
      url: json['url'] as String,
      blurhash: json['blurhash'] as String?,
    );
  }

  final String url;
  final String? blurhash;
}

/// インスタンスの利用状況（`usage`）
class MastodonInstanceUsage {
  const MastodonInstanceUsage({required this.activeMonth});

  factory MastodonInstanceUsage.fromJson(Map<String, dynamic> json) {
    final users = json['users'] as Map<String, dynamic>?;
    return MastodonInstanceUsage(
      activeMonth: users?['active_month'] as int? ?? 0,
    );
  }

  /// 過去1ヶ月のアクティブユーザー数
  final int activeMonth;
}

/// インスタンスの登録設定（`registrations`）
class MastodonInstanceRegistrations {
  const MastodonInstanceRegistrations({
    required this.enabled,
    required this.approvalRequired,
    this.message,
  });

  factory MastodonInstanceRegistrations.fromJson(Map<String, dynamic> json) {
    return MastodonInstanceRegistrations(
      enabled: json['enabled'] as bool? ?? false,
      approvalRequired: json['approval_required'] as bool? ?? false,
      message: json['message'] as String?,
    );
  }

  /// 新規登録を受け付けているかどうか
  final bool enabled;

  /// 管理者による承認が必要かどうか
  final bool approvalRequired;

  /// 登録を停止している場合に表示するメッセージ
  final String? message;
}

/// インスタンスの連絡先情報（`contact`）
class MastodonInstanceContact {
  const MastodonInstanceContact({this.email, this.account});

  factory MastodonInstanceContact.fromJson(Map<String, dynamic> json) {
    return MastodonInstanceContact(
      email: json['email'] as String?,
      account: json['account'] != null
          ? MastodonAccount.fromJson(
              json['account'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// 管理者の連絡先メールアドレス。
  final String? email;

  /// 管理者アカウント。
  final MastodonAccount? account;
}

/// インスタンスの利用規約（`rules`）
class MastodonInstanceRule {
  const MastodonInstanceRule({
    required this.id,
    required this.text,
    this.hint,
  });

  factory MastodonInstanceRule.fromJson(Map<String, dynamic> json) {
    return MastodonInstanceRule(
      id: json['id'] as String,
      text: json['text'] as String,
      hint: json['hint'] as String?,
    );
  }

  final String id;
  final String text;

  /// 規約の補足説明
  final String? hint;
}

/// Mastodonインスタンスの情報
///
/// `/api/v2/instance`のレスポンスに対応
class MastodonInstance {
  const MastodonInstance({
    required this.domain,
    required this.title,
    required this.version,
    required this.configuration,
    required this.rules,
    this.sourceUrl,
    this.description,
    this.thumbnail,
    this.usage,
    this.contact,
    this.registrations,
    this.languages,
    this.apiVersionMastodon,
  });

  factory MastodonInstance.fromJson(Map<String, dynamic> json) {
    return MastodonInstance(
      domain: json['domain'] as String,
      title: json['title'] as String? ?? '',
      version: json['version'] as String? ?? '',
      sourceUrl: json['source_url'] as String?,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] != null
          ? MastodonInstanceThumbnail.fromJson(
              json['thumbnail'] as Map<String, dynamic>,
            )
          : null,
      usage: json['usage'] != null
          ? MastodonInstanceUsage.fromJson(
              json['usage'] as Map<String, dynamic>,
            )
          : null,
      configuration: json['configuration'] != null
          ? MastodonInstanceConfiguration.fromJson(
              json['configuration'] as Map<String, dynamic>,
            )
          : const MastodonInstanceConfiguration(
              urls: MastodonInstanceUrls(),
            ),
      contact: json['contact'] != null
          ? MastodonInstanceContact.fromJson(
              json['contact'] as Map<String, dynamic>,
            )
          : null,
      registrations: json['registrations'] != null
          ? MastodonInstanceRegistrations.fromJson(
              json['registrations'] as Map<String, dynamic>,
            )
          : null,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rules:
          (json['rules'] as List<dynamic>?)
              ?.map(
                (r) => MastodonInstanceRule.fromJson(
                  r as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
      apiVersionMastodon:
          (json['api_versions'] as Map<String, dynamic>?)?['mastodon'] as int?,
    );
  }

  /// インスタンスのドメイン名
  final String domain;

  /// インスタンスのタイトル
  final String title;

  /// Mastodonのバージョン文字列（例: `4.3.0`）
  final String version;

  /// ソースコードリポジトリのURL フォーク検出に使用可能
  final String? sourceUrl;

  /// インスタンスの説明文（HTML形式）
  final String? description;

  /// インスタンスのサムネイル画像
  final MastodonInstanceThumbnail? thumbnail;

  /// インスタンスの利用状況
  final MastodonInstanceUsage? usage;

  /// 各種制限・設定
  final MastodonInstanceConfiguration configuration;

  /// 連絡先情報（管理者メールアドレスとアカウント）
  final MastodonInstanceContact? contact;

  /// 新規登録に関する設定
  final MastodonInstanceRegistrations? registrations;

  /// インスタンスが対応している言語コードのリスト
  final List<String>? languages;

  /// インスタンスの利用規約リスト
  final List<MastodonInstanceRule> rules;

  /// MastodonAPI バージョン番号（`api_versions.mastodon`）
  final int? apiVersionMastodon;
}
