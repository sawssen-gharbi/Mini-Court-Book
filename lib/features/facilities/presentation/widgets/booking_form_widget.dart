/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';
import 'package:mini_court_book/core/theme/theme.dart';
import 'package:mini_court_book/features/facilities/domain/entities/court.dart';
import 'package:mini_court_book/features/facilities/presentation/widgets/booking_summary_widget.dart';

class BookingFormWidget extends StatelessWidget {
  final Court court;
  final DateTime? date;
  final VoidCallback onTap;
  const BookingFormWidget({
    super.key,
    required this.court,
    this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Book ${court.label}",
              style: AppTheme.theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Date',
                  style: AppTheme.theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          date != null
                              ? DateFormat('EEEE, MMM d, yyyy').format(date!)
                              : 'Choose a date',
                          style: TextStyle(
                            color: date != null
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

            // Time Selection
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Time',
                  style: AppTheme.theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    final time = state.allTimeSlots[index];
                    final isSelected = state.selectedTime == time;

                    return InkWell(
                      onTap: isAvailable
                          ? () {
                              context.read<BookingBloc>().add(SelectTime(time));
                            }
                          : null,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: /*isSelected
                                ? Theme.of(context).primaryColor
                                : isAvailable
                                ? Colors.grey[200]
                                : */
                              Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
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
                            "time",
                            style: TextStyle(
                              color: /*isSelected
                                    ?*/
                                  Colors.white,
                              /* : isAvailable
                                    ? Colors.black87
                                    : Colors.grey[400]*/
                              fontWeight: /* isSelected
                                    ? FontWeight.bold
                                    : */
                                  FontWeight.normal,
                              decoration: /*isAvailable
                                    ? null
                                    : */
                                  TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking Summary',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  BookingSummaryWidget(label: 'Court', value: "court.,"),
                  BookingSummaryWidget(label: 'Court', value: "court.,"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //context.read<BookingBloc>().add(CreateBooking());
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
