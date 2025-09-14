// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mini_court_book/core/theme/app_palette.dart';

class SearchFilterWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final VoidCallback? onPressed;
  const SearchFilterWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: 'Search facilities...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppPalette.primaryColor,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
              ),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.tune_rounded),
            color: AppPalette.primaryColor,
          ),
        ],
      ),
    );
  }
}
