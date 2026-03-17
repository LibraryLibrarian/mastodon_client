import '../client/mastodon_http_client.dart';
import '../internal/link_header_parser.dart';
import '../models/mastodon_page.dart';

/// ユーザーレベルのドメインブロック管理に関する API クライアント
class DomainBlocksApi {
  /// [MastodonHttpClient] を受け取り、ドメインブロック API へのアクセスを提供する
  const DomainBlocksApi(this._http);

  final MastodonHttpClient _http;

  /// ブロック済みドメインの一覧を取得する
  ///
  /// `GET /api/v1/domain_blocks`
  ///
  /// - [limit]: 最大取得件数（デフォルト: 100、上限: 200）
  /// - [maxId]: このIDより古い結果を返す（ページネーション用カーソル）
  /// - [sinceId]: このIDより新しい結果を返す
  /// - [minId]: このIDより新しい結果を返す（逆順）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonPage<String>> fetch({
    int? limit,
    String? maxId,
    String? sinceId,
    String? minId,
  }) async {
    final response = await _http.sendRaw<List<dynamic>>(
      '/api/v1/domain_blocks',
      queryParameters: <String, dynamic>{
        'limit': ?limit,
        if (maxId != null && maxId.isNotEmpty) 'max_id': maxId,
        if (sinceId != null && sinceId.isNotEmpty) 'since_id': sinceId,
        if (minId != null && minId.isNotEmpty) 'min_id': minId,
      },
    );
    final linkHeader = response.headers.map['link']?.join(',');
    final items = (response.data ?? const <dynamic>[]).cast<String>().toList();
    return MastodonPage(
      items: items,
      nextMaxId: parseNextMaxId(linkHeader),
      prevMinId: parsePrevMinId(linkHeader),
    );
  }

  /// ドメインをブロックする
  ///
  /// `POST /api/v1/domain_blocks`
  ///
  /// ブロックすると以下の効果が発生する:
  /// - そのドメインの全公開投稿を非表示にする
  /// - そのドメインからの全通知を非表示にする
  /// - そのドメインのフォロワーを削除する
  /// - そのドメインのユーザーへの新規フォローを防止する
  ///
  /// - [domain]: ブロック対象のドメイン名
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> block(String domain) async {
    await _http.send<void>(
      '/api/v1/domain_blocks',
      method: 'POST',
      data: <String, dynamic>{'domain': domain},
    );
  }

  /// ドメインブロックを解除する
  ///
  /// `DELETE /api/v1/domain_blocks`
  ///
  /// - [domain]: ブロック解除対象のドメイン名
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> unblock(String domain) async {
    await _http.send<void>(
      '/api/v1/domain_blocks',
      method: 'DELETE',
      data: <String, dynamic>{'domain': domain},
    );
  }
}
