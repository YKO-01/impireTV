// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
  halftime: json['halftime'] == null
      ? null
      : ScoreDetail.fromJson(json['halftime'] as Map<String, dynamic>),
  fulltime: json['fulltime'] == null
      ? null
      : ScoreDetail.fromJson(json['fulltime'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
  'halftime': instance.halftime,
  'fulltime': instance.fulltime,
};
