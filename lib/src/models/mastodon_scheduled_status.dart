import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';
import 'mastodon_media_attachment.dart';

part 'mastodon_scheduled_status.g.dart';

/// 予約投稿を表すモデル
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonScheduledStatus {
  /// 各フィールドを指定して [MastodonScheduledStatus] を生成する
  const MastodonScheduledStatus({
    required this.id,
    this.scheduledAt,
    this.params,
    this.mediaAttachments = const [],
  });

  /// JSON マップから [MastodonScheduledStatus] を生成する
  factory MastodonScheduledStatus.fromJson(Map<String, dynamic> json) =>
      _$MastodonScheduledStatusFromJson(json);

  /// 予約投稿のデータベース ID
  final String id;

  /// 投稿が公開される予定のタイムスタンプ
  @SafeDateTimeConverter()
  final DateTime? scheduledAt;

  /// 予約時に指定されたステータスのパラメータ
  final MastodonScheduledStatusParams? params;

  /// 投稿に添付されるメディア
  @JsonKey(defaultValue: [])
  final List<MastodonMediaAttachment> mediaAttachments;
}

/// 予約投稿のパラメータ
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonScheduledStatusParams {
  /// 各フィールドを指定して [MastodonScheduledStatusParams] を生成する
  const MastodonScheduledStatusParams({
    required this.text,
    this.poll,
    this.mediaIds,
    this.sensitive,
    this.spoilerText,
    this.visibility,
    this.inReplyToId,
    this.language,
    this.idempotency,
  });

  /// JSON マップから [MastodonScheduledStatusParams] を生成する
  factory MastodonScheduledStatusParams.fromJson(Map<String, dynamic> json) =>
      _$MastodonScheduledStatusParamsFromJson(json);

  /// ステータスの本文テキスト
  @JsonKey(defaultValue: '')
  final String text;

  /// 投票パラメータ（投票なしの場合は `null`）
  final MastodonScheduledStatusPoll? poll;

  /// 添付する MediaAttachment の ID 配列
  final List<String>? mediaIds;

  /// センシティブ（閲覧注意）としてマークするかどうか
  final bool? sensitive;

  /// コンテンツ警告テキスト
  final String? spoilerText;

  /// 公開範囲（`public` / `unlisted` / `private` / `direct`）
  final String? visibility;

  /// 返信先のステータス ID
  final int? inReplyToId;

  /// 投稿言語（ISO 639-1 コード）
  final String? language;

  /// 冪等性キー
  final String? idempotency;
}

/// 予約投稿の投票パラメータ
@JsonSerializable(createToJson: false, fieldRename: FieldRename.snake)
class MastodonScheduledStatusPoll {
  /// 各フィールドを指定して [MastodonScheduledStatusPoll] を生成する
  const MastodonScheduledStatusPoll({
    this.options = const [],
    required this.expiresIn,
    this.multiple,
    this.hideTotals,
  });

  /// JSON マップから [MastodonScheduledStatusPoll] を生成する
  factory MastodonScheduledStatusPoll.fromJson(Map<String, dynamic> json) =>
      _$MastodonScheduledStatusPollFromJson(json);

  /// 投票の選択肢
  @JsonKey(defaultValue: [])
  final List<String> options;

  /// 投票が締め切られるまでの秒数
  final int expiresIn;

  /// 複数選択を許可するかどうか
  final bool? multiple;

  /// 投票終了まで合計票数を非表示にするかどうか
  final bool? hideTotals;
}
