import 'mastodon_scheduled_status.dart';
import 'mastodon_status.dart';

/// ステータス作成APIのレスポンスを表す sealed class
///
/// 即時投稿の場合は [MastodonStatusCreated]（[MastodonStatus] を保持）、
/// 予約投稿（`scheduled_at` 指定時）の場合は [MastodonStatusScheduled]
/// （[MastodonScheduledStatus] を保持）が返る。
sealed class MastodonStatusCreateResult {
  /// sealed class の基底コンストラクタ
  const MastodonStatusCreateResult();
}

/// 即時投稿の結果
///
/// サーバーがステータスを即座に公開した場合のレスポンス。
class MastodonStatusCreated extends MastodonStatusCreateResult {
  /// [status] に公開されたステータスを指定して生成する
  const MastodonStatusCreated(this.status);

  /// 公開されたステータス
  final MastodonStatus status;
}

/// 予約投稿の結果
///
/// `scheduled_at` を指定した場合のレスポンス。
/// サーバーは [MastodonScheduledStatus] を返す。
class MastodonStatusScheduled extends MastodonStatusCreateResult {
  /// [scheduledStatus] に予約投稿情報を指定して生成する
  const MastodonStatusScheduled(this.scheduledStatus);

  /// 予約投稿情報
  final MastodonScheduledStatus scheduledStatus;
}
