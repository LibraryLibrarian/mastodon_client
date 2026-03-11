import 'package:json_annotation/json_annotation.dart';

/// 文字列として返される整数値をパースするヘルパー
int parseIntFromString(dynamic value) =>
    int.tryParse(value?.toString() ?? '') ?? 0;

/// [DateTime.tryParse] を使用する [JsonConverter]。
///
/// json_serializable が生成する `DateTime.parse` は不正な書式で例外を投げるが、
/// このコンバーターは旧実装と同様に `null` にフォールバックする。
class SafeDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const SafeDateTimeConverter();

  @override
  DateTime? fromJson(String? json) =>
      json == null ? null : DateTime.tryParse(json);

  @override
  String? toJson(DateTime? object) => object?.toIso8601String();
}
