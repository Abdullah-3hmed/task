import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FuelListItem extends StatelessWidget {
  const FuelListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 2.0,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(12.0),
          bottomStart: Radius.circular(12.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 14.0,
          vertical: 10.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26.0,
              backgroundColor: const Color(0xFFF4F5F6),
              child: SvgPicture.asset(
                "assets/images/car.svg",
                fit: BoxFit.cover,
                width: 22.0,
                height: 26.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "25/9/2025",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "تمت تعبئة : 50 لتر",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
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
