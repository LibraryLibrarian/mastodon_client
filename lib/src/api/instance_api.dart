import 'package:dio/dio.dart';

import '../client/mastodon_http_client.dart';
import '../internal/dio_error_handler.dart';
import '../models/mastodon_domain_block.dart';
import '../models/mastodon_extended_description.dart';
import '../models/mastodon_instance.dart';
import '../models/mastodon_privacy_policy.dart';
import '../models/mastodon_terms_of_service.dart';
import '../models/mastodon_weekly_activity.dart';

/// インスタンス情報に関するAPI
class InstanceApi {
  const InstanceApi(this._http);

  final MastodonHttpClient _http;

  /// インスタンス情報を取得する
  ///
  /// `GET /api/v2/instance`
  ///
  /// 失敗時は `MastodonException` のサブクラスをスローする
  Future<MastodonInstance> fetch() async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v2/instance',
      );
      return MastodonInstance.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// インスタンスが認識しているピアドメインの一覧を取得
  ///
  /// `GET /api/v1/instance/peers`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrowする
  Future<List<String>> fetchPeers() async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/instance/peers',
      );
      return (response.data ?? const <dynamic>[]).cast<String>();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 直近3ヶ月の週間アクティビティ統計を取得
  ///
  /// `GET /api/v1/instance/activity`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonWeeklyActivity>> fetchActivity() async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/instance/activity',
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonWeeklyActivity.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// インスタンスのルール一覧を取得
  ///
  /// `GET /api/v1/instance/rules`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonInstanceRule>> fetchRules() async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/instance/rules',
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonInstanceRule.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// インスタンスがブロックしているドメインの一覧を取得
  ///
  /// `GET /api/v1/instance/domain_blocks`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonDomainBlock>> fetchDomainBlocks() async {
    try {
      final response = await _http.dio.get<List<dynamic>>(
        '/api/v1/instance/domain_blocks',
      );
      return (response.data ?? const <dynamic>[])
          .cast<Map<String, dynamic>>()
          .map(MastodonDomainBlock.fromJson)
          .toList();
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// インスタンスの詳細な説明文を取得
  ///
  /// `GET /api/v1/instance/extended_description`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonExtendedDescription> fetchExtendedDescription() async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/instance/extended_description',
      );
      return MastodonExtendedDescription.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// インスタンスのプライバシーポリシーを取得
  ///
  /// `GET /api/v1/instance/privacy_policy`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonPrivacyPolicy> fetchPrivacyPolicy() async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/instance/privacy_policy',
      );
      return MastodonPrivacyPolicy.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// インスタンスの利用規約を取得
  ///
  /// `GET /api/v1/instance/terms_of_service`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonTermsOfService> fetchTermsOfService() async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/instance/terms_of_service',
      );
      return MastodonTermsOfService.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 指定した発効日の利用規約を取得
  ///
  /// `GET /api/v1/instance/terms_of_service/:date`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonTermsOfService> fetchTermsOfServiceByDate(
    String date,
  ) async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/instance/terms_of_service/$date',
      );
      return MastodonTermsOfService.fromJson(response.data!);
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }

  /// 翻訳エンジンが対応する言語ペアを取得
  ///
  /// `GET /api/v1/instance/translation_languages`
  ///
  /// ソース言語コードをキー、対応するターゲット言語コードのリストを値とする
  /// マップを返す。
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<Map<String, List<String>>> fetchTranslationLanguages() async {
    try {
      final response = await _http.dio.get<Map<String, dynamic>>(
        '/api/v1/instance/translation_languages',
      );
      final data = response.data ?? const <String, dynamic>{};
      return data.map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).cast<String>(),
        ),
      );
    } on DioException catch (e) {
      throw convertDioException(e);
    }
  }
}
