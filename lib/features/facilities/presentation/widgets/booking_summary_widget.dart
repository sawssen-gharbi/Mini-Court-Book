import 'package:flutter/material.dart';

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
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
