import 'package:json_annotation/json_annotation.dart';
import 'team.dart';
import 'standing_stats.dart';

part 'standing_team.g.dart';

@JsonSerializable()
class StandingTeam {
  final int rank;
  final Team team;
  final int points;
  final int goalsDiff;
  final String group;
  final String form;
  final StandingStats all;
  final StandingStats home;
  final StandingStats away;
  final String update;

  StandingTeam({
    required this.rank,
    required this.team,
    required this.points,
    required this.goalsDiff,
    required this.group,
    required this.form,
    required this.all,
    required this.home,
    required this.away,
    required this.update,
  });

  factory StandingTeam.fromJson(Map<String, dynamic> json) =>
      _$StandingTeamFromJson(json);

  Map<String, dynamic> toJson() => _$StandingTeamToJson(this);
}


