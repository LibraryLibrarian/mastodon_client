import 'package:json_annotation/json_annotation.dart';

part 'mastodon_relationship.g.dart';

/// Relationship between two accounts (follow, block, mute, etc.).
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonRelationship {
  /// Creates a [MastodonRelationship] with the given fields.
  const MastodonRelationship({
    required this.id,
    required this.following,
    required this.showingReblogs,
    required this.notifying,
    required this.followedBy,
    required this.blocking,
    required this.blockedBy,
    required this.muting,
    required this.mutingNotifications,
    required this.requested,
    required this.requestedBy,
    required this.domainBlocking,
    required this.endorsed,
    required this.note,
    this.languages,
  });

  /// Creates a [MastodonRelationship] from a JSON map.
  factory MastodonRelationship.fromJson(Map<String, dynamic> json) =>
      _$MastodonRelationshipFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonRelationshipToJson(this);

  /// ID of the target account.
  final String id;

  /// Whether you are following this account.
  @JsonKey(defaultValue: false)
  final bool following;

  /// Whether boosts from this account are shown in your home timeline.
  @JsonKey(defaultValue: true)
  final bool showingReblogs;

  /// Whether notifications from this account are enabled.
  @JsonKey(defaultValue: false)
  final bool notifying;

  /// List of languages you follow from this account (ISO 639-1).
  final List<String>? languages;

  /// Whether this account follows you.
  @JsonKey(defaultValue: false)
  final bool followedBy;

  /// Whether you are blocking this account.
  @JsonKey(defaultValue: false)
  final bool blocking;

  /// Whether you are blocked by this account.
  @JsonKey(defaultValue: false)
  final bool blockedBy;

  /// Whether you are muting this account.
  @JsonKey(defaultValue: false)
  final bool muting;

  /// Whether you are muting notifications from this account.
  @JsonKey(defaultValue: false)
  final bool mutingNotifications;

  /// Whether a follow request to this account is pending.
  @JsonKey(defaultValue: false)
  final bool requested;

  /// Whether a follow request from this account is pending.
  @JsonKey(defaultValue: false)
  final bool requestedBy;

  /// Whether you are blocking this account's domain.
  @JsonKey(defaultValue: false)
  final bool domainBlocking;

  /// Whether you are featuring this account on your profile.
  @JsonKey(defaultValue: false)
  final bool endorsed;

  /// Private note set on this account.
  @JsonKey(defaultValue: '')
  final String note;
}
