part of 'facility_bloc.dart';

sealed class FacilityState extends Equatable {
  const FacilityState();

  @override
  List<Object> get props => [];
}

final class FacilityInitial extends FacilityState {}

class FacilitiesLoading extends FacilityState {}

class FacilitiesLoaded extends FacilityState {
  final List<Facility> facilities;
  const FacilitiesLoaded({required this.facilities});
}

class FacilitiesError extends FacilityState {
  final String message;

  const FacilitiesError(this.message);
}

class FacilitiesEmpty extends FacilityState {
  final String message;

  const FacilitiesEmpty({this.message = 'No facilities found.'});
}
