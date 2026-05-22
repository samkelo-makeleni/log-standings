import 'package:log_standings/data/local/league_database_interface.dart';
import 'package:log_standings/data/models/match_fixture.dart';
import 'package:log_standings/data/models/match_result.dart';

class FakeLeagueDatabase implements ILeagueDatabase {
  FakeLeagueDatabase({List<StoredMatchRecord>? storedMatches})
    : _storedMatches = List<StoredMatchRecord>.from(storedMatches ?? const []);

  final List<StoredMatchRecord> _storedMatches;

  @override
  Future<List<StoredMatchRecord>> fetchStoredMatches() async =>
      List<StoredMatchRecord>.unmodifiable(_storedMatches);

  @override
  Future<void> initialize() async {}

  @override
  Future<void> saveMatchResult({
    required MatchFixture fixture,
    required MatchResult result,
  }) async {
    _storedMatches.add(StoredMatchRecord(venue: fixture.venue, result: result));
  }
}
