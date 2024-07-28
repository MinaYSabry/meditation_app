import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/custom_fontstyle.dart';

class CustomGridTile extends StatelessWidget {
  const CustomGridTile({
    super.key,
    required this.imagePath,
    required this.name,
    required this.onTap,
  });

  final String? imagePath;
  final String? name;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
              width: double.maxFinite * 0.7,
              child: SvgPicture.asset(
                imagePath!,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name!,
                style: cairoTxtStyle(
                    size: 16,
                    flow: TextOverflow.ellipsis,
                    weight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
