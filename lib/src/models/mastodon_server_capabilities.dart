import 'mastodon_instance.dart';
import 'mastodon_instance_v1.dart';

/// Support state for a server capability.
enum MastodonCapabilitySupport {
  /// The server metadata indicates that the capability is available.
  supported,

  /// The server metadata indicates that the capability is unavailable.
  unsupported,

  /// The available server metadata is insufficient for a reliable decision.
  unknown,
}

/// Version-dependent Mastodon server capabilities known to this package.
enum MastodonCapability {
  /// Featuring and unfeaturing tags, added in Mastodon 4.4.0.
  tagFeaturing,

  /// Fetching a single annual report, added in Mastodon 4.4.0.
  annualReportDetails,

  /// OpenID Connect UserInfo endpoint, added in Mastodon 4.4.0.
  oauthUserInfo,

  /// Checking the status of experimental asynchronous refresh operations,
  /// added in Mastodon 4.4.0.
  asyncRefreshes,

  /// Quote-post operations, added in Mastodon 4.5.0.
  quotePosts,

  /// Collections endpoints, added in Mastodon 4.6.0.
  collections,

  /// Donation campaign endpoint, added in Mastodon 4.6.0.
  donationCampaigns,

  /// Fetching and updating the editable profile, added in Mastodon 4.6.0.
  editableProfile,

  /// Annual report generation and state endpoints, added in Mastodon 4.6.0.
  annualReportGeneration,
}

/// Version metadata used to estimate server capability support.
///
/// Call [supportFor] for a three-state result. The value is advisory: forks
/// and compatible implementations may expose a different API surface, so an
/// API call can still fail even when the result is [MastodonCapabilitySupport.supported].
final class MastodonServerCapabilities {
  /// Creates capability metadata from a Mastodon API version and version
  /// string.
  const MastodonServerCapabilities({
    required this.apiVersionMastodon,
    required this.version,
  });

  /// Creates capability metadata from a v2 instance response.
  factory MastodonServerCapabilities.fromInstance(MastodonInstance instance) =>
      MastodonServerCapabilities(
        apiVersionMastodon: instance.apiVersionMastodon,
        version: instance.version,
      );

  /// Creates capability metadata from a legacy v1 instance response.
  factory MastodonServerCapabilities.fromInstanceV1(
    MastodonInstanceV1 instance,
  ) => MastodonServerCapabilities(
    apiVersionMastodon: null,
    version: instance.version,
  );

  /// Mastodon's API surface version from `api_versions.mastodon`.
  ///
  /// This is null for legacy responses and servers that do not publish it.
  final int? apiVersionMastodon;

  /// Version string reported by the server.
  final String version;

  /// Estimates whether [capability] is available on the server.
  ///
  /// A positive `api_versions.mastodon` value takes precedence over the
  /// version string. When it is absent, a leading `major.minor.patch` version
  /// is used as a best-effort fallback. If the metadata cannot be interpreted,
  /// this method returns [MastodonCapabilitySupport.unknown].
  MastodonCapabilitySupport supportFor(MastodonCapability capability) {
    final requirement = capability._requirement;
    final apiVersion = apiVersionMastodon;
    if (apiVersion != null) {
      if (apiVersion <= 0) return MastodonCapabilitySupport.unknown;
      return apiVersion >= requirement.apiVersion
          ? MastodonCapabilitySupport.supported
          : MastodonCapabilitySupport.unsupported;
    }

    final parsedVersion = _MastodonVersion.tryParse(version);
    if (parsedVersion == null) return MastodonCapabilitySupport.unknown;
    return parsedVersion.isAtLeast(
          requirement.major,
          requirement.minor,
          requirement.patch,
        )
        ? MastodonCapabilitySupport.supported
        : MastodonCapabilitySupport.unsupported;
  }
}

extension on MastodonCapability {
  ({int apiVersion, int major, int minor, int patch}) get _requirement =>
      switch (this) {
        MastodonCapability.tagFeaturing ||
        MastodonCapability.annualReportDetails ||
        MastodonCapability.oauthUserInfo ||
        MastodonCapability.asyncRefreshes => (
          apiVersion: 6,
          major: 4,
          minor: 4,
          patch: 0,
        ),
        MastodonCapability.quotePosts => (
          apiVersion: 7,
          major: 4,
          minor: 5,
          patch: 0,
        ),
        MastodonCapability.collections ||
        MastodonCapability.donationCampaigns ||
        MastodonCapability.editableProfile ||
        MastodonCapability.annualReportGeneration => (
          apiVersion: 10,
          major: 4,
          minor: 6,
          patch: 0,
        ),
      };
}

final class _MastodonVersion {
  const _MastodonVersion(this.major, this.minor, this.patch);

  static final _pattern = RegExp(r'^(\d+)\.(\d+)\.(\d+)');

  final int major;
  final int minor;
  final int patch;

  static _MastodonVersion? tryParse(String value) {
    final match = _pattern.firstMatch(value.trim());
    if (match == null) return null;
    return _MastodonVersion(
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    );
  }

  bool isAtLeast(int otherMajor, int otherMinor, int otherPatch) {
    if (major != otherMajor) return major > otherMajor;
    if (minor != otherMinor) return minor > otherMinor;
    return patch >= otherPatch;
  }
}
