// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingStats _$StandingStatsFromJson(Map<String, dynamic> json) =>
    StandingStats(
      played: (json['played'] as num).toInt(),
      win: (json['win'] as num).toInt(),
      draw: (json['draw'] as num).toInt(),
      lose: (json['lose'] as num).toInt(),
      goals: StandingGoals.fromJson(json['goals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StandingStatsToJson(StandingStats instance) =>
    <String, dynamic>{
      'played': instance.played,
      'win': instance.win,
      'draw': instance.draw,
      'lose': instance.lose,
      'goals': instance.goals,
    };
