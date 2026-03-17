import '../client/mastodon_http_client.dart';
import '../models/mastodon_domain_block.dart';
import '../models/mastodon_extended_description.dart';
import '../models/mastodon_instance.dart';
import '../models/mastodon_instance_v1.dart';
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
    final data = await _http.send<Map<String, dynamic>>('/api/v2/instance');
    return MastodonInstance.fromJson(data!);
  }

  /// インスタンスが認識しているピアドメインの一覧を取得
  ///
  /// `GET /api/v1/instance/peers`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrowする
  Future<List<String>> fetchPeers() async {
    final data = await _http.send<List<dynamic>>('/api/v1/instance/peers');
    return (data ?? const <dynamic>[]).cast<String>();
  }

  /// 直近3ヶ月の週間アクティビティ統計を取得
  ///
  /// `GET /api/v1/instance/activity`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonWeeklyActivity>> fetchActivity() async {
    final data = await _http.send<List<dynamic>>('/api/v1/instance/activity');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonWeeklyActivity.fromJson)
        .toList();
  }

  /// インスタンスのルール一覧を取得
  ///
  /// `GET /api/v1/instance/rules`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonInstanceRule>> fetchRules() async {
    final data = await _http.send<List<dynamic>>('/api/v1/instance/rules');
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonInstanceRule.fromJson)
        .toList();
  }

  /// インスタンスがブロックしているドメインの一覧を取得
  ///
  /// `GET /api/v1/instance/domain_blocks`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<List<MastodonDomainBlock>> fetchDomainBlocks() async {
    final data = await _http.send<List<dynamic>>(
      '/api/v1/instance/domain_blocks',
    );
    return (data ?? const <dynamic>[])
        .cast<Map<String, dynamic>>()
        .map(MastodonDomainBlock.fromJson)
        .toList();
  }

  /// インスタンスの詳細な説明文を取得
  ///
  /// `GET /api/v1/instance/extended_description`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonExtendedDescription> fetchExtendedDescription() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/extended_description',
    );
    return MastodonExtendedDescription.fromJson(data!);
  }

  /// インスタンスのプライバシーポリシーを取得
  ///
  /// `GET /api/v1/instance/privacy_policy`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonPrivacyPolicy> fetchPrivacyPolicy() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/privacy_policy',
    );
    return MastodonPrivacyPolicy.fromJson(data!);
  }

  /// インスタンスの利用規約を取得
  ///
  /// `GET /api/v1/instance/terms_of_service`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonTermsOfService> fetchTermsOfService() async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/terms_of_service',
    );
    return MastodonTermsOfService.fromJson(data!);
  }

  /// 指定した発効日の利用規約を取得
  ///
  /// `GET /api/v1/instance/terms_of_service/:date`
  ///
  /// 失敗時は `MastodonException` のサブクラスをthrow
  Future<MastodonTermsOfService> fetchTermsOfServiceByDate(
    String date,
  ) async {
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/terms_of_service/$date',
    );
    return MastodonTermsOfService.fromJson(data!);
  }

  /// v1 形式のインスタンス情報を取得する
  ///
  /// `GET /api/v1/instance`
  ///
  /// **非推奨**: Mastodon 4.0.0 で非推奨。代わりに [fetch]（v2）を使用すること。
  /// v2 未対応の古いサーバーとの互換性のために提供している。
  ///
  /// 失敗時は `MastodonException` のサブクラスを throw する。
  @Deprecated('Mastodon 4.0.0 で非推奨。代わりに fetch() (v2) を使用してください')
  Future<MastodonInstanceV1> fetchV1() async {
    final data = await _http.send<Map<String, dynamic>>('/api/v1/instance');
    return MastodonInstanceV1.fromJson(data!);
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
    final data = await _http.send<Map<String, dynamic>>(
      '/api/v1/instance/translation_languages',
    );
    return (data ?? const <String, dynamic>{}).map(
      (key, value) => MapEntry(
        key,
        (value as List<dynamic>).cast<String>(),
      ),
    );
  }
}
