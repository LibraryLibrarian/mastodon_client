import 'package:json_annotation/json_annotation.dart';
import '../json_converters.dart';

part 'mastodon_admin_domain_allow.g.dart';

/// Admin-level domain allow information.
///
/// Represents a domain that is allowed to federate.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminDomainAllow {
  const MastodonAdminDomainAllow({
    required this.id,
    required this.domain,
    this.createdAt,
  });

  factory MastodonAdminDomainAllow.fromJson(Map<String, dynamic> json) =>
      _$MastodonAdminDomainAllowFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonAdminDomainAllowToJson(this);

  /// Database ID of the domain allow entry.
  final String id;

  /// Domain that is allowed to federate.
  final String domain;

  /// Timestamp when the domain was allowed.
  @SafeDateTimeConverter()
  final DateTime? createdAt;
}
