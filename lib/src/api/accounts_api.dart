import '../client/mastodon_http_client.dart';
import '../exception/mastodon_exception.dart';
import '../models/mastodon_account.dart';
import '../models/mastodon_account_create_request.dart';
import '../models/mastodon_account_page.dart';
import '../models/mastodon_credential_account_update_request.dart';
import '../models/mastodon_familiar_followers.dart';
import '../models/mastodon_featured_tag.dart';
import '../models/mastodon_identity_proof.dart';
import '../models/mastodon_list.dart';
import '../models/mastodon_relationship.dart';
import '../models/mastodon_status.dart';
import '../models/mastodon_token.dart';

/// アカウント情報の取得・操作を行う API クライアント
class AccountsApi {
  /// [MastodonHttpClient] を受け取り、アカウント API へのアクセスを提供する
  const AccountsApi(this._http);

  final MastodonHttpClient _http;

  /// ID を指定してアカウント情報を取得する
  ///
  /// `GET /api/v1/accounts/{accountId}`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccount> fetchById(String accountId) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$accountId',
    );
    return MastodonAccount.fromJson(data!);
  }

  /// 認証済みユーザー自身のアカウント情報を取得する
  ///
  /// `GET /api/v1/accounts/verify_credentials`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccount> verifyCredentials() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/verify_credentials',
    );
    return MastodonAccount.fromJson(data!);
  }

  /// `acct` 文字列からアカウントを検索して取得する
  ///
  /// `GET /api/v1/accounts/lookup?acct={acct}`
  ///
  /// 404・405・410・501 が返された場合は [search] にフォールバックし、
  /// `acct` フィールドが一致（大文字小文字を無視）する最初の結果を返す。
  /// フォールバック後も一致するアカウントが見つからない場合は
  /// [MastodonNotFoundException] を throw する。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccount> lookup(String acct) async {
    try {
      final data = await _http.send<Map<String, dynamic>>(
        '/api/v1/accounts/lookup',
        queryParameters: <String, dynamic>{'acct': acct},
      );
      return MastodonAccount.fromJson(data!);
    } on MastodonApiException catch (e) {
      if (e.statusCode == 404 ||
          e.statusCode == 405 ||
          e.statusCode == 410 ||
          e.statusCode == 501) {
        return _lookupViaSearch(acct);
      }
      rethrow;
    }
  }

  /// キーワードでアカウントを検索する
  ///
  /// `GET /api/v1/accounts/search?q={query}&resolve={resolve}&limit={limit}`
  ///
  /// - [query]: 検索クエリ文字列
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [offset]: 先頭から指定件数をスキップする
  /// - [resolve]: `true` の場合、リモートアカウントを WebFinger で解決する
  /// - [following]: `true` の場合、フォロー中のアカウントのみを返す
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonAccount>> search(
    String query, {
    int? limit,
    int? offset,
    bool? resolve,
    bool? following,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/search',
      queryParameters: <String, dynamic>{
        'q': query,
        'resolve': ?resolve,
        'following': ?following,
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }

  /// 指定アカウントのフォロワー一覧を取得する
  ///
  /// `GET /api/v1/accounts/{accountId}/followers`
  ///
  /// - [accountId]: 対象アカウントの ID
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [maxId]: ページネーション用カーソル。直前のレスポンスの `nextMaxId` を渡す
  /// - [sinceId]: この ID より新しい結果を取得する
  /// - [minId]: この ID 直後の結果から取得する（前方ページネーション）
  ///
  /// 非公開アカウント（HTTP 403）の場合は空の [MastodonAccountPage] を返す。
  /// それ以外の失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccountPage> fetchFollowers(
    String accountId, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$accountId/followers',
    limit: limit,
    maxId: maxId,
    sinceId: sinceId,
    minId: minId,
  );

  /// 指定アカウントのフォロー中一覧を取得する
  ///
  /// `GET /api/v1/accounts/{accountId}/following`
  ///
  /// - [accountId]: 対象アカウントの ID
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [maxId]: ページネーション用カーソル。直前のレスポンスの `nextMaxId` を渡す
  /// - [sinceId]: この ID より新しい結果を取得する
  /// - [minId]: この ID 直後の結果から取得する（前方ページネーション）
  ///
  /// 非公開アカウント（HTTP 403）の場合は空の [MastodonAccountPage] を返す。
  /// それ以外の失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccountPage> fetchFollowing(
    String accountId, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$accountId/following',
    limit: limit,
    maxId: maxId,
    sinceId: sinceId,
    minId: minId,
  );

  /// 指定アカウントの投稿一覧を取得する
  ///
  /// `GET /api/v1/accounts/{accountId}/statuses`
  ///
  /// - [accountId]: 対象アカウントの ID
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値が適用される
  /// - [maxId]: ページネーション用カーソル。前回取得した末尾の投稿 ID を渡す
  /// - [sinceId]: この ID より新しい投稿を取得する
  /// - [minId]: この ID 直後の投稿から取得する（前方ページネーション）
  /// - [excludeReplies]: `true` のとき返信投稿を除外する
  /// - [excludeReblogs]: `true` のときブースト投稿を除外する
  /// - [onlyMedia]: `true` のときメディア添付のある投稿のみを返す
  /// - [pinned]: `true` のときピン留め投稿のみを返す
  /// - [tagged]: 指定したハッシュタグを含む投稿のみに絞り込む
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonStatus>> fetchStatuses(
    String accountId, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
    bool? excludeReplies,
    bool? excludeReblogs,
    bool? onlyMedia,
    bool? pinned,
    String? tagged,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/$accountId/statuses',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        'max_id': ?maxId,
        'since_id': ?sinceId,
        'min_id': ?minId,
        'exclude_replies': ?excludeReplies,
        'exclude_reblogs': ?excludeReblogs,
        'only_media': ?onlyMedia,
        'pinned': ?pinned,
        'tagged': ?tagged,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonStatus.fromJson)
        .toList();
  }

  /// ログイン中ユーザーのプロフィール情報を更新する
  ///
  /// `PATCH /api/v1/accounts/update_credentials`
  ///
  /// [request] に更新したいフィールドのみを指定する。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccount> updateCredentials(
    MastodonCredentialAccountUpdateRequest request,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/update_credentials',
      method: 'PATCH',
      data: request.toJson(),
    );
    return MastodonAccount.fromJson(data!);
  }

  /// 新規アカウントを登録する
  ///
  /// `POST /api/v1/accounts`
  ///
  /// アプリトークンを用いてリクエストする必要がある。
  /// 成功時はユーザーに紐づく [MastodonToken] を返す。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonToken> create(MastodonAccountCreateRequest request) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts',
      method: 'POST',
      data: request.toJson(),
    );
    return MastodonToken.fromJson(data!);
  }

  /// 複数の ID を指定してアカウント情報をまとめて取得する
  ///
  /// `GET /api/v1/accounts?id[]={id}`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonAccount>> fetchMultiple(List<String> ids) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts',
      queryParameters: <String, dynamic>{'id[]': ids},
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonAccount.fromJson)
        .toList();
  }

  /// 指定アカウントをフォローする
  ///
  /// `POST /api/v1/accounts/{id}/follow`
  ///
  /// - [id]: 対象アカウントの ID
  /// - [reblogs]: ブースト投稿をホームタイムラインに表示するかどうか
  /// - [notify]: 投稿時に通知を受け取るかどうか
  /// - [languages]: フォローする言語のリスト（ISO 639-1 形式）
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> follow(
    String id, {
    bool? reblogs,
    bool? notify,
    List<String>? languages,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/follow',
      method: 'POST',
      data: <String, dynamic>{
        'reblogs': ?reblogs,
        'notify': ?notify,
        'languages[]': ?languages,
      },
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントのフォローを解除する
  ///
  /// `POST /api/v1/accounts/{id}/unfollow`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> unfollow(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unfollow',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントを自分のフォロワーから削除する
  ///
  /// `POST /api/v1/accounts/{id}/remove_from_followers`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> removeFromFollowers(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/remove_from_followers',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントをブロックする
  ///
  /// `POST /api/v1/accounts/{id}/block`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> block(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/block',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントのブロックを解除する
  ///
  /// `POST /api/v1/accounts/{id}/unblock`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> unblock(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unblock',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントをミュートする
  ///
  /// `POST /api/v1/accounts/{id}/mute`
  ///
  /// - [id]: 対象アカウントの ID
  /// - [notifications]: 通知もミュートするかどうか（デフォルト: `true`）
  /// - [duration]: ミュート期間（秒）。`0` または未指定で無期限
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> mute(
    String id, {
    bool? notifications,
    int? duration,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/mute',
      method: 'POST',
      data: <String, dynamic>{
        'notifications': ?notifications,
        'duration': ?duration,
      },
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントのミュートを解除する
  ///
  /// `POST /api/v1/accounts/{id}/unmute`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> unmute(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unmute',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントをプロフィールで紹介（ピン）する
  ///
  /// `POST /api/v1/accounts/{id}/pin`
  ///
  /// **非推奨**: Mastodon 4.4.0 以降は [endorse] を使用すること。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  @Deprecated('Mastodon 4.4.0 以降は endorse() を使用してください')
  Future<MastodonRelationship> pin(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/pin',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントのプロフィール紹介（ピン）を解除する
  ///
  /// `POST /api/v1/accounts/{id}/unpin`
  ///
  /// **非推奨**: Mastodon 4.4.0 以降は [unendorse] を使用すること。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  @Deprecated('Mastodon 4.4.0 以降は unendorse() を使用してください')
  Future<MastodonRelationship> unpin(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unpin',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントをプロフィールでフィーチャー（紹介）する
  ///
  /// `POST /api/v1/accounts/{id}/endorse`
  ///
  /// 対象アカウントを事前にフォローしている必要がある。
  /// フォローしていない場合は HTTP 422 エラーとなる。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> endorse(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/endorse',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントのプロフィールフィーチャー（紹介）を解除する
  ///
  /// `POST /api/v1/accounts/{id}/unendorse`
  ///
  /// 既にフィーチャーされていない場合でも成功する。
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> unendorse(String id) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/unendorse',
      method: 'POST',
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 指定アカウントがフィーチャーしているアカウント一覧を取得する
  ///
  /// `GET /api/v1/accounts/{id}/endorsements`
  ///
  /// - [id]: 対象アカウントの ID
  /// - [limit]: 最大取得件数。省略時はサーバーのデフォルト値（40）が適用される
  /// - [maxId]: ページネーション用カーソル。直前のレスポンスの `nextMaxId` を渡す
  /// - [sinceId]: この ID より新しい結果を取得する
  /// - [minId]: この ID 直後の結果から取得する（前方ページネーション）
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonAccountPage> fetchEndorsements(
    String id, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) => _fetchAccountPage(
    '/api/v1/accounts/$id/endorsements',
    limit: limit,
    maxId: maxId,
    sinceId: sinceId,
    minId: minId,
  );

  /// 指定アカウントにプライベートメモを設定する
  ///
  /// `POST /api/v1/accounts/{id}/note`
  ///
  /// - [id]: 対象アカウントの ID
  /// - [comment]: メモの内容。`null` または空文字でメモを削除する
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<MastodonRelationship> setNote(
    String id, {
    String? comment,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/accounts/$id/note',
      method: 'POST',
      data: <String, dynamic>{
        'comment': ?comment,
      },
    );
    return MastodonRelationship.fromJson(data!);
  }

  /// 複数アカウントとのリレーションシップをまとめて取得する
  ///
  /// `GET /api/v1/accounts/relationships?id[]={id}`
  ///
  /// - [ids]: 対象アカウントの ID リスト
  /// - [withSuspended]: 凍結アカウントを含めるかどうか
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonRelationship>> fetchRelationships(
    List<String> ids, {
    bool? withSuspended,
  }) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/relationships',
      queryParameters: <String, dynamic>{
        'id[]': ids,
        'with_suspended': ?withSuspended,
      },
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonRelationship.fromJson)
        .toList();
  }

  /// 指定アカウントをフォローしている共通フォロイーを取得する
  ///
  /// `GET /api/v1/accounts/familiar_followers?id[]={id}`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonFamiliarFollowers>> fetchFamiliarFollowers(
    List<String> ids,
  ) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/familiar_followers',
      queryParameters: <String, dynamic>{'id[]': ids},
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFamiliarFollowers.fromJson)
        .toList();
  }

  /// 指定アカウントの紹介タグ一覧を取得する
  ///
  /// `GET /api/v1/accounts/{id}/featured_tags`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonFeaturedTag>> fetchFeaturedTags(String id) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/$id/featured_tags',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFeaturedTag.fromJson)
        .toList();
  }

  /// 指定アカウントが属するリスト一覧を取得する
  ///
  /// `GET /api/v1/accounts/{id}/lists`
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  Future<List<MastodonList>> fetchLists(String id) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/$id/lists',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonList.fromJson)
        .toList();
  }

  /// 指定アカウントの本人確認証明を取得する
  ///
  /// `GET /api/v1/accounts/{id}/identity_proofs`
  ///
  /// **非推奨**: Mastodon 3.5.0 以降は常に空配列を返す。
  ///
  /// - [id]: 対象アカウントの ID
  ///
  /// 失敗時は [MastodonException] のサブクラスを throw する。
  @Deprecated('Mastodon 3.5.0 以降は常に空配列を返す')
  Future<List<MastodonIdentityProof>> fetchIdentityProofs(String id) async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/accounts/$id/identity_proofs',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonIdentityProof.fromJson)
        .toList();
  }

  Future<MastodonAccount> _lookupViaSearch(String acct) async {
    final results = await search(acct);
    final target = acct.toLowerCase();
    final match = results.where(
      (a) => a.acct.toLowerCase() == target,
    );
    if (match.isNotEmpty) {
      return match.first;
    }
    throw const MastodonNotFoundException(
      message: 'Account not found',
    );
  }

  Future<MastodonAccountPage> _fetchAccountPage(
    String path, {
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    try {
      final response = await _http.sendRaw<List<dynamic>>(
        path,
        queryParameters: <String, dynamic>{
          'limit': ?limit,
          'max_id': ?maxId,
          'since_id': ?sinceId,
          'min_id': ?minId,
        },
      );
      final accounts = (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonAccount.fromJson)
          .toList();
      final nextMaxId = _parseNextMaxId(
        response.headers.map['link']?.join(','),
      );
      return MastodonAccountPage(accounts: accounts, nextMaxId: nextMaxId);
    } on MastodonForbiddenException {
      return const MastodonAccountPage(accounts: []);
    }
  }

  /// `Link` レスポンスヘッダーから `rel="next"` の `max_id` クエリパラメーターを
  /// 取り出す
  ///
  /// 次ページが存在しない場合、または解析できない場合は `null` を返す。
  String? _parseNextMaxId(String? linkHeader) {
    if (linkHeader == null) return null;
    for (final segment in linkHeader.split(',')) {
      final trimmed = segment.trim();
      if (!trimmed.contains('rel="next"')) continue;
      final start = trimmed.indexOf('<');
      final end = trimmed.indexOf('>');
      if (start == -1 || end == -1 || end <= start + 1) continue;
      final url = trimmed.substring(start + 1, end);
      final maxId = Uri.tryParse(url)?.queryParameters['max_id'];
      if (maxId != null && maxId.isNotEmpty) return maxId;
    }
    return null;
  }
}
