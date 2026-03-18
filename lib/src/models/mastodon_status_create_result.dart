import 'mastodon_scheduled_status.dart';
import 'mastodon_status.dart';

/// Sealed class representing the response from the status creation API.
///
/// Returns [MastodonStatusCreated] (holding a [MastodonStatus]) for immediate
/// posts, or [MastodonStatusScheduled] (holding a [MastodonScheduledStatus])
/// for scheduled posts (when `scheduled_at` is specified).
sealed class MastodonStatusCreateResult {
  /// Base constructor for the sealed class.
  const MastodonStatusCreateResult();
}

/// Result of an immediate post.
///
/// Response when the server publishes the status immediately.
class MastodonStatusCreated extends MastodonStatusCreateResult {
  /// Creates with the published [status].
  const MastodonStatusCreated(this.status);

  /// Published status.
  final MastodonStatus status;
}

/// Result of a scheduled post.
///
/// Response when `scheduled_at` is specified.
/// The server returns a [MastodonScheduledStatus].
class MastodonStatusScheduled extends MastodonStatusCreateResult {
  /// Creates with the [scheduledStatus] information.
  const MastodonStatusScheduled(this.scheduledStatus);

  /// Scheduled status information.
  final MastodonScheduledStatus scheduledStatus;
}
