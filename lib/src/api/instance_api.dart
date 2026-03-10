import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_instance.dart';

/// インスタンス情報に関するAPI
class InstanceApi {
  const InstanceApi(this._http);

  final MastodonHttpClient _http;

  /// インスタンス情報を取得する
  ///
  /// `GET /api/v2/instance`
  ///
  /// 失敗時は `MastodonException` のサブクラスをスローする
  Future<MastodonInstance> fetch() async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v2/instance',
      );
      return MastodonInstance.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }
}
