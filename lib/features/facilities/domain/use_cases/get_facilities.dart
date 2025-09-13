import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class GetFacilitiesUseCase {
  final FacilityRepository facilityRepository;

  GetFacilitiesUseCase({required this.facilityRepository});

  Future<List<Facility>> call() async {
    return await facilityRepository.getFacilities();
  }
}
