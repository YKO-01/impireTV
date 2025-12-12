import 'package:json_annotation/json_annotation.dart';
import 'standing_goals.dart';

part 'standing_stats.g.dart';

@JsonSerializable()
class StandingStats {
  final int played;
  final int win;
  final int draw;
  final int lose;
  final StandingGoals goals;

  StandingStats({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
  });

  factory StandingStats.fromJson(Map<String, dynamic> json) =>
      _$StandingStatsFromJson(json);

  Map<String, dynamic> toJson() => _$StandingStatsToJson(this);
}

