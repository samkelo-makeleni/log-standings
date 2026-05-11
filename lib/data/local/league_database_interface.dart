import '../models/match_fixture.dart';
import '../models/match_result.dart';

/// Abstract base class for database operations
abstract class ILeagueDatabase {
  Future<void> initialize();
  Future<List<StoredMatchRecord>> fetchStoredMatches();
  Future<void> saveMatchResult({
    required MatchFixture fixture,
    required MatchResult result,
  });
}

class StoredMatchRecord {
  const StoredMatchRecord({required this.venue, required this.result});

  final String venue;
  final MatchResult result;

  String get fixtureKey => '${result.homeTeam}|${result.awayTeam}';
}
