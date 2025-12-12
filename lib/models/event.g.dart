// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
  time: json['time'] == null
      ? null
      : EventTime.fromJson(json['time'] as Map<String, dynamic>),
  team: json['team'] == null
      ? null
      : EventTeam.fromJson(json['team'] as Map<String, dynamic>),
  player: json['player'] == null
      ? null
      : EventPlayer.fromJson(json['player'] as Map<String, dynamic>),
  assist: json['assist'] == null
      ? null
      : EventPlayer.fromJson(json['assist'] as Map<String, dynamic>),
  type: json['type'] as String?,
  detail: json['detail'] as String?,
  comments: json['comments'] as String?,
);

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
  'time': instance.time,
  'team': instance.team,
  'player': instance.player,
  'assist': instance.assist,
  'type': instance.type,
  'detail': instance.detail,
  'comments': instance.comments,
};
