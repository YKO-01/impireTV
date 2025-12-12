import 'package:json_annotation/json_annotation.dart';

part 'standing_goals.g.dart';

@JsonSerializable()
class StandingGoals {
  @JsonKey(name: 'for')
  final int forGoals;
  final int against;

  StandingGoals({
    required this.forGoals,
    required this.against,
  });

  factory StandingGoals.fromJson(Map<String, dynamic> json) =>
      _$StandingGoalsFromJson(json);

  Map<String, dynamic> toJson() => _$StandingGoalsToJson(this);
}


