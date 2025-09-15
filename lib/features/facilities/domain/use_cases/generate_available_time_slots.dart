import 'package:mini_court_book/features/facilities/domain/entities/court.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class GenerateAvailableTimeSlotsUseCase {
  final FacilityRepository facilityRepository;

  GenerateAvailableTimeSlotsUseCase({required this.facilityRepository});

  Future<List<String>> call({
    required String courtId,
    required DateTime date,
    required Court court,
  }) async {
    return facilityRepository.getAvailableTimeSlotsForCourt(
      courtId: courtId,
      date: date,
      court: court,
    );
  }
}
