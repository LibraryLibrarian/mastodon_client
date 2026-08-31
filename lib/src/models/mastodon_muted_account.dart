import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';

part 'mastodon_muted_account.freezed.dart';

/// An account returned by `GET /api/v1/mutes` and its mute expiration.
@Freezed(toStringOverride: false)
@JsonSerializable(createFactory: false, createToJson: false)
class MastodonMutedAccount with _$MastodonMutedAccount {
  const MastodonMutedAccount({required this.account, this.muteExpiresAt});

  /// Creates a [MastodonMutedAccount] from Mastodon's flat response object.
  factory MastodonMutedAccount.fromJson(Map<String, dynamic> json) =>
      MastodonMutedAccount(
        account: MastodonAccount.fromJson(json),
        muteExpiresAt: const SafeDateTimeConverter().fromJson(
          json['mute_expires_at'] as String?,
        ),
      );

  /// Serializes to Mastodon's flat muted-account response shape.
  Map<String, dynamic> toJson() => <String, dynamic>{
    ...account.toJson(),
    'mute_expires_at': const SafeDateTimeConverter().toJson(muteExpiresAt),
  };

  /// The muted account.
  @override
  final MastodonAccount account;

  /// When the timed mute expires.
  ///
  /// Mastodon only returns `mute_expires_at` from `GET /api/v1/mutes`. This is
  /// `null` for an indefinite mute and when an older compatible server omits
  /// the field.
  @override
  final DateTime? muteExpiresAt;
}
