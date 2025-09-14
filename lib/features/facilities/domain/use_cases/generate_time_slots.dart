import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class GenerateTimeSlotsUseCase {
  final FacilityRepository facilityRepository;

  GenerateTimeSlotsUseCase({required this.facilityRepository});

  Future<List<String>> call(String dailyOpen, String dailyClose) async {
    return facilityRepository.generateAllTimeSlots(dailyOpen, dailyClose);
  }
}
