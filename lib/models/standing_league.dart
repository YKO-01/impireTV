import 'package:json_annotation/json_annotation.dart';
import 'standing_team.dart';

part 'standing_league.g.dart';

@JsonSerializable()
class StandingLeague {
  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final int season;
  final List<List<StandingTeam>> standings;

  StandingLeague({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.standings,
  });

  factory StandingLeague.fromJson(Map<String, dynamic> json) =>
      _$StandingLeagueFromJson(json);

  Map<String, dynamic> toJson() => _$StandingLeagueToJson(this);
}


