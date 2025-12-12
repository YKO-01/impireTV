import 'package:json_annotation/json_annotation.dart';

part 'goals.g.dart';

@JsonSerializable()
class Goals {
  final int? home;
  final int? away;

  Goals({
    this.home,
    this.away,
  });

  factory Goals.fromJson(Map<String, dynamic> json) => _$GoalsFromJson(json);

  Map<String, dynamic> toJson() => _$GoalsToJson(this);
}

