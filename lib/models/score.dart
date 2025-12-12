import 'package:json_annotation/json_annotation.dart';
import 'score_detail.dart';

part 'score.g.dart';

@JsonSerializable()
class Score {
  final ScoreDetail? halftime;
  final ScoreDetail? fulltime;

  Score({
    this.halftime,
    this.fulltime,
  });

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreToJson(this);
}


