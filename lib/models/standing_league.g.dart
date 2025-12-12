// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing_league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StandingLeague _$StandingLeagueFromJson(Map<String, dynamic> json) =>
    StandingLeague(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      country: json['country'] as String,
      logo: json['logo'] as String,
      flag: json['flag'] as String,
      season: (json['season'] as num).toInt(),
      standings: (json['standings'] as List<dynamic>)
          .map(
            (e) => (e as List<dynamic>)
                .map((e) => StandingTeam.fromJson(e as Map<String, dynamic>))
                .toList(),
          )
          .toList(),
    );

Map<String, dynamic> _$StandingLeagueToJson(StandingLeague instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'logo': instance.logo,
      'flag': instance.flag,
      'season': instance.season,
      'standings': instance.standings,
    };
