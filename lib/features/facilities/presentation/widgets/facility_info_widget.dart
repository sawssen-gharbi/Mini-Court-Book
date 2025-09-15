import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';

class FacilityInfoCardWidget extends StatelessWidget {
  final String city;
  final List<String> sports;
  const FacilityInfoCardWidget({
    super.key,
    required this.sports,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: AppPalette.primaryColor,
                ),
                SizedBox(width: 8.w),
                Text(city, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8,
              children: sports
                  .map(
                    (sport) => Chip(
                      label: Text(
                        sport.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: AppPalette.primaryColor,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
