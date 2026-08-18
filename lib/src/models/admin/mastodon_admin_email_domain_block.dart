import 'package:freezed_annotation/freezed_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_email_domain_block.freezed.dart';
part 'mastodon_admin_email_domain_block.g.dart';

/// Admin-level email domain block information.
///
/// Information about an email domain that is blocked from signing up.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminEmailDomainBlock with _$MastodonAdminEmailDomainBlock {
  const MastodonAdminEmailDomainBlock({
    required this.id,
    required this.domain,
    this.createdAt,
    this.history = const [],
  });

  factory MastodonAdminEmailDomainBlock.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminEmailDomainBlockFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminEmailDomainBlockToJson(this);

  /// Database ID of the block.
  @override
  final String id;

  /// Email domain that is blocked from signing up.
  @override
  final String domain;

  /// Timestamp when the domain was blocked.
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;

  /// Recent daily usage statistics.
  @JsonKey(defaultValue: <MastodonAdminEmailDomainBlockHistory>[])
  @override
  final List<MastodonAdminEmailDomainBlockHistory> history;
}

/// Daily usage statistics for an email domain block.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminEmailDomainBlockHistory
    with _$MastodonAdminEmailDomainBlockHistory {
  const MastodonAdminEmailDomainBlockHistory({
    required this.day,
    required this.accounts,
    required this.uses,
  });

  factory MastodonAdminEmailDomainBlockHistory.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonAdminEmailDomainBlockHistoryFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonAdminEmailDomainBlockHistoryToJson(this);

  /// UNIX timestamp at midnight of the day (string).
  @override
  final String day;

  /// Number of account registration attempts on that day (string).
  @override
  final String accounts;

  /// Number of IP registration attempts on that day (string).
  @override
  final String uses;
}
