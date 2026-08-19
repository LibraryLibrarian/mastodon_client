import 'package:mastodon_client/src/client/mastodon_http_client.dart';

class RecordedRequest {
  const RecordedRequest({
    required this.path,
    required this.method,
    this.data,
    this.queryParameters,
    this.contentType,
  });

  final String path;
  final String method;
  final Object? data;
  final Map<String, dynamic>? queryParameters;
  final String? contentType;
}

class RecordingHttpClient extends MastodonHttpClient {
  RecordingHttpClient([Iterable<Object?> responses = const <Object?>[]])
    : _responses = responses.toList(),
      super(baseUrl: 'https://mastodon.example', enableLog: false);

  final List<Object?> _responses;
  final List<RecordedRequest> requests = [];

  @override
  Future<T?> send<T>(
    String path, {
    String method = 'GET',
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    requests.add(
      RecordedRequest(
        path: path,
        method: method,
        data: data,
        queryParameters: queryParameters,
        contentType: contentType,
      ),
    );
    if (_responses.isEmpty) return null;
    return _responses.removeAt(0) as T?;
  }
}
