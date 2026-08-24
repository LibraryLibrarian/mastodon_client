import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_converters.dart';
import 'mastodon_account.dart';

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
    this.items = const <MastodonCollectionItem>[],
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
  final MastodonCollectionTag? tag;

  /// Items included in the collection for the authenticated account.
  @JsonKey(defaultValue: <MastodonCollectionItem>[])
  @override
  final List<MastodonCollectionItem> items;
}

/// A shallow hashtag embedded in a collection.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCollectionTag with _$MastodonCollectionTag {
  const MastodonCollectionTag({required this.name, required this.url});

  factory MastodonCollectionTag.fromJson(Map<String, dynamic> json) =>
      _$MastodonCollectionTagFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonCollectionTagToJson(this);

  /// Name of the hashtag without the `#` symbol.
  @override
  final String name;

  /// URL to the hashtag on the instance.
  @override
  final String url;
}

/// An item included in a collection.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCollectionItem with _$MastodonCollectionItem {
  const MastodonCollectionItem({
    required this.id,
    required this.state,
    required this.createdAt,
    this.accountId,
  });

  factory MastodonCollectionItem.fromJson(Map<String, dynamic> json) =>
      _$MastodonCollectionItemFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonCollectionItemToJson(this);

  /// Internal ID of the collection item.
  @override
  final String id;

  /// Moderation state of the item.
  @override
  final String state;

  /// Date and time the item was created.
  @override
  final DateTime createdAt;

  /// ID of the associated account for pending or accepted items.
  @override
  final String? accountId;
}

/// A collection together with the accounts visible to the requester.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonCollectionDetail with _$MastodonCollectionDetail {
  const MastodonCollectionDetail({
    required this.collection,
    this.accounts = const <MastodonAccount>[],
  });

  factory MastodonCollectionDetail.fromJson(Map<String, dynamic> json) =>
      _$MastodonCollectionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MastodonCollectionDetailToJson(this);

  @override
  final MastodonCollection collection;

  @JsonKey(defaultValue: <MastodonAccount>[])
  @override
  final List<MastodonAccount> accounts;
}

/// Parameters for creating a collection.
class MastodonCollectionCreateRequest {
  const MastodonCollectionCreateRequest({
    required this.name,
    required this.sensitive,
    required this.discoverable,
    this.description,
    this.language,
    this.tagName,
    this.accountIds,
  });

  final String name;
  final bool sensitive;
  final bool discoverable;
  final String? description;
  final String? language;
  final String? tagName;
  final List<String>? accountIds;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'sensitive': sensitive,
    'discoverable': discoverable,
    'description': ?description,
    'language': ?language,
    'tag_name': ?tagName,
    if (accountIds != null) 'account_ids': accountIds,
  };
}

/// Parameters for updating a collection.
class MastodonCollectionUpdateRequest {
  const MastodonCollectionUpdateRequest({
    this.name,
    this.description,
    this.language,
    this.sensitive,
    this.discoverable,
    this.tagName,
  });

  final String? name;
  final String? description;
  final String? language;
  final bool? sensitive;
  final bool? discoverable;
  final String? tagName;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': ?name,
    'description': ?description,
    'language': ?language,
    'sensitive': ?sensitive,
    'discoverable': ?discoverable,
    'tag_name': ?tagName,
  };
}
