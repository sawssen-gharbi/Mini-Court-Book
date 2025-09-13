import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/filter_facilities.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/get_facilities.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/search_facilities.dart';

part 'facility_event.dart';
part 'facility_state.dart';

class FacilityBloc extends Bloc<FacilityEvent, FacilityState> {
  final GetFacilitiesUseCase getFacilities;
  final SearchFacilitiesUseCase searchFacilities;
  final FilterFacilitiesUseCase filterFacilities;
  FacilityBloc(this.getFacilities, this.searchFacilities, this.filterFacilities)
    : super(FacilityInitial()) {
    on<LoadFacilities>(_onLoadFacilities);
    on<SearchFacilities>(_onSearchFacilities);
    on<FilterFacilities>(_onFilterFacilities);
  }

  Future<void> _onLoadFacilities(
    LoadFacilities event,
    Emitter<FacilityState> emit,
  ) async {
    emit(FacilitiesLoading());

    try {
      final facilities = await getFacilities();

      if (facilities.isEmpty) {
        emit(const FacilitiesEmpty());
      } else {
        emit(
          FacilitiesLoaded(
            facilities: facilities,
            filteredFacilities: facilities,
          ),
        );
      }
    } catch (e) {
      emit(FacilitiesError(e.toString()));
    }
  }

  Future<void> _onSearchFacilities(
    SearchFacilities event,
    Emitter<FacilityState> emit,
  ) async {
    try {
      if (state is FacilitiesLoaded) {
        final filteredFacilities = await searchFacilities(event.searchText);

        emit(
          (state as FacilitiesLoaded).copyWith(
            filteredFacilities: filteredFacilities,
          ),
        );
      }
    } catch (e) {
      emit(FacilitiesError(e.toString()));
    }
  }

  Future<void> _onFilterFacilities(
    FilterFacilities event,
    Emitter<FacilityState> emit,
  ) async {
    try {
      if (state is FacilitiesLoaded) {
        final filteredFacilities = await filterFacilities(event.cityFilter);

        emit(
          (state as FacilitiesLoaded).copyWith(
            filteredFacilities: filteredFacilities,
          ),
        );
      }
    } catch (e) {
      emit(FacilitiesError(e.toString()));
    }
  }
}
