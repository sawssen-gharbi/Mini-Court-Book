import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';
import 'package:mini_court_book/core/theme/theme.dart';
import 'package:mini_court_book/features/bookings/domain/entities/booking.dart';
import 'package:mini_court_book/features/facilities/presentation/blocs/bloc/facility_bloc.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/booking_form_widget.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/booking_summary_widget.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/court_card_widget.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/facility_info_widget.dart';
import 'package:mini_court_book/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class FacilityDetailsScreen extends StatefulWidget {
  final String facilityId;
  const FacilityDetailsScreen({super.key, required this.facilityId});

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
      body: BlocBuilder<FacilityBloc, FacilityState>(
        builder: (context, state) {
          if (state is FacilityDetailsLoading) {
            return CircularProgressIndicator(color: Colors.black);
          } else if (state is FacilityDetailsError) {
            return Text("No data");
          } else if (state is FacilityDetailsLoaded) {
            print(
              "sawssena ${serviceLocator<SharedPreferences>().getString("bookings")}",
            );
            final currentState = state;
            final oneFacility = state.facility;
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(oneFacility.name),
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
                        const SizedBox(height: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Courts',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 12),
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
                                    style:
                                        AppTheme.theme.textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Select Date',
                                        style: AppTheme
                                            .theme
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(height: 8),
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
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey[300]!,
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
                                                      : Colors.grey[600],
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
                                        Text(
                                          'Select Time',
                                          style: AppTheme
                                              .theme
                                              .textTheme
                                              .titleMedium,
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
                                                const SizedBox(width: 12),
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
                                                        ? Theme.of(
                                                            context,
                                                          ).primaryColor
                                                        /* : isAvailable
                                ? Colors.grey[200]
                                : */
                                                        : Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                    border: Border.all(
                                                      color: /*isAvailable
                                  ? Colors.transparent
                                  :*/
                                                          Colors.grey[300]!,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      time,
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            :
                                                              /* : isAvailable
                                    ? Colors.black87*/
                                                              Colors.black,
                                                        fontWeight: isSelected
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,

                                                        /*isAvailable
                                    ? null
                                    : */
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
                                        color: Theme.of(
                                          context,
                                        ).primaryColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Booking Summary',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 8),

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
                                    const SizedBox(height: 16),
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
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                        ),
                                        child: const Text(
                                          'Confirm Booking',
                                          style: TextStyle(fontSize: 16),
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
