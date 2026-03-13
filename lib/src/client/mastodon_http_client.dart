import 'package:dio/dio.dart';

import '../internal/dio_error_handler.dart';
import '../logging/logger.dart';
import '../logging/package_logger.dart';
import 'constants.dart';

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
    bool enableLog = true,
    Logger? logger,
  }) : logger = logger ?? const StdoutLogger(),
       dio = Dio(
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
       ) {
    dio.interceptors.add(
      _MastodonInterceptor(enableLog: enableLog, logger: this.logger),
    );
  }

  final Dio dio;
  final Logger logger;

  /// HTTP リクエストを実行しレスポンスボディを返す
  ///
  /// `DioException` は自動的に `MastodonException` に変換される。
  /// レスポンスヘッダーやステータスコードが必要な場合は [sendRaw] を使用する。
  Future<T?> send<T>(
    String path, {
    String method = 'GET',
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );
      return response.data;
    } on DioException catch (e) {
      throw convertDioException(e, path);
    }
  }

  /// HTTP リクエストを実行し `Response` をそのまま返す
  ///
  /// レスポンスヘッダーやステータスコードへのアクセスが必要な場合に使用する。
  /// `DioException` は自動的に `MastodonException` に変換される。
  Future<Response<T>> sendRaw<T>(
    String path, {
    String method = 'GET',
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );
    } on DioException catch (e) {
      throw convertDioException(e, path);
    }
  }
}

class _MastodonInterceptor extends Interceptor {
  _MastodonInterceptor({
    required this.enableLog,
    required this.logger,
  });

  final bool enableLog;
  final Logger logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enableLog && kDebugMode) {
      clientLog.d(
        '[HTTP REQ] ${options.method} ${options.uri}',
      );
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (enableLog && kDebugMode) {
      clientLog.d(
        '[HTTP RES] ${response.statusCode} ${response.requestOptions.uri}',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enableLog && kDebugMode) {
      final statusCode = err.response?.statusCode;
      final isExpectedClientError =
          statusCode != null &&
          (statusCode == 401 || statusCode == 403 || statusCode == 404);

      if (isExpectedClientError) {
        clientLog.d('[HTTP ERR] ${err.requestOptions.uri} status=$statusCode');
      } else {
        clientLog.e(
          '[HTTP ERR] ${err.requestOptions.uri}',
          error: err,
          stackTrace: err.stackTrace,
        );
      }
    }
    super.onError(err, handler);
  }
}
