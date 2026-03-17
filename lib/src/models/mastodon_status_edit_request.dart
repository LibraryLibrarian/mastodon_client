/// 投稿編集時のメディア属性パラメーター
class MastodonMediaAttributeRequest {
  /// 投稿編集時のメディア属性パラメーターを生成する
  const MastodonMediaAttributeRequest({
    required this.id,
    this.description,
    this.focus,
  });

  /// メディアの内部ID
  final String id;

  /// 代替テキスト（スクリーンリーダー用）
  final String? description;

  /// フォーカルポイント（`x,y` 形式、各値は -1.0 から 1.0）
  final String? focus;
}

/// 投稿編集時のアンケートパラメーター
class MastodonPollEditRequest {
  /// 投稿編集時のアンケートパラメーターを生成する
  const MastodonPollEditRequest({
    required this.options,
    required this.expiresIn,
    this.multiple = false,
    this.hideTotals = false,
  });

  /// 選択肢の一覧。
  final List<String> options;

  /// 投票期限（秒）
  final int expiresIn;

  /// 複数選択を許可するか否か
  final bool multiple;

  /// 投票結果の総数を非表示にするか否か
  final bool hideTotals;
}

/// 投稿編集リクエストのパラメーター
///
/// `PUT /api/v1/statuses/:id` のリクエストボディに対応する。
class MastodonStatusEditRequest {
  /// 投稿編集リクエストのパラメーターを生成する
  const MastodonStatusEditRequest({
    this.status,
    this.spoilerText,
    this.sensitive,
    this.language,
    this.mediaIds,
    this.mediaAttributes,
    this.poll,
    this.quoteApprovalPolicy,
  });

  /// 投稿本文
  final String? status;

  /// コンテンツ警告（CW）テキスト
  final String? spoilerText;

  /// センシティブコンテンツとしてマークするか否か
  final bool? sensitive;

  /// 投稿言語コード（ISO 639-1形式）
  final String? language;

  /// 添付メディアのIDリスト
  final List<String>? mediaIds;

  /// 各メディアの属性（説明文やフォーカルポイント）
  final List<MastodonMediaAttributeRequest>? mediaAttributes;

  /// アンケートのパラメーター
  final MastodonPollEditRequest? poll;

  /// 引用の承認ポリシー（`public`・`followers`・`nobody`）
  final String? quoteApprovalPolicy;

  /// リクエストボディ用のJSONマップを返す
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (status != null) {
      map['status'] = status;
    }
    if (spoilerText != null) {
      map['spoiler_text'] = spoilerText;
    }
    if (sensitive != null) {
      map['sensitive'] = sensitive;
    }
    if (language != null) {
      map['language'] = language;
    }
    if (mediaIds != null) {
      map['media_ids'] = mediaIds;
    }
    if (mediaAttributes != null) {
      map['media_attributes'] = mediaAttributes!
          .map(
            (a) => <String, dynamic>{
              'id': a.id,
              if (a.description != null) 'description': a.description,
              if (a.focus != null) 'focus': a.focus,
            },
          )
          .toList();
    }
    if (poll != null) {
      map['poll'] = <String, dynamic>{
        'options': poll!.options,
        'expires_in': poll!.expiresIn,
        'multiple': poll!.multiple,
        'hide_totals': poll!.hideTotals,
      };
    }
    if (quoteApprovalPolicy != null) {
      map['quote_approval_policy'] = quoteApprovalPolicy;
    }

    return map;
  }
}
