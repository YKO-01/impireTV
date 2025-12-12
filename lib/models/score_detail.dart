import 'package:json_annotation/json_annotation.dart';

part 'score_detail.g.dart';

@JsonSerializable()
class ScoreDetail {
  final int? home;
  final int? away;

  ScoreDetail({
    this.home,
    this.away,
  });

  factory ScoreDetail.fromJson(Map<String, dynamic> json) =>
      _$ScoreDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreDetailToJson(this);
}


