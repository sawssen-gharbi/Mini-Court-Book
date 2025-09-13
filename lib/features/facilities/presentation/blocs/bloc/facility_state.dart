part of 'facility_bloc.dart';

sealed class FacilitiesState extends Equatable {
  const FacilitiesState();

  @override
  List<Object> get props => [];
}

final class FacilityInitial extends FacilitiesState {}

class FacilitiesLoading extends FacilitiesState {}

class FacilitiesLoaded extends FacilitiesState {
  final List<Facility> facilities;
  const FacilitiesLoaded({required this.facilities});
}

class FacilitiesError extends FacilitiesState {
  final String message;

  const FacilitiesError(this.message);
}

class FacilitiesEmpty extends FacilitiesState {
  final String message;

  const FacilitiesEmpty({this.message = 'No facilities found.'});
}
