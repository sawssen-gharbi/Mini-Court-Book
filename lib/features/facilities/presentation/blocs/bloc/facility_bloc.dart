import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/facilities/domain/entities/court.dart';
import 'package:mini_court_book/features/facilities/domain/entities/facility.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/filter_facilities.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/generate_time_slots.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/get_facilities.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/get_one_facility.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/save_booking.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/search_facilities.dart';

part 'facility_event.dart';
part 'facility_state.dart';

class FacilityBloc extends Bloc<FacilityEvent, FacilityState> {
  final GetFacilitiesUseCase getFacilities;
  final SearchFacilitiesUseCase searchFacilities;
  final FilterFacilitiesUseCase filterFacilities;
  final GetOneFacilityUseCase getOneFacility;
  final GenerateTimeSlotsUseCase generateTimeSlots;
  final SaveBookingUseCase saveBooking;
  FacilityBloc(
    this.getFacilities,
    this.searchFacilities,
    this.filterFacilities,
    this.getOneFacility,
    this.generateTimeSlots,
    this.saveBooking,
  ) : super(FacilityInitial()) {
    on<LoadFacilities>(_onLoadFacilities);
    on<SearchFacilities>(_onSearchFacilities);
    on<FilterFacilities>(_onFilterFacilities);
    on<LoadFacilityDetails>(_onLoadFacilityDetails);
    on<SelectCourt>(_onSelectCourt);
    on<SelectDate>(_onSelectDate);
    on<SelectTime>(_onSelectTime);
    on<LoadAvailableTimeSlots>(_onLoadAvailableTimeSlots);
    on<CreateBooking>(_onCreateBooking);

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

  Future<void> _onLoadFacilityDetails(
    LoadFacilityDetails event,
    Emitter<FacilityState> emit,
  ) async {
    emit(FacilityDetailsLoading());

    try {
      final facility = await getOneFacility(event.facilityId);
      if (facility == null) {
        emit(FacilityDetailsError("Facility not found"));
      } else {
        emit(FacilityDetailsLoaded(facility: facility));
      }
    } catch (e) {
      emit(FacilityDetailsError(e.toString()));
    }
  }

  Future<void> _onSelectCourt(
    SelectCourt event,
    Emitter<FacilityState> emit,
  ) async {
    if (state is FacilityDetailsLoaded) {
      final currentState = state as FacilityDetailsLoaded;

      emit(
        currentState.copyWith(
          selectedCourt: event.court,
          selectedTime: null,
          allTimeSlots: [],
          availableTimeSlots: [],
        ),
      );
    }
  }

  Future<void> _onSelectDate(
    SelectDate event,
    Emitter<FacilityState> emit,
  ) async {
    if (state is FacilityDetailsLoaded) {
      final currentState = state as FacilityDetailsLoaded;

      emit(
        currentState.copyWith(
          selectedDate: event.date,
          selectedTime: null,
          allTimeSlots: [],
          availableTimeSlots: [],
        ),
      );

      if (currentState.selectedCourt != null) {
        add(LoadAvailableTimeSlots());
      }
    }
  }

  Future<void> _onLoadAvailableTimeSlots(
    LoadAvailableTimeSlots event,
    Emitter<FacilityState> emit,
  ) async {
    if (state is FacilityDetailsLoaded) {
      final currentState = state as FacilityDetailsLoaded;

      if (currentState.selectedCourt == null ||
          currentState.selectedDate == null) {
        return;
      }

      emit(currentState.copyWith(isLoadingSlots: true));

      try {
        final allSlots = generateTimeSlots(
          currentState.selectedCourt!.dailyOpen,
          currentState.selectedCourt!.dailyClose,
        );

        emit(
          currentState.copyWith(
            allTimeSlots: await allSlots,
            isLoadingSlots: false,
          ),
        );
      } catch (e) {
        emit(FacilityDetailsError(e.toString()));
      }
    }
  }

  Future<void> _onSelectTime(
    SelectTime event,
    Emitter<FacilityState> emit,
  ) async {
    if (state is FacilityDetailsLoaded) {
      final currentState = state as FacilityDetailsLoaded;
      emit(currentState.copyWith(selectedTime: event.startTime));
    }
  }

  Future<void> _onCreateBooking(
    CreateBooking event,
    Emitter<FacilityState> emit,
  ) async {
    if (state is FacilityDetailsLoaded) {
      final currentState = state as FacilityDetailsLoaded;

      if (!currentState.canCreateBooking) {
        emit(const FacilityDetailsError('Please complete all booking details'));
        await Future.delayed(const Duration(seconds: 2));
        emit(currentState);
        return;
      }

      emit(BookingCreating());

      try {
        final success = await saveBooking(event.booking);

   

        if (success) {
          emit(BookingCreated(event.booking));
        } else {
          emit(const BookingError('Failed to save booking'));
          await Future.delayed(const Duration(seconds: 2));
          emit(currentState);
        }
      } catch (e) {
        emit(BookingError(e.toString()));
        await Future.delayed(const Duration(seconds: 2));
        emit(currentState);
      }
    }
  }
}
