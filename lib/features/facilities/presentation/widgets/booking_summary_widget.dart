import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';

class BookingSummaryWidget extends StatelessWidget {
  final String label;
  final String value;
  const BookingSummaryWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: AppPalette.textPrimaryColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
                color: AppPalette.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
