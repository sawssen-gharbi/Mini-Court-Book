import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';

sealed class FacilityLocalDataSource {
  Future<List<Facility>> getFacilities();
  Future<List<Facility>> searchFacilities(String? searchText);
  Future<List<Facility>> filterFacilities(String? cityFilter);
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

  @override
  Future<List<Facility>> searchFacilities(String? searchText) async {
    try {
      final facilities = await getFacilities();

      return facilities.where((facility) {
        if (searchText != null && searchText.isNotEmpty) {
          final searchLower = searchText.toLowerCase();
          final matchesName = facility.name.toLowerCase().contains(searchLower);
          final matchesCity = facility.city.toLowerCase().contains(searchLower);
          final matchesSport = facility.sports.any(
            (sport) => sport.toLowerCase().contains(searchLower),
          );

          if (!matchesName && !matchesCity && !matchesSport) {
            return false;
          }
        }
        return true;
      }).toList();
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }

  @override
  Future<List<Facility>> filterFacilities(String? cityFilter) async {
    try {
      final facilities = await getFacilities();

      return facilities.where((facility) {
        if (cityFilter != null && cityFilter.isNotEmpty) {
          if (facility.city != cityFilter) {
            return false;
          }
        }

        return true;
      }).toList();
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }
}
