// ignore_for_file: unused_local_variable, avoid_print

import 'package:mastodon_client/mastodon_client.dart';

void main() async {
  // -------------------------------------------------------
  // 1. Initialize the client
  // -------------------------------------------------------
  final client = MastodonClient(
    baseUrl: 'https://mastodon.social',
    accessToken: 'YOUR_ACCESS_TOKEN',
  );

  // -------------------------------------------------------
  // 2. Fetch server info (no authentication required)
  // -------------------------------------------------------
  final instance = await client.instance.fetch();
  print('Server: ${instance.title}');
  print('Version: ${instance.version}');

  // -------------------------------------------------------
  // 3. Verify the authenticated user
  // -------------------------------------------------------
  final me = await client.accounts.verifyCredentials();
  print('Logged in as: ${me.acct}');

  // -------------------------------------------------------
  // 4. Post a status
  // -------------------------------------------------------
  final result = await client.statuses.create(
    const MastodonStatusCreateRequest(
      status: 'Hello from mastodon_client!',
    ),
  );
  if (result case MastodonStatusCreated(:final status)) {
    print('Posted: ${status.url}');
  }

  // -------------------------------------------------------
  // 5. Fetch home timeline with pagination
  // -------------------------------------------------------
  final page = await client.timelines.fetchHome(limit: 20);
  for (final status in page.items) {
    print('${status.account.acct}: ${status.content}');
  }

  // Fetch the next page
  if (page.nextMaxId != null) {
    final nextPage = await client.timelines.fetchHome(
      limit: 20,
      maxId: page.nextMaxId,
    );
  }

  // -------------------------------------------------------
  // 6. Error handling
  // -------------------------------------------------------
  try {
    await client.accounts.fetchById('unknown_id');
  } on MastodonNotFoundException {
    print('Account not found');
  } on MastodonUnauthorizedException {
    print('Invalid token');
  } on MastodonRateLimitException catch (e) {
    print('Rate limited — retry after ${e.retryAfter}');
  } on MastodonException catch (e) {
    print('Error: $e');
  }
}
