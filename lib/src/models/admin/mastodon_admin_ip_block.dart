import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_ip_block.g.dart';

/// Severity level of an IP block.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonAdminIpBlockSeverity {
  /// Sign-up requires approval.
  signUpRequiresApproval,

  /// Sign-up is blocked.
  signUpBlock,

  /// All access is denied.
  noAccess,
}

/// Admin-level IP block information.
///
/// Information about a blocked IP address range.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminIpBlock {
  const MastodonAdminIpBlock({
    required this.id,
    required this.ip,
    required this.severity,
    this.comment,
    this.createdAt,
    this.expiresAt,
  });

  factory MastodonAdminIpBlock.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminIpBlockFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminIpBlockToJson(this);

  /// Database ID of the IP block.
  final String id;

  /// Blocked IP address range (CIDR notation).
  final String ip;

  /// Severity level of the block.
  @JsonKey(unknownEnumValue: MastodonAdminIpBlockSeverity.signUpBlock)
  final MastodonAdminIpBlockSeverity severity;

  /// Reason for the block.
  @JsonKey(defaultValue: '')
  final String? comment;

  /// Timestamp when the block was created.
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// Expiration timestamp of the block (null if permanent).
  @SafeDateTimeConverter()
  final DateTime? expiresAt;
}
