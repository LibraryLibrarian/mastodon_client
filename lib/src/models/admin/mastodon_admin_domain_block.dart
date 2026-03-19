import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_domain_block.g.dart';

/// Severity level of an admin domain block.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonAdminDomainBlockSeverity {
  /// Silence (hide from timelines and notifications).
  silence,

  /// Suspend (reject all communications).
  suspend,

  /// No operation.
  noop,
}

/// Admin-level domain block information.
///
/// Detailed information about a domain that is blocked from federation.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminDomainBlock {
  const MastodonAdminDomainBlock({
    required this.id,
    required this.domain,
    required this.digest,
    required this.severity,
    this.rejectMedia = false,
    this.rejectReports = false,
    this.privateComment,
    this.publicComment,
    this.obfuscate = false,
    this.createdAt,
  });

  factory MastodonAdminDomainBlock.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminDomainBlockFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminDomainBlockToJson(this);

  /// Database ID of the domain block.
  final String id;

  /// Blocked domain.
  final String domain;

  /// SHA256 digest of the domain.
  final String digest;

  /// Severity level of the block.
  @JsonKey(unknownEnumValue: MastodonAdminDomainBlockSeverity.silence)
  final MastodonAdminDomainBlockSeverity severity;

  /// Whether to reject media attachments.
  @JsonKey(defaultValue: false)
  final bool rejectMedia;

  /// Whether to reject reports.
  @JsonKey(defaultValue: false)
  final bool rejectReports;

  /// Private comment for administrators.
  final String? privateComment;

  /// Public-facing comment.
  final String? publicComment;

  /// Whether to obfuscate the domain name in public displays.
  @JsonKey(defaultValue: false)
  final bool obfuscate;

  /// Timestamp when the domain was blocked.
  @SafeDateTimeConverter()
  final DateTime? createdAt;
}
