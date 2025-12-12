// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScoreDetail _$ScoreDetailFromJson(Map<String, dynamic> json) => ScoreDetail(
  home: (json['home'] as num?)?.toInt(),
  away: (json['away'] as num?)?.toInt(),
);

Map<String, dynamic> _$ScoreDetailToJson(ScoreDetail instance) =>
    <String, dynamic>{'home': instance.home, 'away': instance.away};
