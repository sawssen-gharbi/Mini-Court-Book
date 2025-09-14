import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class SaveBookingUseCase {
  final FacilityRepository facilityRepository;

  SaveBookingUseCase({required this.facilityRepository});

  Future<bool> call(Booking booking) async {
    return await facilityRepository.saveBooking(booking);
  }
}
