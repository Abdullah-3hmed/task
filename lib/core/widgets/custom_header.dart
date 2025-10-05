import 'package:flutter/material.dart';
import 'package:task/core/utils/assets_manager.dart';

class CustomHeaderTitle extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CustomHeaderTitle({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            color: Color(0xFF303A42),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onPressed,
          child: Row(
            children: [
              CircleAvatar(
                radius: 12.0,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.add,
                  color: AssetsManager.primaryColor,
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 4.0),
              const Text(
                "اضافة جديد",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14.0,
                  color: AssetsManager.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
