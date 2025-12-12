import 'package:json_annotation/json_annotation.dart';
import 'fixture.dart';
import 'league.dart';
import 'teams.dart';
import 'goals.dart';
import 'score.dart';
import 'event.dart';

part 'match.g.dart';

@JsonSerializable()
class Match {
  final Fixture? fixture;
  final League? league;
  final Teams? teams;
  final Goals? goals;
  final Score? score;
  @JsonKey(defaultValue: [])
  final List<Event> events;

  Match({
    this.fixture,
    this.league,
    this.teams,
    this.goals,
    this.score,
    required this.events,
  });

  factory Match.fromJson(Map<String, dynamic> json) => _$MatchFromJson(json);

  Map<String, dynamic> toJson() => _$MatchToJson(this);
}


