import 'mastodon_account.dart';

/// 指定アカウントをフォローしている、自分がフォロー中のアカウントの一覧
class MastodonFamiliarFollowers {
  /// 各フィールドを指定して [MastodonFamiliarFollowers] を生成する
  const MastodonFamiliarFollowers({
    required this.id,
    required this.accounts,
  });

  /// JSON マップから [MastodonFamiliarFollowers] を生成する
  factory MastodonFamiliarFollowers.fromJson(Map<String, dynamic> json) {
    return MastodonFamiliarFollowers(
      id: json['id'] as String,
      accounts:
          (json['accounts'] as List<dynamic>?)
              ?.cast<Map<String, dynamic>>()
              .map(MastodonAccount.fromJson)
              .toList() ??
          [],
    );
  }

  /// 対象アカウントの ID
  final String id;

  /// 自分がフォローしていて、対象アカウントもフォローしているアカウントのリスト
  final List<MastodonAccount> accounts;
}
