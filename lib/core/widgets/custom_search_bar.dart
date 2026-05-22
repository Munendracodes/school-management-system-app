import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search modules...",

        prefixIcon: const Icon(
          Icons.search_rounded,
          color: AppColors.lightText,
        ),

        hintStyle: const TextStyle(
          color: AppColors.lightText,
          fontSize: 18,
        ),
      ),
    );
  }
}