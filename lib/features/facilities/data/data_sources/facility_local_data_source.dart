import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class FacilityLocalDataSource {
  Future<List<Facility>> getFacilities();
  Future<List<Facility>> searchFacilities(String? searchText);
  Future<List<Facility>> filterFacilities(String? cityFilter);
  Future<Facility?> getOneFacility(String id);
  List<String> generateAllTimeSlots(String dailyOpen, String dailyClose);
  Future<List<Booking>> getAllBookings();
  Future<bool> saveBooking(Booking booking);
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

  @override
  Future<Facility?> getOneFacility(String id) async {
    try {
      final facilities = await getFacilities();

      return facilities.firstWhere((facility) => facility.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  List<String> generateAllTimeSlots(String dailyOpen, String dailyClose) {
    final List<String> slots = [];
    final openTime = _parseTime(dailyOpen);
    final closeTime = _parseTime(dailyClose);

    DateTime current = openTime;
    while (current.isBefore(closeTime)) {
      slots.add(_formatTime(current));
      current = current.add(const Duration(minutes: 30));
    }

    return slots;
  }

  @override
  Future<List<Booking>> getAllBookings() async {
    try {
      final String? bookingsJson = serviceLocator<SharedPreferences>()
          .getString("bookings");
      if (bookingsJson == null || bookingsJson.isEmpty) {
        return [];
      }

      final List<dynamic> bookingsList = json.decode(bookingsJson);
      return bookingsList
          .map((json) => Booking.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error loading bookings: $e');
      return [];
    }
  }

  @override
  Future<bool> saveBooking(Booking booking) async {
    try {
      final bookings = await getAllBookings();
      bookings.add(booking);

      final String bookingsJson = json.encode(
        bookings.map((b) => b.toJson()).toList(),
      );

      return await serviceLocator<SharedPreferences>().setString(
        "bookings",
        bookingsJson,
      );
    } catch (e) {
      print('Error saving booking: $e');
      return false;
    }
  }

  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final jiffy = Jiffy.parse(time, pattern: "HH:mm");
    return DateTime(
      now.year,
      now.month,
      now.day,
      jiffy.dateTime.hour,
      jiffy.dateTime.minute,
    );
  }

  String _formatTime(DateTime time) {
    return Jiffy.parseFromDateTime(time).format(pattern: "HH:mm");
  }
}
