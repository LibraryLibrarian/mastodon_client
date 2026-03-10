import 'mastodon_status.dart';

/// 投稿のコンテキスト（祖先と子孫）
///
/// `GET /api/v1/statuses/{id}/context` のレスポンスに対応する
class MastodonStatusContext {
  const MastodonStatusContext({
    required this.ancestors,
    required this.descendants,
  });

  factory MastodonStatusContext.fromJson(Map<String, dynamic> json) {
    return MastodonStatusContext(
      ancestors: ((json['ancestors'] as List<dynamic>?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(MastodonStatus.fromJson)
          .toList(growable: false),
      descendants: ((json['descendants'] as List<dynamic>?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(MastodonStatus.fromJson)
          .toList(growable: false),
    );
  }

  /// 対象投稿より前の投稿（スレッドの先祖）
  final List<MastodonStatus> ancestors;

  /// 対象投稿への返信ツリー（子孫）
  final List<MastodonStatus> descendants;
}
