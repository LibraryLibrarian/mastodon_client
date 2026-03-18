import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_email_domain_block.g.dart';

/// Admin-level email domain block information.
///
/// Information about an email domain that is blocked from signing up.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminEmailDomainBlock {
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
  final String id;

  /// Email domain that is blocked from signing up.
  final String domain;

  /// Timestamp when the domain was blocked.
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// Recent daily usage statistics.
  @JsonKey(defaultValue: <MastodonAdminEmailDomainBlockHistory>[])
  final List<MastodonAdminEmailDomainBlockHistory> history;
}

/// Daily usage statistics for an email domain block.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminEmailDomainBlockHistory {
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
  final String day;

  /// Number of account registration attempts on that day (string).
  final String accounts;

  /// Number of IP registration attempts on that day (string).
  final String uses;
}
