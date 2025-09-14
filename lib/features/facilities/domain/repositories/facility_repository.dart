import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';

abstract class FacilityRepository {
  Future<List<Facility>> getFacilities();
  Future<List<Facility>> searchFacilities(String? searchText);
  Future<List<Facility>> filterFacilities(String? cityFilter);
  Future<Facility?> getOneFacility(String id);
  List<String> generateAllTimeSlots(String dailyOpen, String dailyClose);
  Future<List<Booking>> getAllBookings();
  Future<bool> saveBooking(Booking booking);
}
