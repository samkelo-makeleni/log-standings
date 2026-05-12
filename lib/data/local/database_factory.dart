import '../local/league_database_interface.dart';
import '../models/match_fixture.dart';
import '../models/match_result.dart';
import '../services/firebase_service.dart';

/// Database factory - Firebase only
class DatabaseFactory {
  static ILeagueDatabase createDatabase({bool useFirebase = true}) {
    // Firebase is the only option now
    return FirebaseDatabase();
  }
}

/// Firebase implementation of ILeagueDatabase
class FirebaseDatabase implements ILeagueDatabase {
  final _firebaseService = FirebaseService();

  @override
  Future<void> initialize() async {
    // Firebase is initialized in main.dart
    // No additional setup needed here
  }

  @override
  Future<List<StoredMatchRecord>> fetchStoredMatches() async {
    try {
      return await _firebaseService.fetchStoredMatches();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveMatchResult({
    required MatchFixture fixture,
    required MatchResult result,
  }) async {
    try {
      await _firebaseService.saveMatchResult(
        fixture: fixture,
        result: result,
      );
    } catch (e) {
      rethrow;
    }
  }
}
