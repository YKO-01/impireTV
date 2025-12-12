import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable()
class Team {
  final int? id;
  final String? name;
  final String? logo;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool? winner;

  Team({
    this.id,
    this.name,
    this.logo,
    this.winner,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}


