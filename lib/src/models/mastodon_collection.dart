import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';

part 'mastodon_collection.freezed.dart';
part 'mastodon_collection.g.dart';

/// A collection of tagged statuses (Mastodon 4.6.0+).
///
/// Corresponds to responses from `/api/v1/collections` and appears in
/// `MastodonStatus.taggedCollections`.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCollection with _$MastodonCollection {
  const MastodonCollection({
    required this.id,
    this.uri,
    required this.name,
    this.description,
    this.language,
    this.accountId,
    this.local,
    this.sensitive,
    this.discoverable,
    this.url,
    this.itemCount,
    this.createdAt,
    this.updatedAt,
    this.tag,
  });

  factory MastodonCollection.fromJson(Map<String, dynamic> json) =>
      _$MastodonCollectionFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonCollectionToJson(this);

  /// Internal ID of the collection.
  @override
  final String id;

  /// ActivityPub URI of the collection.
  @override
  final String? uri;

  /// Name of the collection.
  @override
  final String name;

  /// Description of the collection.
  @override
  final String? description;

  /// ISO 639-1 language code of the collection's content.
  @override
  final String? language;

  /// ID of the account that owns the collection.
  @override
  final String? accountId;

  /// Whether the collection belongs to a local account.
  @override
  final bool? local;

  /// Whether the collection's contents are marked sensitive.
  @override
  final bool? sensitive;

  /// Whether the collection is discoverable.
  @override
  final bool? discoverable;

  /// Web URL of the collection.
  @override
  final String? url;

  /// Number of items tagged into the collection.
  @override
  final int? itemCount;

  /// Date and time the collection was created.
  @SafeDateTimeConverter()
  @override
  final DateTime? createdAt;

  /// Date and time the collection was last updated.
  @SafeDateTimeConverter()
  @override
  final DateTime? updatedAt;

  /// Hashtag associated with the collection, if any.
  @override
  final String? tag;
}
