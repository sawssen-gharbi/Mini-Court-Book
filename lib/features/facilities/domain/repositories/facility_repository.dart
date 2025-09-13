import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';

abstract class FacilityRepository {
  Future<List<Facility>> getFacilities();
}
