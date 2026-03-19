import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_notification_group.dart';
import 'mastodon_partial_account.dart';
import 'mastodon_status.dart';

part 'mastodon_grouped_notifications_results.g.dart';

/// Response from the grouped notifications API.
///
/// Model corresponding to the response from `/api/v2/notifications`.
/// Returns notification groups, related accounts, and related statuses
/// together.
@JsonSerializable(fieldRename: FieldRename.snake)
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

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonGroupedNotificationsResultsToJson(this);

  /// List of accounts related to the notifications.
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;

  /// List of partial account information.
  ///
  /// Used when `expand_accounts=partial_avatars` is specified.
  @JsonKey(defaultValue: <MastodonPartialAccount>[])
  final List<MastodonPartialAccount> partialAccounts;

  /// List of statuses related to the notifications.
  @JsonKey(defaultValue: <MastodonStatus>[])
  final List<MastodonStatus> statuses;

  /// List of notification groups.
  @JsonKey(defaultValue: <MastodonNotificationGroup>[])
  final List<MastodonNotificationGroup> notificationGroups;
}
