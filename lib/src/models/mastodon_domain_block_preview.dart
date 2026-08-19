import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_domain_block_preview.freezed.dart';
part 'mastodon_domain_block_preview.g.dart';

/// Impact of blocking a domain for the authenticated account.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonDomainBlockPreview with _$MastodonDomainBlockPreview {
  const MastodonDomainBlockPreview({
    required this.followingCount,
    required this.followersCount,
  });

  factory MastodonDomainBlockPreview.fromJson(Map<String, dynamic> json) =>
      _$MastodonDomainBlockPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$MastodonDomainBlockPreviewToJson(this);

  @JsonKey(defaultValue: 0)
  @override
  final int followingCount;

  @JsonKey(defaultValue: 0)
  @override
  final int followersCount;
}
