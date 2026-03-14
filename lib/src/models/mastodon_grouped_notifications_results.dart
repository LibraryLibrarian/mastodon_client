import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_notification_group.dart';
import 'mastodon_partial_account.dart';
import 'mastodon_status.dart';

part 'mastodon_grouped_notifications_results.g.dart';

/// グループ化通知APIのレスポンス
///
/// `/api/v2/notifications` のレスポンスに対応するモデル。
/// 通知グループ・関連アカウント・関連投稿を一括で返す。
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonGroupedNotificationsResults {
  const MastodonGroupedNotificationsResults({
    required this.accounts,
    required this.partialAccounts,
    required this.statuses,
    required this.notificationGroups,
  });

  factory MastodonGroupedNotificationsResults.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonGroupedNotificationsResultsFromJson(json);

  /// 通知に関連するアカウントの一覧
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;

  /// 部分的なアカウント情報の一覧
  ///
  /// `expand_accounts=partial_avatars` を指定した場合に使用される
  @JsonKey(defaultValue: <MastodonPartialAccount>[])
  final List<MastodonPartialAccount> partialAccounts;

  /// 通知に関連する投稿の一覧
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> statuses;

  /// 通知グループの一覧
  @JsonKey(defaultValue: <MastodonNotificationGroup>[])
  final List<MastodonNotificationGroup> notificationGroups;
}
