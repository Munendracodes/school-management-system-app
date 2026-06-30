import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {

  final String title;

  final bool loading;

  final VoidCallback onPressed;

  const AppPrimaryButton({

    super.key,

    required this.title,

    required this.loading,

    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(

      width: double.infinity,

      height: 58,

      child: ElevatedButton.icon(

        onPressed: loading ? null : onPressed,

        icon: loading

            ? const SizedBox(

          height: 22,

          width: 22,

          child: CircularProgressIndicator(

            strokeWidth: 2,

            color: Colors.white,
          ),
        )

            : const Icon(

          Icons.check_circle,

          color: Colors.white,
        ),

        label: Text(

          loading

              ? "Saving..."

              : title,

          style: const TextStyle(

            color: Colors.white,

            fontWeight: FontWeight.bold,

            fontSize: 16,
          ),
        ),

        style: ElevatedButton.styleFrom(

          elevation: 0,

          backgroundColor: const Color(0xFF2457FF),

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}