// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goals _$GoalsFromJson(Map<String, dynamic> json) => Goals(
  home: (json['home'] as num?)?.toInt(),
  away: (json['away'] as num?)?.toInt(),
);

Map<String, dynamic> _$GoalsToJson(Goals instance) => <String, dynamic>{
  'home': instance.home,
  'away': instance.away,
};
