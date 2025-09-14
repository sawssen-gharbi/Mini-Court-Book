part of 'my_booking_bloc.dart';

sealed class MyBookingEvent extends Equatable {
  const MyBookingEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyBookings extends MyBookingEvent {}

class DeleteBooking extends MyBookingEvent {
  final String bookingId;

  const DeleteBooking(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class RefreshMyBookings extends MyBookingEvent {}
