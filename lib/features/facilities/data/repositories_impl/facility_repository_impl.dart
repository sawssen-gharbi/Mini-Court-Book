import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/facilities/data/data_sources/facility_local_data_source.dart';
import 'package:mini_court_book/features/facilities/domain/entities/court.dart';
import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class FacilityRepositoryImpl implements FacilityRepository {
  final FacilityLocalDataSource facilityLocalDataSource;

  FacilityRepositoryImpl({required this.facilityLocalDataSource});

  @override
  Future<List<Facility>> getFacilities() async {
    try {
      return facilityLocalDataSource.getFacilities();
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }

  @override
  Future<List<Facility>> searchFacilities(String? searchText) {
    try {
      return facilityLocalDataSource.searchFacilities(searchText);
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }

  @override
  Future<List<Facility>> filterFacilities(String? cityFilter) {
    try {
      return facilityLocalDataSource.filterFacilities(cityFilter);
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }

  @override
  Future<Facility?> getOneFacility(String id) {
    try {
      return facilityLocalDataSource.getOneFacility(id);
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }

  @override
  List<String> generateAllTimeSlots(String dailyOpen, String dailyClose) {
    try {
      return facilityLocalDataSource.generateAllTimeSlots(
        dailyOpen,
        dailyClose,
      );
    } catch (e) {
      throw Exception('Failed to load slotd: $e');
    }
  }

  @override
  Future<List<Booking>> getAllBookings() {
    try {
      return facilityLocalDataSource.getAllBookings();
    } catch (e) {
      throw Exception('Failed to load bookings: $e');
    }
  }

  @override
  Future<bool> saveBooking(Booking booking) {
    try {
      return facilityLocalDataSource.saveBooking(booking);
    } catch (e) {
      throw Exception('Failed to save booking: $e');
    }
  }

  @override
  Future<bool> deleteBooking(String bookingId) {
    try {
      return facilityLocalDataSource.deleteBooking(bookingId);
    } catch (e) {
      throw Exception('Failed to delete booking: $e');
    }
  }

  @override
  Future<List<String>> getAvailableTimeSlotsForCourt({
    required String courtId,
    required DateTime date,
    required Court court,
  }) async {
    try {
      return facilityLocalDataSource.getAvailableTimeSlotsForCourt(
        courtId: courtId,
        date: date,
        court: court,
      );
    } catch (e) {
      throw Exception('Failed to load available slots: $e');
    }
  }
}
