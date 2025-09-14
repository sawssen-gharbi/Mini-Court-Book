
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class DeleteBookingUseCase {
  final FacilityRepository facilityRepository;

  DeleteBookingUseCase({required this.facilityRepository});

  Future<bool> call(String bookingId) async {
    return await facilityRepository.deleteBooking(bookingId);
  }
}
