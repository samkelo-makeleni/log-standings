import '../local/local_league_database.dart';
import '../local/league_database_interface.dart';
import '../models/match_fixture.dart';
import '../models/match_result.dart';
import '../services/firebase_service.dart';

/// Database factory for switching between local and Firebase
class DatabaseFactory {
  static ILeagueDatabase createDatabase({bool useFirebase = true}) {
    if (useFirebase) {
      return FirebaseDatabase();
    } else {
      return LocalDatabaseAdapter();
    }
  }
}

/// Adapter for local database to implement ILeagueDatabase interface
class LocalDatabaseAdapter implements ILeagueDatabase {
  final _localDb = LocalLeagueDatabase();

  @override
  Future<void> initialize() async {
    await _localDb.initialize();
  }

  @override
  Future<List<StoredMatchRecord>> fetchStoredMatches() async {
    return _localDb.fetchStoredMatches();
  }

  @override
  Future<void> saveMatchResult({
    required MatchFixture fixture,
    required MatchResult result,
  }) async {
    await _localDb.saveMatchResult(fixture: fixture, result: result);
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
