// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_goals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingGoals _$StandingGoalsFromJson(Map<String, dynamic> json) =>
    StandingGoals(
      forGoals: (json['for'] as num).toInt(),
      against: (json['against'] as num).toInt(),
    );

Map<String, dynamic> _$StandingGoalsToJson(StandingGoals instance) =>
    <String, dynamic>{'for': instance.forGoals, 'against': instance.against};
