import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status {
  @JsonKey(name: 'long')
  final String? long;
  @JsonKey(name: 'short')
  final String? short;

  Status({
    this.long,
    this.short,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);
}


