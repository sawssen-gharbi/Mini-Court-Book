import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class FilterFacilitiesUseCase {
  final FacilityRepository facilityRepository;

  FilterFacilitiesUseCase({required this.facilityRepository});

  Future<List<Facility>> call(String? filterCity) async {
    return await facilityRepository.filterFacilities(filterCity);
  }
}
