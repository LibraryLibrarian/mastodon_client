/// A typed definition of a Mastodon Streaming API channel.
sealed class MastodonStream {
  const MastodonStream();

  /// Creates the authenticated user's combined home and notification stream.
  ///
  /// A token limited to `read:statuses` receives home statuses but silently
  /// receives no notifications. Use `read` or `read:notifications` when
  /// notifications are required.
  const factory MastodonStream.user() = _UserStream;

  /// Creates the authenticated user's notification-only stream.
  ///
  /// Subscribing to this together with [MastodonStream.user] delivers each
  /// notification twice. This stream is unnecessary when `user` is active.
  const factory MastodonStream.userNotification() = _UserNotificationStream;

  /// Creates a public timeline stream.
  ///
  /// Set [onlyMedia] to select the corresponding `public:*:media` channel.
  /// The WebSocket server ignores an `only_media` parameter, so media-only
  /// behavior must be represented by the channel name.
  ///
  /// Public updates may be silently filtered by language preferences, feed
  /// access settings, blocks, or mutes. An idle stream is not necessarily a
  /// client error.
  const factory MastodonStream.public({
    bool local,
    bool remote,
    bool onlyMedia,
  }) = _PublicStream;

  /// Creates a hashtag timeline stream.
  ///
  /// Hashtag updates may be silently filtered by language preferences, feed
  /// access settings, blocks, or mutes.
  const factory MastodonStream.hashtag(String tag, {bool local}) =
      _HashtagStream;

  /// Creates a list timeline stream.
  const factory MastodonStream.list(String listId) = _ListStream;

  /// Creates the authenticated user's direct conversation stream.
  const factory MastodonStream.direct() = _DirectStream;

  /// Wire-format channel name, such as `public:local:media`.
  String get name;

  /// Parameters sent alongside `stream` in subscription frames.
  Map<String, String> get params;

  /// Normalized key used for reference counting and inbound routing.
  String get key;
}

final class _UserStream extends MastodonStream {
  const _UserStream();

  @override
  String get name => 'user';

  @override
  Map<String, String> get params => const {};

  @override
  String get key => name;
}

final class _UserNotificationStream extends MastodonStream {
  const _UserNotificationStream();

  @override
  String get name => 'user:notification';

  @override
  Map<String, String> get params => const {};

  @override
  String get key => name;
}

final class _PublicStream extends MastodonStream {
  const _PublicStream({
    this.local = false,
    this.remote = false,
    this.onlyMedia = false,
  }) : assert(!local || !remote, 'local and remote cannot both be true');

  final bool local;
  final bool remote;
  final bool onlyMedia;

  @override
  String get name {
    final parts = <String>['public'];
    if (local) {
      parts.add('local');
    } else if (remote) {
      parts.add('remote');
    }
    if (onlyMedia) {
      parts.add('media');
    }
    return parts.join(':');
  }

  @override
  Map<String, String> get params => const {};

  @override
  String get key => name;
}

final class _HashtagStream extends MastodonStream {
  const _HashtagStream(this.tag, {this.local = false})
    : assert(tag != '', 'tag must not be empty');

  final String tag;
  final bool local;

  @override
  String get name => local ? 'hashtag:local' : 'hashtag';

  @override
  Map<String, String> get params => {'tag': tag};

  @override
  String get key => '$name:${tag.toLowerCase()}';
}

final class _ListStream extends MastodonStream {
  const _ListStream(this.listId)
    : assert(listId != '', 'listId must not be empty');

  final String listId;

  @override
  String get name => 'list';

  @override
  Map<String, String> get params => {'list': listId};

  @override
  String get key => '$name:$listId';
}

final class _DirectStream extends MastodonStream {
  const _DirectStream();

  @override
  String get name => 'direct';

  @override
  Map<String, String> get params => const {};

  @override
  String get key => name;
}
