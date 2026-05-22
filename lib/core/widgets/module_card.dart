import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  const ModuleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Container(
            height: 72,
            width: 72,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: iconColor,
              size: 36,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0A0F2C),
            ),
          ),

          const SizedBox(height: 8),

          Text(
            subtitle,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}