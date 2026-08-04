import 'package:json_annotation/json_annotation.dart';

import 'json_converters.dart';

part 'mastodon_collection.g.dart';

/// A collection of tagged statuses (Mastodon 4.6.0+).
///
/// Corresponds to responses from `/api/v1/collections` and appears in
/// `MastodonStatus.taggedCollections`.
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCollection {
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
  final String id;

  /// ActivityPub URI of the collection.
  final String? uri;

  /// Name of the collection.
  final String name;

  /// Description of the collection.
  final String? description;

  /// ISO 639-1 language code of the collection's content.
  final String? language;

  /// ID of the account that owns the collection.
  final String? accountId;

  /// Whether the collection belongs to a local account.
  final bool? local;

  /// Whether the collection's contents are marked sensitive.
  final bool? sensitive;

  /// Whether the collection is discoverable.
  final bool? discoverable;

  /// Web URL of the collection.
  final String? url;

  /// Number of items tagged into the collection.
  final int? itemCount;

  /// Date and time the collection was created.
  @SafeDateTimeConverter()
  final DateTime? createdAt;

  /// Date and time the collection was last updated.
  @SafeDateTimeConverter()
  final DateTime? updatedAt;

  /// Hashtag associated with the collection, if any.
  final String? tag;
}
