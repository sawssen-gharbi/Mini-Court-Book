part of 'facility_bloc.dart';

class FacilityState extends Equatable {
  const FacilityState();

  @override
  List<Object?> get props => [];
}

final class FacilityInitial extends FacilityState {}

class FacilitiesLoading extends FacilityState {}

class FacilitiesLoaded extends FacilityState {
  final List<Facility> facilities;
  final List<Facility> filteredFacilities;
  final String? searchText;
  final String? cityFilter;

  const FacilitiesLoaded({
    required this.facilities,
    required this.filteredFacilities,
    this.searchText,
    this.cityFilter,
  });

  FacilitiesLoaded copyWith({
    List<Facility>? facilities,
    List<Facility>? filteredFacilities,
    String? searchText,
    String? cityFilter,
  }) {
    return FacilitiesLoaded(
      facilities: facilities ?? this.facilities,
      filteredFacilities: filteredFacilities ?? this.filteredFacilities,
      searchText: searchText,
      cityFilter: cityFilter,
    );
  }

  @override
  List<Object?> get props => [
    facilities,
    filteredFacilities,
    searchText,
    cityFilter,
  ];
}

class FacilitiesError extends FacilityState {
  final String message;

  const FacilitiesError(this.message);
}

class FacilitiesEmpty extends FacilityState {
  final String message;

  const FacilitiesEmpty({this.message = 'No facilities found.'});
}

class FacilityDetailsLoading extends FacilityState {}

class FacilityDetailsLoaded extends FacilityState {
  final Facility facility;
  final Court? selectedCourt;
  final DateTime? selectedDate;
  final String? selectedTime;
  final List<String> allTimeSlots;
  final List<String> availableTimeSlots;
  final bool isLoadingSlots;

  const FacilityDetailsLoaded({
    required this.facility,
    this.selectedCourt,
    this.selectedDate,
    this.selectedTime,
    this.allTimeSlots = const [],
    this.availableTimeSlots = const [],
    this.isLoadingSlots = false,
  });

  FacilityDetailsLoaded copyWith({
    Facility? facility,
    Court? selectedCourt,
    DateTime? selectedDate,
    String? selectedTime,
    List<String>? allTimeSlots,
    List<String>? availableTimeSlots,
    bool? isLoadingSlots,
  }) {
    return FacilityDetailsLoaded(
      facility: facility ?? this.facility,
      selectedCourt: selectedCourt ?? this.selectedCourt,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      allTimeSlots: allTimeSlots ?? this.allTimeSlots,
      availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
      isLoadingSlots: isLoadingSlots ?? this.isLoadingSlots,
    );
  }

  bool get canCreateBooking =>
      selectedCourt != null && selectedDate != null && selectedTime != null;

  @override
  List<Object?> get props => [
    facility,
    selectedCourt,
    selectedDate,
    selectedTime,
    allTimeSlots,
    availableTimeSlots,
    isLoadingSlots,
  ];
}

class FacilityDetailsError extends FacilityState {
  final String message;

  const FacilityDetailsError(this.message);
}
