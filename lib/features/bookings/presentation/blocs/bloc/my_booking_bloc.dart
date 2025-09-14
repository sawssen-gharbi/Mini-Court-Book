import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/delete_booking.dart';
import 'package:mini_court_book/features/facilities/domain/use_cases/get_bookings.dart';

part 'my_booking_event.dart';
part 'my_booking_state.dart';

class MyBookingBloc extends Bloc<MyBookingEvent, MyBookingState> {
  final GetBookingsUseCase getBookings;
  final DeleteBookingUseCase deleteBooking;
  MyBookingBloc(this.getBookings, this.deleteBooking) : super(MyBookingInitial()) {
    on<LoadMyBookings>(_onLoadMyBookings);
    on<DeleteBooking>(_onDeleteBooking);
  }
  Future<void> _onLoadMyBookings(
    LoadMyBookings event,
    Emitter<MyBookingState> emit,
  ) async {
    emit(MyBookingsLoading());

    try {
      final bookings = await getBookings();

      if (bookings.isEmpty) {
        emit(const MyBookingsEmpty());
      } else {
        emit(MyBookingsLoaded(bookings: bookings));
      }
    } catch (e) {
      emit(MyBookingsError(e.toString()));
    }
  }

  Future<void> _onDeleteBooking(
    DeleteBooking event,
    Emitter<MyBookingState> emit,
  ) async {
    final currentState = state;

    emit(BookingDeleting(event.bookingId));

    try {
      final success = await deleteBooking(event.bookingId);

      if (success) {
        emit(const BookingDeleted());

  
        await Future.delayed(const Duration(milliseconds: 500));
        add(LoadMyBookings());
      } else {
        emit(const MyBookingsError('Failed to delete booking'));

        await Future.delayed(const Duration(seconds: 2));
        if (currentState is MyBookingsLoaded) {
          emit(currentState);
        } else {
          add(LoadMyBookings());
        }
      }
    } catch (e) {
      emit(MyBookingsError(e.toString()));
      await Future.delayed(const Duration(seconds: 2));
      if (currentState is MyBookingsLoaded) {
        emit(currentState);
      } else {
        add(LoadMyBookings());
      }
    }
  }
}
