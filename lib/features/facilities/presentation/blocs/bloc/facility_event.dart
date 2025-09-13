part of 'facility_bloc.dart';

sealed class FacilityEvent extends Equatable {
  const FacilityEvent();

  @override
  List<Object> get props => [];
}

class LoadFacilities extends FacilityEvent {}

class SearchFacilities extends FacilityEvent {
  final String searchText;

  const SearchFacilities(this.searchText);
}

class FilterFacilities extends FacilityEvent {
  final String cityFilter;

  const FilterFacilities(this.cityFilter);
}
