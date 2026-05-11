import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/goal_scorer.dart';
import '../models/match_fixture.dart';
import '../models/match_result.dart';
import '../local/league_database_interface.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String matchesCollection = 'matches';
  static const String scorersCollection = 'goal_scorers';

  Future<void> saveMatchResult({
    required MatchFixture fixture,
    required MatchResult result,
  }) async {
    final batch = _firestore.batch();

    try {
      // Check if match already exists
      final existingQuery = await _firestore
          .collection(matchesCollection)
          .where('homeTeam', isEqualTo: result.homeTeam)
          .where('awayTeam', isEqualTo: result.awayTeam)
          .limit(1)
          .get();

      // Delete existing match if found
      if (existingQuery.docs.isNotEmpty) {
        final existingDocId = existingQuery.docs.first.id;

        // Delete goal scorers for this match
        final scorersQuery = await _firestore
            .collection(matchesCollection)
            .doc(existingDocId)
            .collection(scorersCollection)
            .get();

        for (final doc in scorersQuery.docs) {
          batch.delete(doc.reference);
        }

        // Delete match document
        batch.delete(existingQuery.docs.first.reference);
      }

      // Add new match
      final matchRef = _firestore.collection(matchesCollection).doc();
      batch.set(matchRef, {
        'homeTeam': result.homeTeam,
        'awayTeam': result.awayTeam,
        'homeScore': result.homeScore,
        'awayScore': result.awayScore,
        'dateLabel': result.dateLabel,
        'competitionRound': result.competitionRound,
        'venue': fixture.venue,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Add home scorers
      for (final scorer in result.homeScorers) {
        batch.set(matchRef.collection(scorersCollection).doc(), {
          'teamName': result.homeTeam,
          'playerName': scorer.playerName,
          'minuteLabel': scorer.minuteLabel,
        });
      }

      // Add away scorers
      for (final scorer in result.awayScorers) {
        batch.set(matchRef.collection(scorersCollection).doc(), {
          'teamName': result.awayTeam,
          'playerName': scorer.playerName,
          'minuteLabel': scorer.minuteLabel,
        });
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to save match result: $e');
    }
  }

  Future<List<StoredMatchRecord>> fetchStoredMatches() async {
    try {
      final matchDocs = await _firestore
          .collection(matchesCollection)
          .orderBy('timestamp', descending: true)
          .get();

      final records = <StoredMatchRecord>[];

      for (final matchDoc in matchDocs.docs) {
        final matchData = matchDoc.data();
        final homeTeam = matchData['homeTeam'] as String;
        final awayTeam = matchData['awayTeam'] as String;
        final venue = matchData['venue'] as String;

        final scorerDocs = await matchDoc.reference
            .collection(scorersCollection)
            .get();

        final homeScorers = <GoalScorer>[];
        final awayScorers = <GoalScorer>[];

        for (final scorerDoc in scorerDocs.docs) {
          final scorerData = scorerDoc.data();
          final teamName = scorerData['teamName'] as String;
          final scorer = GoalScorer(
            playerName: scorerData['playerName'] as String,
            minuteLabel: scorerData['minuteLabel'] as String,
          );

          if (teamName == homeTeam) {
            homeScorers.add(scorer);
          } else {
            awayScorers.add(scorer);
          }
        }

        final result = MatchResult(
          homeTeam: homeTeam,
          awayTeam: awayTeam,
          homeScore: matchData['homeScore'] as int,
          awayScore: matchData['awayScore'] as int,
          dateLabel: matchData['dateLabel'] as String,
          competitionRound: matchData['competitionRound'] as String,
          homeScorers: homeScorers,
          awayScorers: awayScorers,
        );

        records.add(StoredMatchRecord(
          venue: venue,
          result: result,
        ));
      }

      return records;
    } catch (e) {
      throw Exception('Failed to fetch stored matches: $e');
    }
  }
}
