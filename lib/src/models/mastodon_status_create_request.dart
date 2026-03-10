import 'mastodon_status.dart';

/// 投稿作成時のアンケートパラメーター
class MastodonPollCreateRequest {
  /// 投稿作成時のアンケートパラメーターを生成
  const MastodonPollCreateRequest({
    required this.options,
    required this.expiresIn,
    this.multiple = false,
  });

  /// 選択肢の一覧
  final List<String> options;

  /// 投票期限（秒）
  final int expiresIn;

  /// 複数選択を許可するか否か
  final bool multiple;
}

/// 投稿作成リクエストのパラメーター
class MastodonStatusCreateRequest {
  /// 投稿作成リクエストのパラメーターを生成
  const MastodonStatusCreateRequest({
    this.status,
    this.mediaIds,
    this.inReplyToId,
    this.visibility = MastodonVisibility.public,
    this.sensitive = false,
    this.spoilerText,
    this.poll,
    this.quotedStatusId,
    this.quoteApprovalPolicy,
    this.language,
  });

  /// 投稿本文
  final String? status;

  /// 添付メディアのIDリスト
  final List<String>? mediaIds;

  /// 返信先の投稿ID
  final String? inReplyToId;

  /// 投稿の公開範囲
  final MastodonVisibility visibility;

  /// センシティブコンテンツとしてマークするか否か
  final bool sensitive;

  /// コンテンツ警告（CW）テキスト
  final String? spoilerText;

  /// アンケートのパラメーター
  final MastodonPollCreateRequest? poll;

  /// 引用する投稿のID（標準Mastodon FEP-044f）
  ///
  /// `quoted_status_id` としてリクエストに含まれる。
  final String? quotedStatusId;

  /// 引用の承認ポリシー（標準Mastodon FEP-044f）
  ///
  /// `quote_approval_policy` としてリクエストに含まれる。
  final String? quoteApprovalPolicy;

  /// 投稿言語コード（ISO 639-1形式）
  final String? language;

  /// リクエストボディ用のJSONマップを返す
  Map<String, dynamic> toJson() {
    final visibilityString = switch (visibility) {
      MastodonVisibility.public => 'public',
      MastodonVisibility.unlisted => 'unlisted',
      MastodonVisibility.private => 'private',
      MastodonVisibility.direct => 'direct',
    };

    final map = <String, dynamic>{
      'visibility': visibilityString,
      'sensitive': sensitive,
    };

    if (status != null) {
      map['status'] = status;
    }
    if (mediaIds != null) {
      map['media_ids'] = mediaIds;
    }
    if (inReplyToId != null) {
      map['in_reply_to_id'] = inReplyToId;
    }
    if (spoilerText != null) {
      map['spoiler_text'] = spoilerText;
    }
    if (poll != null) {
      map['poll'] = <String, dynamic>{
        'options': poll!.options,
        'expires_in': poll!.expiresIn,
        'multiple': poll!.multiple,
      };
    }
    if (quotedStatusId != null) {
      map['quoted_status_id'] = quotedStatusId;
    }
    if (quoteApprovalPolicy != null) {
      map['quote_approval_policy'] = quoteApprovalPolicy;
    }
    if (language != null) {
      map['language'] = language;
    }

    return map;
  }
}
