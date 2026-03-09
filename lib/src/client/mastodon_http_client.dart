import 'package:dio/dio.dart';

/// Mastodon API との HTTP 通信を担う内部クライアント
///
/// コンストラクタの `baseUrl` にはスキームを含むホスト URL（例: `https://mastodon.social`）を指定する。
/// `accessToken` を指定した場合、全リクエストに `Authorization: Bearer` ヘッダが付与される。
class MastodonHttpClient {
  MastodonHttpClient({
    required String baseUrl,
    String? accessToken,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 10),
    Duration sendTimeout = const Duration(seconds: 10),
  }) : dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: connectTimeout,
           receiveTimeout: receiveTimeout,
           sendTimeout: sendTimeout,
           headers: {
             'Accept': 'application/json',
             if (accessToken != null) 'Authorization': 'Bearer $accessToken',
           },
         ),
       );

  final Dio dio;
}
