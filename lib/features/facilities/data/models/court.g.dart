// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../domain/entities/court.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Court _$CourtFromJson(Map<String, dynamic> json) => Court(
  id: json['id'] as String,
  sport: json['sport'] as String,
  label: json['label'] as String,
  price: (json['price'] as num).toDouble(),
  slotMinutes: (json['slotMinutes'] as num?)?.toInt() ?? 60,
  dailyOpen: json['dailyOpen'] as String? ?? '09:00',
  dailyClose: json['dailyClose'] as String? ?? '21:00',
);

Map<String, dynamic> _$CourtToJson(Court instance) => <String, dynamic>{
  'id': instance.id,
  'sport': instance.sport,
  'label': instance.label,
  'price': instance.price,
  'slotMinutes': instance.slotMinutes,
  'dailyOpen': instance.dailyOpen,
  'dailyClose': instance.dailyClose,
};
