import 'package:json_annotation/json_annotation.dart';

part 'event_player.g.dart';

@JsonSerializable()
class EventPlayer {
  final int? id;
  final String? name;

  EventPlayer({
    this.id,
    this.name,
  });

  factory EventPlayer.fromJson(Map<String, dynamic> json) =>
      _$EventPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$EventPlayerToJson(this);
}


