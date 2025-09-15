import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';
import 'package:mini_court_book/core/theme/theme.dart';
import 'package:mini_court_book/features/bookings/presentation/blocs/bloc/my_booking_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/empty_state_widget.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyBookingBloc>().add(LoadMyBookings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings'), elevation: 0),
      body: BlocConsumer<MyBookingBloc, MyBookingState>(
        listener: (context, state) {
          if (state is BookingDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is MyBookingsEmpty) {
            return EmptyStateWidget(
              icon: Icons.calendar_today_outlined,
              title: state.message,
              subtitle: 'Start by browsing available facilities',
            );
          }
          if (state is MyBookingsLoading) {
          } else if (state is MyBookingsLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<MyBookingBloc>().add(LoadMyBookings());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.bookings.length,
                itemBuilder: (context, index) {
                  final booking = state.bookings[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Facility name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    booking.facilityName,
                                    style: AppTheme.theme.textTheme.bodyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Court info
                            Text(
                              booking.courtLabel,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 12),

                            // Date
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  DateFormat(
                                    'EEEE, MMM d, yyyy',
                                  ).format(booking.date),
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            // Time
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${booking.startTime} - ${booking.endTime}",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Price + Cancel button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${booking.price.toStringAsFixed(0)} TND",
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('Cancel Booking'),
                                          content: Text(
                                            "Are you sure you want to cancel ${booking.facilityName}?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('Keep Booking'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                context
                                                    .read<MyBookingBloc>()
                                                    .add(
                                                      DeleteBooking(
                                                        booking.id!,
                                                      ),
                                                    );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                              child: const Text(
                                                style: TextStyle(
                                                  color: AppPalette
                                                      .textPrimaryColor,
                                                ),
                                                'Cancel Booking',
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.cancel, size: 20),
                                  label: const Text('Cancel'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is MyBookingsError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
