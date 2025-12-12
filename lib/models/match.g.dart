// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Match _$MatchFromJson(Map<String, dynamic> json) => Match(
  fixture: json['fixture'] == null
      ? null
      : Fixture.fromJson(json['fixture'] as Map<String, dynamic>),
  league: json['league'] == null
      ? null
      : League.fromJson(json['league'] as Map<String, dynamic>),
  teams: json['teams'] == null
      ? null
      : Teams.fromJson(json['teams'] as Map<String, dynamic>),
  goals: json['goals'] == null
      ? null
      : Goals.fromJson(json['goals'] as Map<String, dynamic>),
  score: json['score'] == null
      ? null
      : Score.fromJson(json['score'] as Map<String, dynamic>),
  events:
      (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$MatchToJson(Match instance) => <String, dynamic>{
  'fixture': instance.fixture,
  'league': instance.league,
  'teams': instance.teams,
  'goals': instance.goals,
  'score': instance.score,
  'events': instance.events,
};
