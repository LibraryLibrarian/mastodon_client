import 'package:freezed_annotation/freezed_annotation.dart';

import 'mastodon_account.dart';
import 'mastodon_credential_account_update_request.dart';
import 'mastodon_featured_tag.dart';

part 'mastodon_profile.freezed.dart';
part 'mastodon_profile.g.dart';

/// Editable profile information returned by Mastodon 4.6+.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonProfile with _$MastodonProfile {
  const MastodonProfile({
    required this.id,
    required this.displayName,
    required this.note,
    required this.formattedNote,
    required this.fields,
    required this.formattedFields,
    required this.locked,
    required this.bot,
    required this.hideCollections,
    required this.discoverable,
    required this.indexable,
    required this.showMedia,
    required this.showMediaReplies,
    required this.showFeatured,
    this.avatar,
    this.avatarStatic,
    this.avatarDescription,
    this.header,
    this.headerStatic,
    this.headerDescription,
    this.attributionDomains = const <String>[],
    this.featuredTags = const <MastodonFeaturedTag>[],
  });

  factory MastodonProfile.fromJson(Map<String, dynamic> json) =>
      _$MastodonProfileFromJson(json);

  /// Serializes to JSON.
  Map<String, dynamic> toJson() => _$MastodonProfileToJson(this);

  @override
  final String id;

  @JsonKey(defaultValue: '')
  @override
  final String displayName;

  @JsonKey(defaultValue: '')
  @override
  final String note;

  @JsonKey(defaultValue: '')
  @override
  final String formattedNote;

  @JsonKey(defaultValue: <MastodonField>[])
  @override
  final List<MastodonField> fields;

  @JsonKey(defaultValue: <MastodonField>[])
  @override
  final List<MastodonField> formattedFields;

  @override
  final String? avatar;

  @override
  final String? avatarStatic;

  @override
  final String? avatarDescription;

  @override
  final String? header;

  @override
  final String? headerStatic;

  @override
  final String? headerDescription;

  @JsonKey(defaultValue: false)
  @override
  final bool locked;

  @JsonKey(defaultValue: false)
  @override
  final bool bot;

  @JsonKey(defaultValue: false)
  @override
  final bool hideCollections;

  @JsonKey(defaultValue: false)
  @override
  final bool discoverable;

  @JsonKey(defaultValue: false)
  @override
  final bool indexable;

  @JsonKey(defaultValue: true)
  @override
  final bool showMedia;

  @JsonKey(defaultValue: true)
  @override
  final bool showMediaReplies;

  @JsonKey(defaultValue: true)
  @override
  final bool showFeatured;

  @JsonKey(defaultValue: <String>[])
  @override
  final List<String> attributionDomains;

  @JsonKey(defaultValue: <MastodonFeaturedTag>[])
  @override
  final List<MastodonFeaturedTag> featuredTags;
}

/// Parameters accepted by `PATCH /api/v1/profile`.
class MastodonProfileUpdateRequest {
  const MastodonProfileUpdateRequest({
    this.displayName,
    this.note,
    this.avatar,
    this.avatarDescription,
    this.header,
    this.headerDescription,
    this.locked,
    this.bot,
    this.discoverable,
    this.hideCollections,
    this.indexable,
    this.showMedia,
    this.showMediaReplies,
    this.showFeatured,
    this.attributionDomains,
    this.fieldsAttributes,
  });

  final String? displayName;
  final String? note;
  final String? avatar;
  final String? avatarDescription;
  final String? header;
  final String? headerDescription;
  final bool? locked;
  final bool? bot;
  final bool? discoverable;
  final bool? hideCollections;
  final bool? indexable;
  final bool? showMedia;
  final bool? showMediaReplies;
  final bool? showFeatured;
  final List<String>? attributionDomains;
  final List<MastodonFieldAttribute>? fieldsAttributes;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'display_name': ?displayName,
    'note': ?note,
    'avatar': ?avatar,
    'avatar_description': ?avatarDescription,
    'header': ?header,
    'header_description': ?headerDescription,
    'locked': ?locked,
    'bot': ?bot,
    'discoverable': ?discoverable,
    'hide_collections': ?hideCollections,
    'indexable': ?indexable,
    'show_media': ?showMedia,
    'show_media_replies': ?showMediaReplies,
    'show_featured': ?showFeatured,
    if (attributionDomains != null) 'attribution_domains': attributionDomains,
    if (fieldsAttributes != null)
      'fields_attributes': fieldsAttributes!
          .map((field) => {'name': field.name, 'value': field.value})
          .toList(growable: false),
  };
}
