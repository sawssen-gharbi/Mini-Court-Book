import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';
import 'package:mini_court_book/features/facilities/domain/entities/court.dart';

class CourtCardWidget extends StatelessWidget {
  final Court court;
  final Court? selectedCourt;
  final VoidCallback onTap;
  const CourtCardWidget({
    super.key,
    required this.court,
    required this.onTap,
    this.selectedCourt,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedCourt?.id == court.id;
    return Card(
      elevation: isSelected ? 4 : 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: AppPalette.primaryColor, width: 2.w)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppPalette.primaryColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getSportIcon(court.sport),
                  color: AppPalette.primaryColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      court.label,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      court.sport.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.greyColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${court.dailyOpen} - ${court.dailyClose}',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${court.price.toStringAsFixed(0)} TND',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.primaryColor,
                    ),
                  ),
                  Text(
                    '/${court.slotMinutes} min',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.greyColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData _getSportIcon(String sport) {
  switch (sport.toLowerCase()) {
    case 'football':
      return Icons.sports_soccer;
    case 'basketball':
      return Icons.sports_basketball;
    case 'tennis':
      return Icons.sports_tennis;
    case 'padel':
      return Icons.sports_tennis;
    default:
      return Icons.sports;
  }
}
