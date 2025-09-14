import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part '../../data/models/booking.g.dart';

@JsonSerializable()
class Booking extends Equatable {
  final String? id;
  final String facilityId;
  final String facilityName;
  final String courtId;
  final String courtLabel;
  final DateTime date;
  final String startTime;
  final String endTime;
  final double price;
  final DateTime createdAt;

  const Booking({
     this.id,
    required this.facilityId,
    required this.facilityName,
    required this.courtId,
    required this.courtLabel,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);

  @override
  List<Object?> get props => [
    id,
    facilityId,
    facilityName,
    courtId,
    courtLabel,
    date,
    startTime,
    endTime,
    price,
    createdAt,
  ];
}
