import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jiffy/jiffy.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';
import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/bookings/presentation/blocs/bloc/my_booking_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/blocs/bloc/facility_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/booking_summary_widget.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/court_card_widget.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/facility_info_widget.dart';

import 'package:uuid/uuid.dart';

class FacilityDetailsScreen extends StatefulWidget {
  final String facilityName;
  final String facilityId;
  const FacilityDetailsScreen({
    super.key,
    required this.facilityId,
    required this.facilityName,
  });

  @override
  State<FacilityDetailsScreen> createState() => _FacilityDetailsScreenState();
}

class _FacilityDetailsScreenState extends State<FacilityDetailsScreen> {
  //var
  final ScrollController _scrollController = ScrollController();
  //func
  @override
  void initState() {
    super.initState();
    context.read<FacilityBloc>().add(LoadFacilityDetails(widget.facilityId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<FacilityBloc, FacilityState>(
        listener: (context, state) {
          if (state is BookingError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppPalette.errorColor,
              ),
            );
          } else if (state is BookingCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Booking created successfully!'),
                backgroundColor: AppPalette.primaryColor,
              ),
            );
            context.read<MyBookingBloc>().add(LoadMyBookings());
            Navigator.pop(context, true);
          }
        },
        builder: (context, state) {
          if (state is FacilityDetailsLoading) {
            return CircularProgressIndicator(color: Colors.black);
          } else if (state is FacilityDetailsError) {
            return Text("No data");
          } else if (state is FacilityDetailsLoaded) {
            final currentState = state;
            final oneFacility = state.facility;
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  title: Text(
                    widget.facilityName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  expandedHeight: 250.h,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CachedNetworkImage(
                      imageUrl: oneFacility.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FacilityInfoCardWidget(
                          city: state.facility.city,
                          sports: state.facility.sports,
                        ),
                        SizedBox(height: 24.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Courts',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppPalette.primaryColor,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            ...state.facility.courts.map(
                              (court) => CourtCardWidget(
                                onTap: () {
                                  context.read<FacilityBloc>().add(
                                    SelectCourt(court),
                                  );
                                },
                                court: court,
                                selectedCourt: currentState.selectedCourt,
                              ),
                            ),
                          ],
                        ),
                        if (state.selectedCourt != null) ...[
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Book ${state.selectedCourt!.label}",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppPalette.primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Select Date',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                      SizedBox(height: 8.h),
                                      InkWell(
                                        onTap: () async {
                                          final selectedDate =
                                              await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    state.selectedDate ??
                                                    DateTime.now().add(
                                                      const Duration(days: 1),
                                                    ),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now().add(
                                                  const Duration(days: 30),
                                                ),
                                              );

                                          if (selectedDate != null) {
                                            context.read<FacilityBloc>().add(
                                              SelectDate(selectedDate),
                                            );
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                            vertical: 12.h,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppPalette.greyColor[300]!,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state.selectedDate != null
                                                    ? Jiffy.parseFromDateTime(
                                                        state.selectedDate!,
                                                      ).format(
                                                        pattern:
                                                            'EEEE, MMM d, yyyy',
                                                      )
                                                    : 'Choose a date',

                                                style: TextStyle(
                                                  color:
                                                      state.selectedDate != null
                                                      ? Colors.black
                                                      : AppPalette
                                                            .greyColor[600],
                                                ),
                                              ),
                                              Icon(
                                                Icons.calendar_today,
                                                color: AppPalette.primaryColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (state.selectedDate != null) ...[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10.h),
                                        Text(
                                          'Select Time',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        if (state.isLoadingSlots) ...[
                                          const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ] else if (state
                                            .allTimeSlots
                                            .isEmpty) ...[
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: Colors.orange[50],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.info_outline,
                                                  color: Colors.orange[700],
                                                ),
                                                SizedBox(width: 12.w),
                                                const Expanded(
                                                  child: Text(
                                                    'No time slots available for this court',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ] else ...[
                                          GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  childAspectRatio: 2,
                                                  crossAxisSpacing: 8,
                                                  mainAxisSpacing: 8,
                                                ),
                                            itemCount:
                                                state.allTimeSlots.length,
                                            itemBuilder: (context, index) {
                                              final time =
                                                  state.allTimeSlots[index];
                                              final isAvailable = state
                                                  .availableTimeSlots
                                                  .contains(time);

                                              final isSelected =
                                                  state.selectedTime == time;

                                              return InkWell(
                                                onTap: () {
                                                  context
                                                      .read<FacilityBloc>()
                                                      .add(SelectTime(time));
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? AppPalette
                                                              .primaryColor
                                                        : isAvailable
                                                        ? AppPalette
                                                              .greyColor[200]
                                                        : AppPalette
                                                              .greyColor[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                    border: Border.all(
                                                      color: isAvailable
                                                          ? Colors.transparent
                                                          : AppPalette
                                                                .greyColor[300]!,
                                                      width: 1.w,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      time,
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            : isAvailable
                                                            ? Colors.black87
                                                            : Colors.black,
                                                        fontWeight: isSelected
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,

                                                        decoration: isAvailable
                                                            ? null
                                                            : TextDecoration
                                                                  .lineThrough,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                  if (state.canCreateBooking) ...[
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: AppPalette.primaryColor
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Booking Summary',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppPalette.primaryColor,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),

                                          BookingSummaryWidget(
                                            label: "Court:",
                                            value: state.selectedCourt!.label,
                                          ),
                                          BookingSummaryWidget(
                                            label: "Date:",
                                            value: Jiffy.parseFromDateTime(
                                              state.selectedDate!,
                                            ).format(pattern: "EEEE, MMM d"),
                                          ),
                                          BookingSummaryWidget(
                                            label: "Time:",
                                            value:
                                                '${state.selectedTime} - ${_calculateEndTime(state.selectedTime!, currentState.selectedCourt!.slotMinutes)}',
                                          ),
                                          BookingSummaryWidget(
                                            label: "Duration",
                                            value:
                                                '${currentState.selectedCourt!.slotMinutes} minutes',
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.read<FacilityBloc>().add(
                                            CreateBooking(
                                              booking: Booking(
                                                id: Uuid().v1(),
                                                facilityId:
                                                    currentState.facility.id,
                                                facilityName:
                                                    currentState.facility.name,
                                                courtId: currentState
                                                    .selectedCourt!
                                                    .id,
                                                courtLabel: currentState
                                                    .selectedCourt!
                                                    .label,
                                                date:
                                                    currentState.selectedDate!,
                                                startTime:
                                                    currentState.selectedTime!,
                                                endTime: _calculateEndTime(
                                                  state.selectedTime!,
                                                  currentState
                                                      .selectedCourt!
                                                      .slotMinutes,
                                                ),
                                                price: currentState
                                                    .selectedCourt!
                                                    .price,
                                                createdAt: DateTime.now(),
                                              ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppPalette.primaryColor,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 16.h,
                                          ),
                                        ),
                                        child: Text(
                                          'CONFIRM BOOKING',
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppPalette.surfaceColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

String _calculateEndTime(String startTime, int durationMinutes) {
  final start = Jiffy.parse(startTime, pattern: "HH:mm");

  final end = start.add(minutes: durationMinutes);

  return Jiffy.parseFromJiffy(end).format(pattern: "HH:mm");
}
