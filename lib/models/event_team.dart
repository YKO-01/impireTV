import 'package:json_annotation/json_annotation.dart';

part 'event_team.g.dart';

@JsonSerializable()
class EventTeam {
  final int? id;
  final String? name;
  final String? logo;

  EventTeam({
    this.id,
    this.name,
    this.logo,
  });

  factory EventTeam.fromJson(Map<String, dynamic> json) =>
      _$EventTeamFromJson(json);

  Map<String, dynamic> toJson() => _$EventTeamToJson(this);
}


