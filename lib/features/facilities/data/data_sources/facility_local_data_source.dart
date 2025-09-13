import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';

sealed class FacilityLocalDataSource {
  Future<List<Facility>> getFacilities();
}

class FacilityLocalDataSourceImpl implements FacilityLocalDataSource {
  @override
  Future<List<Facility>> getFacilities() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/facilities.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> facilitiesJson = jsonData['facilities'];

      return facilitiesJson
          .map((json) => Facility.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }
}
