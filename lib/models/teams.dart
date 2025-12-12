import 'package:json_annotation/json_annotation.dart';
import 'team.dart';

part 'teams.g.dart';

@JsonSerializable()
class Teams {
  final Team? home;
  final Team? away;

  Teams({
    this.home,
    this.away,
  });

  factory Teams.fromJson(Map<String, dynamic> json) => _$TeamsFromJson(json);

  Map<String, dynamic> toJson() => _$TeamsToJson(this);
}


