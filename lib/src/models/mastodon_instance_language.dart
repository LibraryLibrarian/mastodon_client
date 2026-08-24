import 'package:freezed_annotation/freezed_annotation.dart';

part 'mastodon_instance_language.freezed.dart';
part 'mastodon_instance_language.g.dart';

/// A locale supported by the Mastodon user interface.
@Freezed(toStringOverride: false)
@JsonSerializable(fieldRename: FieldRename.snake)
class MastodonInstanceLanguage with _$MastodonInstanceLanguage {
  const MastodonInstanceLanguage({required this.code, required this.name});

  factory MastodonInstanceLanguage.fromJson(Map<String, dynamic> json) =>
      _$MastodonInstanceLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$MastodonInstanceLanguageToJson(this);

  @override
  final String code;

  @override
  final String name;
}
