import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../models/goal_scorer.dart';
import '../models/match_fixture.dart';
import '../models/match_result.dart';
import 'league_database_interface.dart';

class LocalLeagueDatabase {
  sqflite.Database? _database;

  Future<void> initialize() async {
    await database;
  }

  Future<sqflite.Database> get database async {
    _database ??= await _openDatabase();
    return _database!;
  }

  Future<void> saveMatchResult({
    required MatchFixture fixture,
    required MatchResult result,
  }) async {
    final db = await database;

    await db.transaction((txn) async {
      final existingMatches = await txn.query(
        'matches',
        columns: ['id'],
        where: 'home_team = ? AND away_team = ?',
        whereArgs: [result.homeTeam, result.awayTeam],
        limit: 1,
      );

      if (existingMatches.isNotEmpty) {
        final existingId = existingMatches.first['id'] as int;
        await txn.delete(
          'goal_scorers',
          where: 'match_id = ?',
          whereArgs: [existingId],
        );
        await txn.delete('matches', where: 'id = ?', whereArgs: [existingId]);
      }

      final matchId = await txn.insert('matches', {
        'home_team': result.homeTeam,
        'away_team': result.awayTeam,
        'home_score': result.homeScore,
        'away_score': result.awayScore,
        'date_label': result.dateLabel,
        'competition_round': result.competitionRound,
        'venue': fixture.venue,
      });

      await _insertScorers(
        txn: txn,
        matchId: matchId,
        teamName: result.homeTeam,
        scorers: result.homeScorers,
      );
      await _insertScorers(
        txn: txn,
        matchId: matchId,
        teamName: result.awayTeam,
        scorers: result.awayScorers,
      );
    });
  }

  Future<List<StoredMatchRecord>> fetchStoredMatches() async {
    final db = await database;
    final matchRows = await db.query('matches', orderBy: 'id DESC');
    final records = <StoredMatchRecord>[];

    for (final row in matchRows) {
      final matchId = row['id'] as int;
      final scorers = await db.rawQuery(
        '''
        SELECT goal_scorers.team_name, goal_scorers.minute_label, players.name
        FROM goal_scorers
        INNER JOIN players ON players.id = goal_scorers.player_id
        WHERE goal_scorers.match_id = ?
        ORDER BY goal_scorers.id ASC
        ''',
        [matchId],
      );

      final homeTeam = row['home_team'] as String;
      final awayTeam = row['away_team'] as String;
      final homeScorers = <GoalScorer>[];
      final awayScorers = <GoalScorer>[];

      for (final scorer in scorers) {
        final item = GoalScorer(
          playerName: scorer['name'] as String,
          minuteLabel: scorer['minute_label'] as String,
        );
        final teamName = scorer['team_name'] as String;
        if (teamName == homeTeam) {
          homeScorers.add(item);
        } else {
          awayScorers.add(item);
        }
      }

      records.add(
        StoredMatchRecord(
          venue: row['venue'] as String,
          result: MatchResult(
            homeTeam: homeTeam,
            awayTeam: awayTeam,
            homeScore: row['home_score'] as int,
            awayScore: row['away_score'] as int,
            dateLabel: row['date_label'] as String,
            competitionRound: row['competition_round'] as String,
            homeScorers: homeScorers,
            awayScorers: awayScorers,
          ),
        ),
      );
    }

    return records;
  }

  Future<void> _insertScorers({
    required sqflite.Transaction txn,
    required int matchId,
    required String teamName,
    required List<GoalScorer> scorers,
  }) async {
    for (final scorer in scorers) {
      final playerId = await _upsertPlayer(
        txn: txn,
        playerName: scorer.playerName,
        teamName: teamName,
      );

      await txn.insert('goal_scorers', {
        'match_id': matchId,
        'player_id': playerId,
        'team_name': teamName,
        'minute_label': scorer.minuteLabel,
      });
    }
  }

  Future<int> _upsertPlayer({
    required sqflite.Transaction txn,
    required String playerName,
    required String teamName,
  }) async {
    final existingPlayers = await txn.query(
      'players',
      columns: ['id'],
      where: 'name = ? AND team_name = ?',
      whereArgs: [playerName, teamName],
      limit: 1,
    );

    if (existingPlayers.isNotEmpty) {
      return existingPlayers.first['id'] as int;
    }

    return txn.insert('players', {'name': playerName, 'team_name': teamName});
  }

  Future<sqflite.Database> _openDatabase() async {
    if (kIsWeb) {
      throw UnsupportedError('Local database is not supported on web.');
    }

    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      sqfliteFfiInit();
      sqflite.databaseFactory = databaseFactoryFfi;
    }

    final databasesPath = await sqflite.getDatabasesPath();
    final databasePath = p.join(databasesPath, 'trfa_local.db');

    return sqflite.openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE players(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            team_name TEXT NOT NULL,
            UNIQUE(name, team_name)
          )
        ''');

        await db.execute('''
          CREATE TABLE matches(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            home_team TEXT NOT NULL,
            away_team TEXT NOT NULL,
            home_score INTEGER NOT NULL,
            away_score INTEGER NOT NULL,
            date_label TEXT NOT NULL,
            competition_round TEXT NOT NULL,
            venue TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE goal_scorers(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            match_id INTEGER NOT NULL,
            player_id INTEGER NOT NULL,
            team_name TEXT NOT NULL,
            minute_label TEXT NOT NULL,
            FOREIGN KEY(match_id) REFERENCES matches(id) ON DELETE CASCADE,
            FOREIGN KEY(player_id) REFERENCES players(id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }
}
