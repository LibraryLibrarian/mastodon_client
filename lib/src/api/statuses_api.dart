import '../client/mastodon_http_client.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_preview_card.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_status_context.dart';
import '../models/mastodon_status_create_request.dart';
import '../models/mastodon_status_edit.dart';
import '../models/mastodon_status_edit_request.dart';
import '../models/mastodon_status_source.dart';
import '../models/mastodon_translation.dart';

/// 投稿（Status）に関するAPI
class StatusesApi {
  const StatusesApi(this._http);

  final MastodonHttpClient _http;

  /// 投稿を単体取得する
  ///
  /// `GET /api/v1/statuses/{id}`
  ///
  /// - [id]: 取得する投稿のID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatus> fetch(String id) async {
    final data = await _http.send<Map<String, dynamic>>('/api/v1/statuses/$id');
    return MastodonStatus.fromJson(data!);
  }

  /// 複数の投稿をまとめて取得する
  ///
  /// `GET /api/v1/statuses`
  ///
  /// 存在しないIDやアクセスできないIDは返却リストから除外される。
  ///
  /// - [ids]: 取得する投稿のIDリスト
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonStatus>> fetchMultiple(List<String> ids) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/statuses',
      queryParameters: <String, dynamic>{'id[]': ids},
    );
    return (data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
  }

  /// 投稿のコンテキスト（祖先・子孫）を取得する
  ///
  /// `GET /api/v1/statuses/{id}/context`
  ///
  /// - [id]: 対象投稿のID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatusContext> fetchContext(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/context',
    );
    return MastodonStatusContext.fromJson(data!);
  }

  /// 投稿のソース情報を取得する
  ///
  /// `GET /api/v1/statuses/{id}/source`
  ///
  /// 編集画面で使用するプレーンテキストの投稿内容を返す。
  ///
  /// - [id]: 対象投稿のID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatusSource> fetchSource(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/source',
    );
    return MastodonStatusSource.fromJson(data!);
  }

  /// 投稿の編集履歴を取得する
  ///
  /// `GET /api/v1/statuses/{id}/history`
  ///
  /// 初回投稿から現在の状態までの全リビジョンを返す。
  ///
  /// - [id]: 対象投稿のID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonStatusEdit>> fetchHistory(String id) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/statuses/$id/history',
    );
    return (data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonStatusEdit.fromJson)
        .toList();
  }

  /// 投稿のプレビューカードを取得する
  ///
  /// `GET /api/v1/statuses/{id}/card`
  ///
  /// - [id]: 対象投稿のID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonPreviewCard> fetchCard(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/card',
    );
    return MastodonPreviewCard.fromJson(data!);
  }

  /// 指定した投稿を引用している投稿の一覧を取得する
  ///
  /// `GET /api/v1/statuses/{id}/quotes`
  ///
  /// - [id]: 対象投稿のID
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [sinceId]: このIDより新しい投稿のみ取得する
  /// - [maxId]: このIDより古い投稿のみ取得する
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonStatus>> fetchQuotes(
    String id, {
    int? limit,
    String? sinceId,
    String? maxId,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/statuses/$id/quotes',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'since_id': ?sinceId,
        'max_id': ?maxId,
      },
    );
    return (data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
  }

  /// 指定した投稿をブーストする
  ///
  /// `POST /api/v1/statuses/{id}/reblog`
  ///
  /// 返り値は**ブースト投稿（Wrapper）**であり、元投稿とは異なる点に注意。
  ///
  /// - [MastodonStatus.id]: ブースト投稿自体の新しいID（元投稿のIDとは異なる）
  /// - [MastodonStatus.account]: ブーストした自分のアカウント
  /// - [MastodonStatus.createdAt]: ブーストした日時
  /// - [MastodonStatus.content]: 空文字（`""`）
  /// - [MastodonStatus.reblog]: **元投稿がまるごと格納される**（このフィールドが主役）
  ///   - [MastodonStatus.reblog]`.id`: 元投稿のID
  ///   - [MastodonStatus.reblog]`.reblogsCount`: ブースト後の更新済みブースト数
  /// - [MastodonStatus.reblogged]: `true`
  /// - [MastodonStatus.visibility]: [visibility] で指定した公開範囲
  ///
  /// - [id]: ブーストする投稿のID
  /// - [visibility]: ブーストの公開範囲（省略時はサーバーのデフォルト）
  Future<MastodonStatus> boost(String id, {String? visibility}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/reblog',
      method: 'POST',
      data: <String, dynamic>{'visibility': ?visibility},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿のブーストを解除する
  ///
  /// `POST /api/v1/statuses/{id}/unreblog`
  ///
  /// 返り値は[boost]とは異なり**元投稿そのもの**であり、Wrapperではない。
  ///
  /// - [MastodonStatus.id]: 元投稿のID（ブースト投稿のIDとは異なる）
  /// - [MastodonStatus.account]: 元投稿者のアカウント
  /// - [MastodonStatus.content]: 元投稿の本文
  /// - [MastodonStatus.reblog]: `null`
  /// - [MastodonStatus.reblogged]: `false`
  /// - [MastodonStatus.reblogsCount]: ブースト解除後の更新済みブースト数
  ///
  /// - [id]: ブーストを解除する投稿のID
  Future<MastodonStatus> unboost(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unreblog',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿をお気に入りに追加する
  ///
  /// `POST /api/v1/statuses/{id}/favourite`
  ///
  /// 返り値は**元投稿そのもの**（お気に入り後の更新済み状態）。
  ///
  /// - [MastodonStatus.favourited]: `true`
  /// - [MastodonStatus.favouritesCount]: お気に入り追加後の更新済みお気に入り数
  ///
  /// - [id]: お気に入りに追加する投稿のID
  Future<MastodonStatus> favourite(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/favourite',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿のお気に入りを解除する
  ///
  /// `POST /api/v1/statuses/{id}/unfavourite`
  ///
  /// 返り値は**元投稿そのもの**（お気に入り解除後の更新済み状態）。
  ///
  /// - [MastodonStatus.favourited]: `false`
  /// - [MastodonStatus.favouritesCount]: お気に入り解除後の更新済みお気に入り数
  ///
  /// - [id]: お気に入りを解除する投稿のID
  Future<MastodonStatus> unfavourite(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unfavourite',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿をブックマークに追加する
  ///
  /// `POST /api/v1/statuses/{id}/bookmark`
  ///
  /// 返り値は**元投稿そのもの**（ブックマーク後の更新済み状態）。
  ///
  /// - [MastodonStatus.bookmarked]: `true`
  ///
  /// - [id]: ブックマークに追加する投稿のID
  Future<MastodonStatus> bookmark(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/bookmark',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿のブックマークを解除する
  ///
  /// `POST /api/v1/statuses/{id}/unbookmark`
  ///
  /// 返り値は**元投稿そのもの**（ブックマーク解除後の更新済み状態）。
  ///
  /// - [MastodonStatus.bookmarked]: `false`
  ///
  /// - [id]: ブックマークを解除する投稿のID
  Future<MastodonStatus> unbookmark(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unbookmark',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿のスレッド通知をミュートする
  ///
  /// `POST /api/v1/statuses/{id}/mute`
  ///
  /// 自分が参加しているスレッドの通知を停止する。
  ///
  /// 返り値は**元投稿そのもの**（ミュート後の更新済み状態）。
  ///
  /// - [MastodonStatus.muted]: `true`
  ///
  /// - [id]: ミュートする投稿のID
  Future<MastodonStatus> mute(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/mute',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿のスレッド通知ミュートを解除する
  ///
  /// `POST /api/v1/statuses/{id}/unmute`
  ///
  /// 返り値は**元投稿そのもの**（ミュート解除後の更新済み状態）。
  ///
  /// - [MastodonStatus.muted]: `false`
  ///
  /// - [id]: ミュートを解除する投稿のID
  Future<MastodonStatus> unmute(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unmute',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿をプロフィールにピン留めする
  ///
  /// `POST /api/v1/statuses/{id}/pin`
  ///
  /// 自分の投稿のみピン留め可能。ブースト投稿はピン留めできない。
  ///
  /// 返り値は**元投稿そのもの**（ピン留め後の更新済み状態）。
  ///
  /// - [MastodonStatus.pinned]: `true`
  ///
  /// - [id]: ピン留めする投稿のID
  Future<MastodonStatus> pin(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/pin',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿のピン留めを解除する
  ///
  /// `POST /api/v1/statuses/{id}/unpin`
  ///
  /// 返り値は**元投稿そのもの**（ピン留め解除後の更新済み状態）。
  ///
  /// - [MastodonStatus.pinned]: `false`
  ///
  /// - [id]: ピン留めを解除する投稿のID
  Future<MastodonStatus> unpin(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/unpin',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿をブーストしたアカウントの一覧を取得する
  ///
  /// `GET /api/v1/statuses/{id}/reblogged_by`
  ///
  /// - [id]: 対象投稿のID
  /// - [maxId]: ページネーション用カーソル。この ID より古い結果を返す
  /// - [sinceId]: この ID より新しい結果を返す
  /// - [limit]: 最大取得件数（デフォルト: 40、上限: 80）
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonAccount>> fetchRebloggedBy(
    String id, {
    String? maxId,
    String? sinceId,
    int? limit,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/statuses/$id/reblogged_by',
      queryParameters: <String, dynamic>{
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'limit': ?limit,
      },
    );
    return (data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }

  /// 指定した投稿をお気に入りしたアカウントの一覧を取得する
  ///
  /// `GET /api/v1/statuses/{id}/favourited_by`
  ///
  /// - [id]: 対象投稿のID
  /// - [maxId]: ページネーション用カーソル。この ID より古い結果を返す
  /// - [sinceId]: この ID より新しい結果を返す
  /// - [limit]: 最大取得件数（デフォルト: 40、上限: 80）
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonAccount>> fetchFavouritedBy(
    String id, {
    String? maxId,
    String? sinceId,
    int? limit,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/statuses/$id/favourited_by',
      queryParameters: <String, dynamic>{
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'limit': ?limit,
      },
    );
    return (data ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }

  /// 新しい投稿を作成する
  ///
  /// `POST /api/v1/statuses`
  ///
  /// - [request]: 投稿内容を表す [MastodonStatusCreateRequest]
  /// - [idempotencyKey]: 重複投稿防止用の任意の文字列。同じキーで複数回リクエスト
  ///   した場合、サーバーは最初のリクエストと同じ結果を返す
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatus> create(
    MastodonStatusCreateRequest request, {
    String? idempotencyKey,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses',
      method: 'POST',
      data: request.toJson(),
      headers: idempotencyKey != null
          ? {'Idempotency-Key': idempotencyKey}
          : null,
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 自分の投稿を編集する
  ///
  /// `PUT /api/v1/statuses/{id}`
  ///
  /// 本文・コンテンツ警告・メディア添付・投票を変更できる。
  ///
  /// - [id]: 編集する投稿のID
  /// - [request]: 編集内容を表す [MastodonStatusEditRequest]
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatus> edit(
    String id,
    MastodonStatusEditRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id',
      method: 'PUT',
      data: request.toJson(),
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 自分の投稿を削除する
  ///
  /// `DELETE /api/v1/statuses/{id}`
  ///
  /// 返り値は削除された投稿のスナップショット。再投稿（redraft）用に
  /// `text` や `mediaAttachments` などのソース情報が含まれる。
  ///
  /// - [id]: 削除する投稿のID
  /// - [deleteMedia]: `true` の場合、添付メディアも即座に削除する
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatus> delete(String id, {bool? deleteMedia}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id',
      method: 'DELETE',
      queryParameters: <String, dynamic>{
        'delete_media': ?deleteMedia,
      },
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 投稿の内容を翻訳する
  ///
  /// `POST /api/v1/statuses/{id}/translate`
  ///
  /// 公開またはリスト未掲載の投稿のみ翻訳可能。
  ///
  /// - [id]: 翻訳する投稿のID
  /// - [lang]: 翻訳先の言語コード（ISO 639-1形式）。省略時はユーザーのロケール
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonTranslation> translate(String id, {String? lang}) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/translate',
      method: 'POST',
      data: <String, dynamic>{
        'lang': ?lang,
      },
    );
    return MastodonTranslation.fromJson(data!);
  }

  /// 投稿のインタラクションポリシーを変更する
  ///
  /// `PUT /api/v1/statuses/{id}/interaction_policy`
  ///
  /// 現時点では引用承認ポリシーの変更に使用される。
  ///
  /// - [id]: 対象投稿のID
  /// - [quoteApprovalPolicy]: 引用承認ポリシー（`public`・`followers`・`nobody`）
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatus> updateInteractionPolicy(
    String id, {
    required String quoteApprovalPolicy,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/interaction_policy',
      method: 'PUT',
      data: <String, dynamic>{
        'quote_approval_policy': quoteApprovalPolicy,
      },
    );
    return MastodonStatus.fromJson(data!);
  }

  /// 指定した投稿への引用を取り消す
  ///
  /// `POST /api/v1/statuses/{id}/quotes/{quotingStatusId}/revoke`
  ///
  /// 自分の投稿を引用している投稿から引用関係を切り離す。
  ///
  /// - [id]: 引用されている自分の投稿のID
  /// - [quotingStatusId]: 引用している投稿のID
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonStatus> revokeQuote(
    String id,
    String quotingStatusId,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/statuses/$id/quotes/$quotingStatusId/revoke',
      method: 'POST',
      data: <String, dynamic>{},
    );
    return MastodonStatus.fromJson(data!);
  }
}
