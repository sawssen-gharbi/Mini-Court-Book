import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class GetBookingsUseCase {
  final FacilityRepository facilityRepository;

  GetBookingsUseCase({required this.facilityRepository});

  Future<List<Booking>> call() async {
    return await facilityRepository.getAllBookings();
  }
}
