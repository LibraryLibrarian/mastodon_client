import '../client/mastodon_http_client.dart';
import '../models/mastodon_oembed.dart';

/// OEmbed 情報の取得に関する API クライアント
class OEmbedApi {
  /// [MastodonHttpClient] を受け取り、OEmbed API へのアクセスを提供する
  const OEmbedApi(this._http);

  final MastodonHttpClient _http;

  /// 投稿の OEmbed メタデータを取得する
  ///
  /// `GET /api/oembed`
  ///
  /// 認証不要。
  ///
  /// - [url]: OEmbed 情報を取得する投稿の URL（必須）
  /// - [maxwidth]: 生成される iframe の幅（ピクセル）。デフォルト: 400
  /// - [maxheight]: 生成される iframe の高さ（ピクセル）
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<MastodonOEmbed> fetch(
    String url, {
    int? maxwidth,
    int? maxheight,
  }) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/oembed',
      queryParameters: <String, dynamic>{
        'url': url,
        'maxwidth': ?maxwidth,
        'maxheight': ?maxheight,
      },
    );
    return MastodonOEmbed.fromJson(data!);
  }
}
