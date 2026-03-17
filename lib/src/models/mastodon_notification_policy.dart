import 'package:json_annotation/json_annotation.dart';

part 'mastodon_notification_policy.g.dart';

/// 通知ポリシーのフィルタリングアクション
///
/// 各通知カテゴリに対して適用される処理を表す。
@JsonEnum(fieldRename: FieldRename.snake)
enum NotificationFilterAction {
  /// 通知を受け入れる
  accept,

  /// 通知をフィルタリングする（通知リクエストに振り分ける）
  filter,

  /// 通知を破棄する
  drop,
}

/// 通知ポリシーのサマリー
///
/// フィルタリングされた通知の統計情報を保持
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationPolicySummary {
  const MastodonNotificationPolicySummary({
    required this.pendingRequestsCount,
    required this.pendingNotificationsCount,
  });

  factory MastodonNotificationPolicySummary.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonNotificationPolicySummaryFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() =>
      _$MastodonNotificationPolicySummaryToJson(this);

  /// 未処理の通知リクエスト数（最大 100）
  @JsonKey(defaultValue: 0)
  final int pendingRequestsCount;

  /// 未処理のフィルタリング済み通知の総数
  @JsonKey(defaultValue: 0)
  final int pendingNotificationsCount;
}

/// Mastodon の通知ポリシー（Mastodon 4.3+）
///
/// `/api/v2/notifications/policy`
///
/// 各カテゴリの通知に対するフィルタリングルールを保持
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonNotificationPolicy {
  const MastodonNotificationPolicy({
    required this.forNotFollowing,
    required this.forNotFollowers,
    required this.forNewAccounts,
    required this.forPrivateMentions,
    required this.forLimitedAccounts,
    this.summary,
  });

  factory MastodonNotificationPolicy.fromJson(Map<String, dynamic> json) =>
      _$MastodonNotificationPolicyFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonNotificationPolicyToJson(this);

  /// フォローしていないアカウントからの通知に対するアクション
  @JsonKey(
    name: 'for_not_following',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forNotFollowing;

  /// フォロワーでないアカウントからの通知に対するアクション
  @JsonKey(
    name: 'for_not_followers',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forNotFollowers;

  /// 作成から 30 日未満のアカウントからの通知に対するアクション
  @JsonKey(
    name: 'for_new_accounts',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forNewAccounts;

  /// プライベートメンションの通知に対するアクション
  @JsonKey(
    name: 'for_private_mentions',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forPrivateMentions;

  /// モデレーターにより制限されたアカウントからの通知に対するアクション
  @JsonKey(
    name: 'for_limited_accounts',
    unknownEnumValue: NotificationFilterAction.accept,
  )
  final NotificationFilterAction forLimitedAccounts;

  /// フィルタリング済み通知のサマリー
  final MastodonNotificationPolicySummary? summary;
}
