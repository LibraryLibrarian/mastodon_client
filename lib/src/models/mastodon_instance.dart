import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';

part 'mastodon_instance.g.dart';

/// タイムラインの公開アクセスレベル。
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonTimelineAccessLevel {
  /// 未認証ユーザーを含む誰でも閲覧可能
  public,

  /// 認証済みユーザーのみ閲覧可能
  authenticated,

  /// 無効（閲覧不可）
  disabled,
}

/// ライブフィード（リアルタイムタイムライン）のアクセス設定
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonTimelineLiveFeeds {
  const MastodonTimelineLiveFeeds({
    required this.local,
    required this.remote,
  });

  factory MastodonTimelineLiveFeeds.fromJson(Map<String, dynamic> json) =>
      _$MastodonTimelineLiveFeedsFromJson(json);

  static Object? _readLocal(Map<dynamic, dynamic> json, String key) =>
      json['local'] ?? 'public';

  static Object? _readRemote(Map<dynamic, dynamic> json, String key) =>
      json['remote'] ?? 'public';

  /// ローカルタイムラインのアクセスレベル
  @JsonKey(
    readValue: _readLocal,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  final MastodonTimelineAccessLevel local;

  /// 連合タイムラインのアクセスレベル
  @JsonKey(
    readValue: _readRemote,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  final MastodonTimelineAccessLevel remote;
}

/// ハッシュタグフィードのアクセス設定
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonTimelineHashtagFeeds {
  const MastodonTimelineHashtagFeeds({
    required this.local,
    required this.remote,
  });

  factory MastodonTimelineHashtagFeeds.fromJson(Map<String, dynamic> json) =>
      _$MastodonTimelineHashtagFeedsFromJson(json);

  static Object? _readLocal(Map<dynamic, dynamic> json, String key) =>
      json['local'] ?? 'public';

  static Object? _readRemote(Map<dynamic, dynamic> json, String key) =>
      json['remote'] ?? 'public';

  @JsonKey(
    readValue: _readLocal,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  final MastodonTimelineAccessLevel local;

  @JsonKey(
    readValue: _readRemote,
    unknownEnumValue: MastodonTimelineAccessLevel.public,
  )
  final MastodonTimelineAccessLevel remote;
}

/// インスタンスのタイムラインアクセス設定（`configuration.timelines_access`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonTimelinesAccess {
  const MastodonTimelinesAccess({
    this.liveFeeds,
    this.hashtagFeeds,
  });

  factory MastodonTimelinesAccess.fromJson(Map<String, dynamic> json) =>
      _$MastodonTimelinesAccessFromJson(json);

  /// ライブフィードのアクセス設定nullの場合は両タイムラインともpublicとみなす
  final MastodonTimelineLiveFeeds? liveFeeds;

  /// ハッシュタグフィードのアクセス設定
  final MastodonTimelineHashtagFeeds? hashtagFeeds;
}

/// インスタンスのURL設定（`configuration.urls`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonInstanceUrls {
  const MastodonInstanceUrls({
    this.streaming,
    this.status,
    this.about,
    this.privacyPolicy,
    this.termsOfService,
  });

  factory MastodonInstanceUrls.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceUrlsFromJson(json);

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
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonStatusesConfiguration {
  const MastodonStatusesConfiguration({
    required this.maxCharacters,
    required this.maxMediaAttachments,
    required this.charactersReservedPerUrl,
  });

  factory MastodonStatusesConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonStatusesConfigurationFromJson(json);

  /// 投稿の最大文字数
  @JsonKey(defaultValue: 500)
  final int maxCharacters;

  /// 添付メディアの最大件数
  @JsonKey(defaultValue: 4)
  final int maxMediaAttachments;

  /// URLが消費する文字数
  @JsonKey(defaultValue: 23)
  final int charactersReservedPerUrl;
}

/// メディア添付に関する制限設定（`configuration.media_attachments`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  factory MastodonMediaConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonMediaConfigurationFromJson(json);

  /// 受け付けるMIMEタイプのリスト
  @JsonKey(defaultValue: <String>[])
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
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonPollsConfiguration {
  const MastodonPollsConfiguration({
    required this.maxOptions,
    required this.maxCharactersPerOption,
    required this.minExpiration,
    required this.maxExpiration,
  });

  factory MastodonPollsConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonPollsConfigurationFromJson(json);

  /// 投票の最大選択肢数
  @JsonKey(defaultValue: 4)
  final int maxOptions;

  /// 各選択肢の最大文字数
  @JsonKey(defaultValue: 50)
  final int maxCharactersPerOption;

  /// 投票の最短期間（秒）
  @JsonKey(defaultValue: 300)
  final int minExpiration;

  /// 投票の最長期間（秒）
  @JsonKey(defaultValue: 2629746)
  final int maxExpiration;
}

/// アカウントに関する制限設定（`configuration.accounts`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonAccountsConfiguration {
  const MastodonAccountsConfiguration({
    required this.maxFeaturedTags,
    required this.maxPinnedStatuses,
    required this.maxProfileFields,
    required this.profileFieldNameLimit,
    required this.profileFieldValueLimit,
  });

  factory MastodonAccountsConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonAccountsConfigurationFromJson(json);

  /// フィーチャータグの最大件数
  @JsonKey(defaultValue: 10)
  final int maxFeaturedTags;

  /// ピン留め投稿の最大件数
  @JsonKey(defaultValue: 5)
  final int maxPinnedStatuses;

  /// プロフィールフィールドの最大件数
  @JsonKey(defaultValue: 4)
  final int maxProfileFields;

  /// プロフィールフィールドのラベル最大文字数
  @JsonKey(defaultValue: 255)
  final int profileFieldNameLimit;

  /// プロフィールフィールドの値最大文字数
  @JsonKey(defaultValue: 255)
  final int profileFieldValueLimit;
}

/// インスタンスの各種制限・設定（`configuration`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  factory MastodonInstanceConfiguration.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceConfigurationFromJson(json);

  static Object? _readUrls(Map<dynamic, dynamic> json, String key) =>
      json['urls'] ?? const <String, dynamic>{};

  static Object? _readTranslationEnabled(
    Map<dynamic, dynamic> json,
    String key,
  ) => (json['translation'] as Map<dynamic, dynamic>?)?['enabled'];

  static Object? _readVapidPublicKey(
    Map<dynamic, dynamic> json,
    String key,
  ) => (json['vapid'] as Map<dynamic, dynamic>?)?['public_key'];

  /// URL設定（ストリーミングURLを含む）
  @JsonKey(readValue: _readUrls)
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
  @JsonKey(readValue: _readTranslationEnabled)
  final bool? translationEnabled;

  /// 連合を制限しているかどうか（Mastodon 4.3+）
  final bool? limitedFederation;

  /// VAPID公開鍵（WebPush通知用）
  @JsonKey(readValue: _readVapidPublicKey)
  final String? vapidPublicKey;
}

/// インスタンスのサムネイル画像情報（`thumbnail`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonInstanceThumbnail {
  const MastodonInstanceThumbnail({required this.url, this.blurhash});

  factory MastodonInstanceThumbnail.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceThumbnailFromJson(json);

  final String url;
  final String? blurhash;
}

/// インスタンスの利用状況（`usage`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonInstanceUsage {
  const MastodonInstanceUsage({required this.activeMonth});

  factory MastodonInstanceUsage.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceUsageFromJson(json);

  static Object? _readActiveMonth(Map<dynamic, dynamic> json, String key) =>
      (json['users'] as Map<String, dynamic>?)?['active_month'];

  /// 過去1ヶ月のアクティブユーザー数
  @JsonKey(readValue: _readActiveMonth, defaultValue: 0)
  final int activeMonth;
}

/// インスタンスの登録設定（`registrations`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonInstanceRegistrations {
  const MastodonInstanceRegistrations({
    required this.enabled,
    required this.approvalRequired,
    this.message,
  });

  factory MastodonInstanceRegistrations.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceRegistrationsFromJson(json);

  /// 新規登録を受け付けているかどうか
  @JsonKey(defaultValue: false)
  final bool enabled;

  /// 管理者による承認が必要かどうか
  @JsonKey(defaultValue: false)
  final bool approvalRequired;

  /// 登録を停止している場合に表示するメッセージ
  final String? message;
}

/// インスタンスの連絡先情報（`contact`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonInstanceContact {
  const MastodonInstanceContact({this.email, this.account});

  factory MastodonInstanceContact.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceContactFromJson(json);

  /// 管理者の連絡先メールアドレス。
  final String? email;

  /// 管理者アカウント。
  final MastodonAccount? account;
}

/// インスタンスの利用規約（`rules`）
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonInstanceRule {
  const MastodonInstanceRule({
    required this.id,
    required this.text,
    this.hint,
  });

  factory MastodonInstanceRule.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceRuleFromJson(json);

  final String id;
  final String text;

  /// 規約の補足説明
  final String? hint;
}

/// Mastodonインスタンスの情報
///
/// `/api/v2/instance`のレスポンスに対応
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
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

  factory MastodonInstance.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceFromJson(json);

  static Object? _readConfiguration(Map<dynamic, dynamic> json, String key) =>
      json['configuration'] ?? const <String, dynamic>{};

  static Object? _readApiVersionMastodon(
    Map<dynamic, dynamic> json,
    String key,
  ) => (json['api_versions'] as Map<dynamic, dynamic>?)?['mastodon'];

  /// インスタンスのドメイン名
  final String domain;

  /// インスタンスのタイトル
  @JsonKey(defaultValue: '')
  final String title;

  /// Mastodonのバージョン文字列（例: `4.3.0`）
  @JsonKey(defaultValue: '')
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
  @JsonKey(readValue: _readConfiguration)
  final MastodonInstanceConfiguration configuration;

  /// 連絡先情報（管理者メールアドレスとアカウント）
  final MastodonInstanceContact? contact;

  /// 新規登録に関する設定
  final MastodonInstanceRegistrations? registrations;

  /// インスタンスが対応している言語コードのリスト
  final List<String>? languages;

  /// インスタンスの利用規約リスト
  @JsonKey(defaultValue: <MastodonInstanceRule>[])
  final List<MastodonInstanceRule> rules;

  /// MastodonAPI バージョン番号（`api_versions.mastodon`）
  @JsonKey(readValue: _readApiVersionMastodon)
  final int? apiVersionMastodon;
}
