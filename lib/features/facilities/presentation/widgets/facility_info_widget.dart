import 'package:flutter/material.dart';

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
                const Icon(Icons.location_on, size: 20),
                const SizedBox(width: 8),
                Text(city, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: sports
                  .map(
                    (sport) => Chip(
                      label: Text(
                        sport.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
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
