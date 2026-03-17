/// プロフィール更新リクエストのパラメーター
///
/// `PATCH /api/v1/accounts/update_credentials` のリクエストボディに対応する。
class MastodonCredentialAccountUpdateRequest {
  /// プロフィール更新リクエストのパラメーターを生成
  const MastodonCredentialAccountUpdateRequest({
    this.displayName,
    this.note,
    this.avatar,
    this.header,
    this.locked,
    this.bot,
    this.discoverable,
    this.hideCollections,
    this.indexable,
    this.fieldsAttributes,
    this.sourcePrivacy,
    this.sourceSensitive,
    this.sourceLanguage,
    this.sourceQuotePolicy,
    this.attributionDomains,
  });

  /// 表示名
  final String? displayName;

  /// プロフィール文
  final String? note;

  /// アバター画像（Base64 エンコードされたデータ URI）
  final String? avatar;

  /// ヘッダー画像（Base64 エンコードされたデータ URI）
  final String? header;

  /// フォロー承認制にするかどうか
  final bool? locked;

  /// Bot アカウントかどうか
  final bool? bot;

  /// ディスカバリー機能への掲載を許可するかどうか
  final bool? discoverable;

  /// フォロー・フォロワー一覧を非公開にするかどうか
  final bool? hideCollections;

  /// 検索エンジンによるインデックスを許可するかどうか
  final bool? indexable;

  /// プロフィールのカスタムフィールド一覧
  final List<MastodonFieldAttribute>? fieldsAttributes;

  /// デフォルトの投稿公開範囲（`public`・`unlisted`・`private`・`direct`）
  final String? sourcePrivacy;

  /// デフォルトでセンシティブフラグを付けるかどうか
  final bool? sourceSensitive;

  /// デフォルトの投稿言語（ISO 639-1 形式）
  final String? sourceLanguage;

  /// デフォルトの引用承認ポリシー（`public`・`followers`・`nobody`）
  final String? sourceQuotePolicy;

  /// 帰属ドメインのリスト
  final List<String>? attributionDomains;

  /// リクエストボディ用の JSON マップを返す
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (displayName != null) map['display_name'] = displayName;
    if (note != null) map['note'] = note;
    if (avatar != null) map['avatar'] = avatar;
    if (header != null) map['header'] = header;
    if (locked != null) map['locked'] = locked;
    if (bot != null) map['bot'] = bot;
    if (discoverable != null) map['discoverable'] = discoverable;
    if (hideCollections != null) map['hide_collections'] = hideCollections;
    if (indexable != null) map['indexable'] = indexable;
    if (attributionDomains != null) {
      map['attribution_domains'] = attributionDomains;
    }
    if (fieldsAttributes != null) {
      map['fields_attributes'] = fieldsAttributes!
          .map(
            (f) => <String, dynamic>{
              'name': f.name,
              'value': f.value,
            },
          )
          .toList();
    }
    if (sourcePrivacy != null ||
        sourceSensitive != null ||
        sourceLanguage != null ||
        sourceQuotePolicy != null) {
      map['source'] = <String, dynamic>{
        if (sourcePrivacy != null) 'privacy': sourcePrivacy,
        if (sourceSensitive != null) 'sensitive': sourceSensitive,
        if (sourceLanguage != null) 'language': sourceLanguage,
        if (sourceQuotePolicy != null) 'quote_policy': sourceQuotePolicy,
      };
    }

    return map;
  }
}

/// プロフィールのカスタムフィールド属性
class MastodonFieldAttribute {
  /// フィールド名と値を指定して生成する
  const MastodonFieldAttribute({
    required this.name,
    required this.value,
  });

  /// フィールドのラベル名
  final String name;

  /// フィールドの値
  final String value;
}
