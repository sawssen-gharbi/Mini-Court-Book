part of 'my_booking_bloc.dart';

sealed class MyBookingState extends Equatable {
  const MyBookingState();

  @override
  List<Object?> get props => [];
}

class MyBookingInitial extends MyBookingState {}

class MyBookingsLoading extends MyBookingState {}

class MyBookingsLoaded extends MyBookingState {
  final List<Booking> bookings;


  const MyBookingsLoaded({
    required this.bookings,
  });

  @override
  List<Object?> get props => [bookings,];
}

class MyBookingsEmpty extends MyBookingState {
  final String message;

  const MyBookingsEmpty({this.message = 'No bookings yet'});

  @override
  List<Object?> get props => [message];
}

class MyBookingsError extends MyBookingState {
  final String message;

  const MyBookingsError(this.message);

  @override
  List<Object?> get props => [message];
}

class BookingDeleting extends MyBookingState {
  final String bookingId;

  const BookingDeleting(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class BookingDeleted extends MyBookingState {
  final String message;

  const BookingDeleted({this.message = 'Booking deleted successfully'});

  @override
  List<Object?> get props => [message];
}
