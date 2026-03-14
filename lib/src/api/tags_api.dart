import '../client/mastodon_http_client.dart';
import '../models/mastodon_tag.dart';

/// ハッシュタグ情報の取得・フォロー操作に関するAPI
class TagsApi {
  /// [MastodonHttpClient] を受け取り、タグAPIへのアクセスを提供する
  const TagsApi(this._http);

  final MastodonHttpClient _http;

  /// 指定したハッシュタグの情報を取得する
  ///
  /// `GET /api/v1/tags/:name`
  ///
  /// - [name]: ハッシュタグ名（大文字小文字を区別しない）
  ///
  /// 認証済みトークンを使用するとフォロー状態（`following`）も返される。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonTag> fetch(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name',
    );
    return MastodonTag.fromJson(data!);
  }

  /// ハッシュタグをフォローする
  ///
  /// `POST /api/v1/tags/:name/follow`
  ///
  /// フォローしたタグを含む投稿がホームタイムラインに表示されるようになる。
  ///
  /// - [name]: フォローするハッシュタグ名
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonTag> follow(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name/follow',
      method: 'POST',
    );
    return MastodonTag.fromJson(data!);
  }

  /// ハッシュタグのフォローを解除する
  ///
  /// `POST /api/v1/tags/:name/unfollow`
  ///
  /// - [name]: フォロー解除するハッシュタグ名
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonTag> unfollow(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name/unfollow',
      method: 'POST',
    );
    return MastodonTag.fromJson(data!);
  }

  /// ハッシュタグをプロフィールにフィーチャー（注目表示）する
  ///
  /// `POST /api/v1/tags/:id/feature`
  ///
  /// - [name]: フィーチャーするハッシュタグ名
  ///
  /// Mastodon 4.4.0 以降で利用可能。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonTag> feature(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name/feature',
      method: 'POST',
    );
    return MastodonTag.fromJson(data!);
  }

  /// ハッシュタグのプロフィールフィーチャー（注目表示）を解除する
  ///
  /// `POST /api/v1/tags/:id/unfeature`
  ///
  /// - [name]: フィーチャー解除するハッシュタグ名
  ///
  /// Mastodon 4.4.0 以降で利用可能。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonTag> unfeature(String name) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/tags/$name/unfeature',
      method: 'POST',
    );
    return MastodonTag.fromJson(data!);
  }
}
