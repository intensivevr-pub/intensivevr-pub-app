import 'game.dart';
import 'user.dart';

class LeaderBoardEntry {
  final int id;
  final int points;
  final DateTime date;
  final Game game;
  final User user;

  LeaderBoardEntry({
    this.id,
    this.points,
    this.date,
    this.game,
    this.user,
  });
}
