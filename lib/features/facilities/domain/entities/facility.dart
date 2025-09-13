import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mini_court_book/features/facilities/domain/entities/court.dart';

part '../../data/models/facility.g.dart';

@JsonSerializable()
class Facility extends Equatable {
  final String id;
  final String name;
  final String city;
  final List<String> sports;
  final String thumbnail;
  final List<Court> courts;

  const Facility({
    required this.id,
    required this.name,
    required this.city,
    required this.sports,
    required this.thumbnail,
    required this.courts,
  });

  factory Facility.fromJson(Map<String, dynamic> json) =>
      _$FacilityFromJson(json);
  Map<String, dynamic> toJson() => _$FacilityToJson(this);

  @override
  List<Object?> get props => [id, name, city, sports, thumbnail, courts];
}
