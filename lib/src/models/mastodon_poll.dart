import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_custom_emoji.dart';

part 'mastodon_poll.g.dart';

/// 投票の選択肢
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonPollOption {
  const MastodonPollOption({
    required this.title,
    this.votesCount,
  });

  factory MastodonPollOption.fromJson(Map<String, dynamic> json) =>
      _$MastodonPollOptionFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonPollOptionToJson(this);

  /// 選択肢のテキスト
  final String title;

  /// この選択肢への投票数 非公開投票ではnull
  final int? votesCount;
}

/// Mastodonの投票
@JsonSerializable(fieldRename: FieldRename.snake)
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

  factory MastodonPoll.fromJson(Map<String, dynamic> json) =>
      _$MastodonPollFromJson(json);

  /// JSON シリアライズ
  Map<String, dynamic> toJson() => _$MastodonPollToJson(this);

  /// 投票の内部ID
  final String id;

  /// 投票の締め切り日時
  @SafeDateTimeConverter()
  final DateTime? expiresAt;

  /// 投票が終了しているかどうか
  @JsonKey(defaultValue: false)
  final bool expired;

  /// 複数選択可能かどうか
  @JsonKey(defaultValue: false)
  final bool multiple;

  /// 総投票数
  @JsonKey(defaultValue: 0)
  final int votesCount;

  /// 投票に参加したユーザー数（複数選択可の場合はvotesCountと異なる）
  final int? votersCount;

  /// 選択肢のリスト
  final List<MastodonPollOption> options;

  /// 投票に含まれるカスタム絵文字のリスト
  @JsonKey(defaultValue: <MastodonCustomEmoji>[])
  final List<MastodonCustomEmoji> emojis;

  /// 自分が投票済みかどうか
  final bool? voted;

  /// 自分が投票した選択肢のインデックスリスト
  final List<int>? ownVotes;
}
