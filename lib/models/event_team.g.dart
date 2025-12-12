// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTeam _$EventTeamFromJson(Map<String, dynamic> json) => EventTeam(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  logo: json['logo'] as String?,
);

Map<String, dynamic> _$EventTeamToJson(EventTeam instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logo': instance.logo,
};
