import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part '../../data/models/court.g.dart';

@JsonSerializable()
class Court extends Equatable {
  final String id;
  final String sport;
  final String label;
  final double price;
  final int slotMinutes;
  final String dailyOpen;
  final String dailyClose;

  const Court({
    required this.id,
    required this.sport,
    required this.label,
    required this.price,
    this.slotMinutes = 60,
    this.dailyOpen = '09:00',
    this.dailyClose = '21:00',
  });

  factory Court.fromJson(Map<String, dynamic> json) => _$CourtFromJson(json);
  Map<String, dynamic> toJson() => _$CourtToJson(this);

  @override
  List<Object?> get props => [
    id,
    sport,
    label,
    price,
    slotMinutes,
    dailyOpen,
    dailyClose,
  ];
}
