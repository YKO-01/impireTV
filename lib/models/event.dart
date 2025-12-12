import 'package:json_annotation/json_annotation.dart';
import 'event_time.dart';
import 'event_team.dart';
import 'event_player.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final EventTime? time;
  final EventTeam? team;
  final EventPlayer? player;
  final EventPlayer? assist;
  final String? type;
  final String? detail;
  final String? comments;

  Event({
    this.time,
    this.team,
    this.player,
    this.assist,
    this.type,
    this.detail,
    this.comments,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}


