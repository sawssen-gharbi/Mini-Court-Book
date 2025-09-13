import 'package:mini_court_book/features/facilities/data/data_sources/facility_local_data_source.dart';
import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

class FacilityRepositoryImpl implements FacilityRepository {
  final FacilityLocalDataSource facilityLocalDataSource;

  FacilityRepositoryImpl({required this.facilityLocalDataSource});

  @override
  Future<List<Facility>> getFacilities() async {
    try {
      return facilityLocalDataSource.getFacilities();
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }

  @override
  Future<List<Facility>> searchFacilities(String? searchText) {
    try {
      return facilityLocalDataSource.searchFacilities(searchText);
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }

  @override
  Future<List<Facility>> filterFacilities(String? cityFilter) {
    try {
      return facilityLocalDataSource.filterFacilities(cityFilter);
    } catch (e) {
      throw Exception('Failed to load facilities: $e');
    }
  }
}
