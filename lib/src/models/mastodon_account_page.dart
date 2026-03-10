import 'mastodon_account.dart';

/// フォロワー・フォロー中などのアカウント一覧と次ページカーソルをまとめた結果
class MastodonAccountPage {
  /// [accounts] に取得したアカウント一覧、[nextMaxId] に次ページカーソルを指定する
  const MastodonAccountPage({required this.accounts, this.nextMaxId});

  /// 取得したアカウントの一覧
  final List<MastodonAccount> accounts;

  /// 次ページ取得に使用する `max_id` カーソル。次ページが存在しない場合は `null`
  final String? nextMaxId;
}
