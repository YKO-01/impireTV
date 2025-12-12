import 'package:json_annotation/json_annotation.dart';
import 'standing_league.dart';

part 'standing.g.dart';

@JsonSerializable()
class Standing {
  final StandingLeague league;

  Standing({
    required this.league,
  });

  factory Standing.fromJson(Map<String, dynamic> json) =>
      _$StandingFromJson(json);

  Map<String, dynamic> toJson() => _$StandingToJson(this);
}


