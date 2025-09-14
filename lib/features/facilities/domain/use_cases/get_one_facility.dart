import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class GetOneFacilityUseCase {
  final FacilityRepository facilityRepository;

  GetOneFacilityUseCase({required this.facilityRepository});

   Future<Facility?> call(String id) async {
    return await facilityRepository.getOneFacility(id);
  }
}
