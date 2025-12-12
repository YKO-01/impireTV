// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTime _$EventTimeFromJson(Map<String, dynamic> json) => EventTime(
  elapsed: (json['elapsed'] as num?)?.toInt(),
  extra: (json['extra'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventTimeToJson(EventTime instance) => <String, dynamic>{
  'elapsed': instance.elapsed,
  'extra': instance.extra,
};
