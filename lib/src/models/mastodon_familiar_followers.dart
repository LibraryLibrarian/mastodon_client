import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';

part 'mastodon_familiar_followers.g.dart';

/// List of accounts you follow that also follow the specified account.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonFamiliarFollowers {
  /// Creates a [MastodonFamiliarFollowers] with the given fields.
  const MastodonFamiliarFollowers({
    required this.id,
    required this.accounts,
  });

  /// Creates a [MastodonFamiliarFollowers] from a JSON map.
  factory MastodonFamiliarFollowers.fromJson(Map<String, dynamic> json) =>
      _$MastodonFamiliarFollowersFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonFamiliarFollowersToJson(this);

  /// ID of the target account.
  final String id;

  /// List of accounts you follow that also follow the target account.
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;
}
