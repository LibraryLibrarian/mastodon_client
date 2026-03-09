import 'mastodon_custom_emoji.dart';

/// 投票の選択肢
class MastodonPollOption {
  const MastodonPollOption({
    required this.title,
    this.votesCount,
  });

  factory MastodonPollOption.fromJson(Map<String, dynamic> json) {
    return MastodonPollOption(
      title: json['title'] as String,
      votesCount: json['votes_count'] as int?,
    );
  }

  /// 選択肢のテキスト
  final String title;

  /// この選択肢への投票数 非公開投票ではnull
  final int? votesCount;
}

/// Mastodonの投票
class MastodonPoll {
  const MastodonPoll({
    required this.id,
    required this.expired,
    required this.multiple,
    required this.votesCount,
    required this.options,
    required this.emojis,
    this.expiresAt,
    this.votersCount,
    this.voted,
    this.ownVotes,
  });

  factory MastodonPoll.fromJson(Map<String, dynamic> json) {
    return MastodonPoll(
      id: json['id'] as String,
      expiresAt: json['expires_at'] != null
          ? DateTime.tryParse(json['expires_at'] as String)
          : null,
      expired: json['expired'] as bool? ?? false,
      multiple: json['multiple'] as bool? ?? false,
      votesCount: json['votes_count'] as int? ?? 0,
      votersCount: json['voters_count'] as int?,
      options: (json['options'] as List<dynamic>)
          .map((o) => MastodonPollOption.fromJson(o as Map<String, dynamic>))
          .toList(),
      emojis:
          (json['emojis'] as List<dynamic>?)
              ?.map(
                (e) => MastodonCustomEmoji.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      voted: json['voted'] as bool?,
      ownVotes: (json['own_votes'] as List<dynamic>?)
          ?.map((v) => v as int)
          .toList(),
    );
  }

  /// 投票の内部ID
  final String id;

  /// 投票の締め切り日時
  final DateTime? expiresAt;

  /// 投票が終了しているかどうか
  final bool expired;

  /// 複数選択可能かどうか
  final bool multiple;

  /// 総投票数
  final int votesCount;

  /// 投票に参加したユーザー数（複数選択可の場合はvotesCountと異なる）
  final int? votersCount;

  /// 選択肢のリスト
  final List<MastodonPollOption> options;

  /// 投票に含まれるカスタム絵文字のリスト
  final List<MastodonCustomEmoji> emojis;

  /// 自分が投票済みかどうか
  final bool? voted;

  /// 自分が投票した選択肢のインデックスリスト
  final List<int>? ownVotes;
}
