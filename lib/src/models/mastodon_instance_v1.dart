import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_instance.dart';

part 'mastodon_instance_v1.g.dart';

/// v1 インスタンスのURL設定
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1Urls {
  const MastodonInstanceV1Urls({this.streamingApi});

  factory MastodonInstanceV1Urls.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceV1UrlsFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonInstanceV1UrlsToJson(this);

  /// WebSocket ストリーミング API の接続先 URL
  final String? streamingApi;
}

/// v1 インスタンスの統計情報
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1Stats {
  const MastodonInstanceV1Stats({
    required this.userCount,
    required this.statusCount,
    required this.domainCount,
  });

  factory MastodonInstanceV1Stats.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceV1StatsFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonInstanceV1StatsToJson(this);

  /// 登録ユーザー数
  @JsonKey(defaultValue: 0)
  final int userCount;

  /// 投稿数
  @JsonKey(defaultValue: 0)
  final int statusCount;

  /// 認識済みドメイン数
  @JsonKey(defaultValue: 0)
  final int domainCount;
}

/// v1 インスタンスの設定情報
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1Configuration {
  const MastodonInstanceV1Configuration({
    this.statuses,
    this.mediaAttachments,
    this.polls,
  });

  factory MastodonInstanceV1Configuration.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonInstanceV1ConfigurationFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() =>
      _$MastodonInstanceV1ConfigurationToJson(this);

  /// 投稿制限設定
  final MastodonStatusesConfiguration? statuses;

  /// メディア添付制限設定
  final MastodonMediaConfiguration? mediaAttachments;

  /// 投票制限設定
  final MastodonPollsConfiguration? polls;
}

/// Mastodon インスタンスの v1 形式情報
///
/// `/api/v1/instance` のレスポンスに対応する。
///
/// **非推奨**: Mastodon 4.0.0 以降は [MastodonInstance]（v2）を使用すること。
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceV1 {
  const MastodonInstanceV1({
    required this.uri,
    required this.title,
    required this.version,
    required this.rules,
    this.shortDescription,
    this.description,
    this.email,
    this.urls,
    this.stats,
    this.thumbnail,
    this.languages,
    required this.registrations,
    required this.approvalRequired,
    required this.invitesEnabled,
    this.configuration,
    this.contactAccount,
  });

  factory MastodonInstanceV1.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceV1FromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonInstanceV1ToJson(this);

  /// サーバーのドメイン
  final String uri;

  /// サーバーの名前
  @JsonKey(defaultValue: '')
  final String title;

  /// サーバーの短い説明文
  final String? shortDescription;

  /// サーバーの詳細な説明文
  final String? description;

  /// 管理者の連絡先メールアドレス
  final String? email;

  /// Mastodon のバージョン文字列
  @JsonKey(defaultValue: '')
  final String version;

  /// URL 設定（ストリーミング API URL を含む）
  final MastodonInstanceV1Urls? urls;

  /// インスタンスの統計情報
  final MastodonInstanceV1Stats? stats;

  /// サーバーのサムネイル画像 URL
  final String? thumbnail;

  /// 対応言語コードのリスト
  final List<String>? languages;

  /// 新規登録を受け付けているかどうか
  @JsonKey(defaultValue: false)
  final bool registrations;

  /// 登録に管理者の承認が必要かどうか
  @JsonKey(defaultValue: false)
  final bool approvalRequired;

  /// 招待が有効かどうか（Mastodon 3.1.4+）
  @JsonKey(defaultValue: false)
  final bool invitesEnabled;

  /// サーバーの各種制限設定（Mastodon 3.4.2+）
  final MastodonInstanceV1Configuration? configuration;

  /// 管理者のアカウント情報
  final MastodonAccount? contactAccount;

  /// サーバーのルール（Mastodon 3.4.0+）
  @JsonKey(defaultValue: <MastodonInstanceRule>[])
  final List<MastodonInstanceRule> rules;
}
