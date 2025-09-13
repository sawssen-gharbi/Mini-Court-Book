import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/features/facilities/domain/repositories/facility_repository.dart';

part 'facility_event.dart';
part 'facility_state.dart';

class FacilityBloc extends Bloc<FacilityEvent, FacilitiesState> {
  final FacilityRepository _facilityRepository;
  FacilityBloc(this._facilityRepository) : super(FacilityInitial()) {
    on<LoadFacilities>(_onLoadFacilities);
  }

  Future<void> _onLoadFacilities(
    LoadFacilities event,
    Emitter<FacilitiesState> emit,
  ) async {
    emit(FacilitiesLoading());

    try {
      final facilities = await _facilityRepository.getFacilities();

      if (facilities.isEmpty) {
        emit(const FacilitiesEmpty());
      } else {
        emit(FacilitiesLoaded(facilities: facilities));
      }
    } catch (e) {
      emit(FacilitiesError(e.toString()));
    }
  }
}
