part of 'facility_bloc.dart';

sealed class FacilityEvent extends Equatable {
  const FacilityEvent();

  @override
  List<Object> get props => [];
}

class LoadFacilities extends FacilityEvent {}
