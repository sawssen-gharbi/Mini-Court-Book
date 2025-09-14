// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../domain/entities/booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
  id: json['id'] as String,
  facilityId: json['facilityId'] as String,
  facilityName: json['facilityName'] as String,
  courtId: json['courtId'] as String,
  courtLabel: json['courtLabel'] as String,
  date: DateTime.parse(json['date'] as String),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  price: (json['price'] as num).toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
  'id': instance.id,
  'facilityId': instance.facilityId,
  'facilityName': instance.facilityName,
  'courtId': instance.courtId,
  'courtLabel': instance.courtLabel,
  'date': instance.date.toIso8601String(),
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'price': instance.price,
  'createdAt': instance.createdAt.toIso8601String(),
};
