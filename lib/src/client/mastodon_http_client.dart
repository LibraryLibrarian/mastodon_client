import 'package:dio/dio.dart';

import '../internal/dio_error_handler.dart';
import '../logging/logger.dart';
import '../logging/package_logger.dart';
import 'constants.dart';

/// Internal HTTP client responsible for communication with the Mastodon API.
///
/// The constructor's `baseUrl` takes a host URL including the scheme
/// (e.g. `https://mastodon.social`).
/// When `accessToken` is provided, an `Authorization: Bearer` header is added
/// to all requests.
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

  /// Executes an HTTP request and returns the response body.
  ///
  /// `DioException` is automatically converted to `MastodonException`.
  /// Use [sendRaw] when access to response headers or status codes is needed.
  ///
  /// When [contentType] is specified, it overrides Dio's default inference
  /// and explicitly sets the request's Content-Type.
  Future<T?> send<T>(
    String path, {
    String method = 'GET',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    try {
      final response = await dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: headers,
          contentType: contentType,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      throw convertDioException(e, path);
    }
  }

  /// Executes an HTTP request and returns the raw `Response`.
  ///
  /// Use this when access to response headers or status codes is needed.
  /// `DioException` is automatically converted to `MastodonException`.
  ///
  /// When [contentType] is specified, it overrides Dio's default inference
  /// and explicitly sets the request's Content-Type.
  Future<Response<T>> sendRaw<T>(
    String path, {
    String method = 'GET',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    try {
      return await dio.request<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: headers,
          contentType: contentType,
        ),
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
