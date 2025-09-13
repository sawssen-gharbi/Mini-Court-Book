import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class SearchFacilitiesUseCase {
  final FacilityRepository facilityRepository;

  SearchFacilitiesUseCase({required this.facilityRepository});

  Future<List<Facility>> call(String? searchText) async {
    return await facilityRepository.searchFacilities(searchText);
  }
}
