import 'package:json_annotation/json_annotation.dart';

import 'mastodon_account.dart';

part 'mastodon_familiar_followers.g.dart';

/// 指定アカウントをフォローしている、自分がフォロー中のアカウントの一覧
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonFamiliarFollowers {
  /// 各フィールドを指定して [MastodonFamiliarFollowers] を生成する
  const MastodonFamiliarFollowers({
    required this.id,
    required this.accounts,
  });

  /// JSON マップから [MastodonFamiliarFollowers] を生成する
  factory MastodonFamiliarFollowers.fromJson(Map<String, dynamic> json) =>
      _$MastodonFamiliarFollowersFromJson(json);

  /// 対象アカウントの ID
  final String id;

  /// 自分がフォローしていて、対象アカウントもフォローしているアカウントのリスト
  @JsonKey(defaultValue: <MastodonAccount>[])
  final List<MastodonAccount> accounts;
}
