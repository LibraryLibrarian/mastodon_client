import '../client/mastodon_http_client.dart';
import '../models/mastodon_featured_tag.dart';
import '../models/mastodon_tag.dart';

/// 注目ハッシュタグの管理に関するAPI
class FeaturedTagsApi {
  /// [MastodonHttpClient] を受け取り、注目タグAPIへのアクセスを提供する
  const FeaturedTagsApi(this._http);

  final MastodonHttpClient _http;

  /// 自分のプロフィールにフィーチャーしているハッシュタグの一覧を取得する
  ///
  /// `GET /api/v1/featured_tags`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonFeaturedTag>> fetch() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/featured_tags',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonFeaturedTag.fromJson)
        .toList();
  }

  /// ハッシュタグをプロフィール上でフィーチャー（注目表示）する
  ///
  /// `POST /api/v1/featured_tags`
  ///
  /// - [name]: フィーチャーするハッシュタグ名（`#` 記号なし）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonFeaturedTag> create(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/featured_tags',
      method: 'POST',
      data: <String, dynamic>{'name': name},
    );
    return MastodonFeaturedTag.fromJson(data!);
  }

  /// ハッシュタグのフィーチャー（注目表示）を解除する
  ///
  /// `DELETE /api/v1/featured_tags/:id`
  ///
  /// - [id]: 解除する FeaturedTag の ID
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<void> delete(String id) async {
    await _http.send<void>(
      '/api/v1/featured_tags/$id',
      method: 'DELETE',
    );
  }

  /// フィーチャー候補として最近使用したハッシュタグを最大10件取得する
  ///
  /// `GET /api/v1/featured_tags/suggestions`
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonTag>> fetchSuggestions() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/featured_tags/suggestions',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonTag.fromJson)
        .toList();
  }
}
