import 'package:flutter/material.dart';
import 'package:meditation_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../constants/nav_items.dart';
import 'navbar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool? buttonOneBool = false;
    bool? buttonTwoBool = true;
    // bool? buttonThreeBool = false;
    String? activeButton;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(color: Colors.white),
      child: Consumer<ScreensProvider>(
        builder: (BuildContext context, ScreensProvider value, Widget? child) {
          return FutureBuilder(
            future: Provider.of<ScreensProvider>(context, listen: false)
                .changeNavBarFocus(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                activeButton = snapshot.data;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // NavBarItem(
                    //   onTap: () {
                    //     activeButton = Provider.of<ScreensProvider>(context,
                    //             listen: false)
                    //         .changeNavBarFocus(focusNode: activeButton, buttonReq: 1);
                    //   },
                    //   title: navItems[0]['title'],
                    //   icon: navItems[0]['icon'],
                    //   isActive: activeButton == 1
                    //       ? buttonOneBool = true
                    //       : buttonOneBool = false,
                    // ),
                    NavBarItem(
                      onTap: () {
                        Provider.of<ScreensProvider>(context, listen: false)
                            .goToHome(context);
                      },
                      title: navItems[1]['title'],
                      icon: navItems[1]['icon'],
                      isActive: activeButton == 'HomeScreen'
                          ? buttonOneBool = true
                          : buttonOneBool = false,
                    ),
                    NavBarItem(
                      onTap: () {
                        Provider.of<ScreensProvider>(context, listen: false)
                            .goToSettings(context);
                      },
                      title: navItems[2]['title'],
                      icon: navItems[2]['icon'],
                      isActive: activeButton == 'Settings'
                          ? buttonTwoBool = true
                          : buttonTwoBool = false,
                    ),
                  ],
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
