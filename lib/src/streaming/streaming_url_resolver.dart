import '../models/mastodon_instance.dart';
import '../models/mastodon_instance_v1.dart';

/// Resolves and normalizes the WebSocket URL for the streaming API.
class StreamingUrlResolver {
  const StreamingUrlResolver();

  /// Resolves a URL from v2 instance metadata, v1 metadata, or [baseUrl].
  ///
  /// The v2 streaming URL takes precedence over the v1 URL. If neither is
  /// available, the REST API host and port from [baseUrl] are used.
  Uri resolve({
    required String baseUrl,
    MastodonInstance? instance,
    MastodonInstanceV1? instanceV1,
  }) {
    final v2Url = _nonEmpty(instance?.configuration.urls.streaming);
    if (v2Url != null) {
      return _normalize(v2Url);
    }

    final v1Url = _nonEmpty(instanceV1?.urls?.streamingApi);
    if (v1Url != null) {
      return _normalize(v1Url);
    }

    final restUri = _parse(baseUrl);
    final restOrigin = Uri(
      scheme: restUri.scheme,
      userInfo: restUri.userInfo,
      host: restUri.host,
      port: restUri.hasPort ? restUri.port : null,
    );
    return _normalizeUri(restOrigin);
  }

  String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  Uri _normalize(String value) => _normalizeUri(_parse(value));

  Uri _parse(String value) {
    final trimmed = value.trim();
    final uri = Uri.parse(
      trimmed.contains('://') ? trimmed : 'https://$trimmed',
    );
    if (uri.host.isEmpty) {
      throw FormatException('Streaming URL must include a host.', value);
    }
    return uri;
  }

  Uri _normalizeUri(Uri uri) {
    final scheme = switch (uri.scheme.toLowerCase()) {
      'http' => 'ws',
      'https' => 'wss',
      'ws' => 'ws',
      'wss' => 'wss',
      _ => throw FormatException(
        'Unsupported streaming URL scheme: ${uri.scheme}',
        uri.toString(),
      ),
    };

    return uri.replace(scheme: scheme, path: _normalizePath(uri.path));
  }

  String _normalizePath(String path) {
    const endpoint = '/api/v1/streaming';
    if (path.isEmpty || path == '/') {
      return endpoint;
    }

    var trimmed = path;
    while (trimmed.length > 1 && trimmed.endsWith('/')) {
      trimmed = trimmed.substring(0, trimmed.length - 1);
    }
    return trimmed.endsWith(endpoint) ? trimmed : '$trimmed$endpoint';
  }
}
