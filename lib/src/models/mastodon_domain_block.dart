import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_domain_block.freezed.dart';
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
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonDomainBlock with _$MastodonDomainBlock {
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
  @override
  final String domain;

  /// SHA256 hash digest of the domain string.
  @override
  final String digest;

  /// Severity level of the block.
  @JsonKey(unknownEnumValue: MastodonDomainBlockSeverity.unknown)
  @override
  final MastodonDomainBlockSeverity severity;

  /// Reason for the domain block (optional).
  @override
  final String? comment;
}
