import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_admin_canonical_email_block.freezed.dart';
part 'mastodon_admin_canonical_email_block.g.dart';

/// Admin-level canonical email block information.
///
/// Block information based on the hash of a canonicalized email address.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonAdminCanonicalEmailBlock with _$MastodonAdminCanonicalEmailBlock {
  const MastodonAdminCanonicalEmailBlock({
    required this.id,
    required this.canonicalEmailHash,
  });

  factory MastodonAdminCanonicalEmailBlock.fromJson(
    Map<String, dynamic> json,
  ) => _$MastodonAdminCanonicalEmailBlockFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() =>
      _$MastodonAdminCanonicalEmailBlockToJson(this);

  /// Database ID of the block.
  @override
  final String id;

  /// SHA256 hash of the canonicalized email address.
  @override
  final String canonicalEmailHash;
}
