import 'package:json_annotation/json_annotation.dart';

part 'event_time.g.dart';

@JsonSerializable()
class EventTime {
  final int? elapsed;
  final int? extra;

  EventTime({
    this.elapsed,
    this.extra,
  });

  factory EventTime.fromJson(Map<String, dynamic> json) =>
      _$EventTimeFromJson(json);

  Map<String, dynamic> toJson() => _$EventTimeToJson(this);
}


