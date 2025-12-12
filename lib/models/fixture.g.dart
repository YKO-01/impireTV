// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fixture _$FixtureFromJson(Map<String, dynamic> json) => Fixture(
  id: (json['id'] as num?)?.toInt(),
  date: json['date'] as String?,
  timestamp: (json['timestamp'] as num?)?.toInt(),
  status: json['status'] == null
      ? null
      : Status.fromJson(json['status'] as Map<String, dynamic>),
  venue: json['venue'] == null
      ? null
      : Venue.fromJson(json['venue'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FixtureToJson(Fixture instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'timestamp': instance.timestamp,
  'status': instance.status,
  'venue': instance.venue,
};
