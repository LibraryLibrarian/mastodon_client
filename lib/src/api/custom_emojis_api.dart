import '../client/mastodon_http_client.dart';
import '../models/mastodon_custom_emoji.dart';

/// カスタム絵文字に関する API
class CustomEmojisApi {
  const CustomEmojisApi(this._http);

  final MastodonHttpClient _http;

  /// サーバーで利用可能なカスタム絵文字の一覧を取得する
  ///
  /// `GET /api/v1/custom_emojis`
  ///
  /// 認証不要。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  Future<List<MastodonCustomEmoji>> fetch() async {
    final data = await _http.send<List<dynamic>>('/api/v1/custom_emojis');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonCustomEmoji.fromJson)
        .toList();
  }
}
