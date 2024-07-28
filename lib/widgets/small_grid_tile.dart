import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/constants/colors.dart';

import '../constants/custom_fontstyle.dart';

class CustomSmallGridTile extends StatelessWidget {
  const CustomSmallGridTile({
    super.key,
    required this.name,
    required this.onTap,
    required this.isDone,
  });

  final bool? isDone;

  // final String imagePath;
  final String? name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              offset: Offset(1, 7),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone! ? kTextColor : Colors.white,
                border: Border.all(color: kTextColor),
              ),
              child: Icon(
                Icons.play_arrow,
                color: isDone! ? Colors.white : kTextColor,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              name!,
              style: cairoTxtStyle(size: 18, weight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
