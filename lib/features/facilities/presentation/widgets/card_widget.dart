import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mini_court_book/core/theme/app_palette.dart';
import 'package:mini_court_book/core/theme/theme.dart';

class CardWidget extends StatelessWidget {
  final String facilityImage;
  final String facilityName;
  final String cityName;
  final List<String> sports;
  final int courtsNumber;
  final VoidCallback onTap;
  const CardWidget({
    super.key,
    required this.facilityImage,
    required this.facilityName,
    required this.cityName,
    required this.sports,
    required this.courtsNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: facilityImage,
                height: 150.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 150.h,
                  color: AppPalette.greyColor[300],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 150.h,
                  color: AppPalette.greyColor[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, size: 90),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(facilityName, style: AppTheme.theme.textTheme.bodyLarge),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: AppPalette.greyColor[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        cityName,
                        style: AppTheme.theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: sports
                        .map(
                          (sport) => Chip(
                            label: Text(
                              sport,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor: AppTheme.theme.primaryColor,
                            padding: const EdgeInsets.all(4),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$courtsNumber courts available',
                        style: AppTheme.theme.textTheme.bodyMedium,
                      ),
                      Icon(
                        Icons.remove_red_eye,
                        size: 16,
                        color: AppTheme.theme.primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
