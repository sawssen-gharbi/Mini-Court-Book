part of 'facility_bloc.dart';

sealed class FacilityEvent extends Equatable {
  const FacilityEvent();

  @override
  List<Object?> get props => [];
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

class LoadFacilityDetails extends FacilityEvent {
  final String facilityId;

  const LoadFacilityDetails(this.facilityId);

  @override
  List<Object?> get props => [facilityId];
}

class SelectCourt extends FacilityEvent {
  final Court court;

  const SelectCourt(this.court);

  @override
  List<Object?> get props => [court];
}

class SelectDate extends FacilityEvent {
  final DateTime date;

  const SelectDate(this.date);

  @override
  List<Object?> get props => [date];
}

class SelectTime extends FacilityEvent {
  final String startTime;

  const SelectTime(this.startTime);

  @override
  List<Object?> get props => [startTime];
}

class LoadAvailableTimeSlots extends FacilityEvent {}

class RefreshTimeSlots extends FacilityEvent {}

class CreateBooking extends FacilityEvent {}

class ResetBookingForm extends FacilityEvent {}
