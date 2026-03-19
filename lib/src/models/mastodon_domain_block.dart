import 'package:json_annotation/json_annotation.dart';

part 'mastodon_domain_block.g.dart';

/// Severity level of a domain block.
@JsonEnum(fieldRename: FieldRename.snake)
enum MastodonDomainBlockSeverity {
  /// Hides users from the blocked domain from timelines and notifications.
  silence,

  /// Rejects and discards all messages from the blocked domain.
  suspend,

  /// Unknown or future severity level.
  unknown,
}

/// Information about a domain blocked by the instance.
///
/// `GET /api/v1/instance/domain_blocks`
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonDomainBlock {
  const MastodonDomainBlock({
    required this.domain,
    required this.digest,
    required this.severity,
    this.comment,
  });

  factory MastodonDomainBlock.fromJson(Map<String, dynamic> json) =>
      _$MastodonDomainBlockFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonDomainBlockToJson(this);

  /// Domain name that is blocked.
  final String domain;

  /// SHA256 hash digest of the domain string.
  final String digest;

  /// Severity level of the block.
  @JsonKey(unknownEnumValue: MastodonDomainBlockSeverity.unknown)
  final MastodonDomainBlockSeverity severity;

  /// Reason for the domain block (optional).
  final String? comment;
}
