// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingTeam _$StandingTeamFromJson(Map<String, dynamic> json) => StandingTeam(
  rank: (json['rank'] as num).toInt(),
  team: Team.fromJson(json['team'] as Map<String, dynamic>),
  points: (json['points'] as num).toInt(),
  goalsDiff: (json['goalsDiff'] as num).toInt(),
  group: json['group'] as String,
  form: json['form'] as String,
  all: StandingStats.fromJson(json['all'] as Map<String, dynamic>),
  home: StandingStats.fromJson(json['home'] as Map<String, dynamic>),
  away: StandingStats.fromJson(json['away'] as Map<String, dynamic>),
  update: json['update'] as String,
);

Map<String, dynamic> _$StandingTeamToJson(StandingTeam instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'team': instance.team,
      'points': instance.points,
      'goalsDiff': instance.goalsDiff,
      'group': instance.group,
      'form': instance.form,
      'all': instance.all,
      'home': instance.home,
      'away': instance.away,
      'update': instance.update,
    };
