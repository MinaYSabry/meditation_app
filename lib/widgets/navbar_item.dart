import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/constants/colors.dart';

import '../constants/custom_fontstyle.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    this.isActive = false,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final bool isActive;
  final String title;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: SvgPicture.asset(
              icon,
              color: isActive ? kActiveIconColor : kTextColor,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: cairoTxtStyle(
                size: 16,
                weight: FontWeight.w600,
                customColor: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}
