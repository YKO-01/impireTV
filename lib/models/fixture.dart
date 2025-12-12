import 'package:json_annotation/json_annotation.dart';
import 'status.dart';
import 'venue.dart';

part 'fixture.g.dart';

@JsonSerializable()
class Fixture {
  final int? id;
  final String? date;
  final int? timestamp;
  final Status? status;
  final Venue? venue;

  Fixture({
    this.id,
    this.date,
    this.timestamp,
    this.status,
    this.venue,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) =>
      _$FixtureFromJson(json);

  Map<String, dynamic> toJson() => _$FixtureToJson(this);
}


