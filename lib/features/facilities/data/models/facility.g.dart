// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../domain/entities/facility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Facility _$FacilityFromJson(Map<String, dynamic> json) => Facility(
  id: json['id'] as String,
  name: json['name'] as String,
  city: json['city'] as String,
  sports: (json['sports'] as List<dynamic>).map((e) => e as String).toList(),
  thumbnail: json['thumbnail'] as String,
  courts: (json['courts'] as List<dynamic>)
      .map((e) => Court.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FacilityToJson(Facility instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'city': instance.city,
  'sports': instance.sports,
  'thumbnail': instance.thumbnail,
  'courts': instance.courts,
};
