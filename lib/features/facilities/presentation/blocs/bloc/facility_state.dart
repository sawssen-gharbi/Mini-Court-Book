part of 'facility_bloc.dart';

class FacilityState extends Equatable {
  const FacilityState();

  @override
  List<Object> get props => [];
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
      searchText: searchText ?? this.searchText,
      cityFilter: cityFilter ?? this.cityFilter,
    );
  }

  @override
  List<Object> get props => [
    facilities,
    filteredFacilities,
    searchText!,
    cityFilter!,
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
