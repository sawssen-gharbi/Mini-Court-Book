import 'package:flutter_test/flutter_test.dart';
import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/facilities/data/data_sources/facility_local_data_source.dart';

void main() {
  group('generateAllTimeSlots', () {
    test('generates correct 30-minute time slots', () {
      final slots = FacilityLocalDataSourceImpl().generateAllTimeSlots(
        '09:00',
        '12:00',
      );

      expect(slots, ['09:00', '09:30', '10:00', '10:30', '11:00', '11:30']);
    });
  });

  group('hasOverlap', () {
    test('detects overlap when new booking starts during existing booking', () {
      final existingBookings = [
        Booking(
          id: 'test1',
          facilityId: 'facility1',
          facilityName: 'Test Facility',
          courtId: 'court1',
          courtLabel: 'Court 1',
          date: DateTime.now(),
          startTime: '10:00',
          endTime: '11:00',
          price: 50.0,
          createdAt: DateTime.now(),
        ),
      ];

      final hasOverlap = FacilityLocalDataSourceImpl().hasOverlap(
        startTime: '10:30',
        endTime: '11:30',
        existingBookings: existingBookings,
      );

      expect(hasOverlap, true);
    });
  });
}
