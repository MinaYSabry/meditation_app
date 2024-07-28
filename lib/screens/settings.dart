import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../constants/categories.dart';
import '../constants/custom_fontstyle.dart';
import '../model/courses.dart';
import '../model/userData.dart';
import '../provider/app_provider.dart';
import '../provider/firebase_provider.dart';
import '../widgets/grid_tile.dart';
import '../widgets/navbar.dart';
import '../widgets/search_bar.dart';

class AppSettingsSRC extends StatelessWidget {
  const AppSettingsSRC({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final TextEditingController searchBarController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenSize.height * 0.38,
            decoration: const BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage(
                  'assets/images/undraw_pilates_gpdb-2.png',
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: Provider.of<FirebaseServiceProvider>(context,
                          listen: false)
                      .getUserData(),
                  builder: (BuildContext context, snapshot) {
                    AppUserData? user = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Container(
                                child: const CircleAvatar(
                                  radius: 80,
                                  backgroundImage: AssetImage(
                                    'assets/images/profile_photo.jpg',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Container(
                                child: Text(
                                  snapshot.data!.firstName as String,
                                  style: cairoTxtStyle(size: 40),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 25),
                        child: const CircularProgressIndicator());
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                    child: Container(
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<ScreensProvider>(context, listen: false)
                              .goToProfile(context);
                        },
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.account_box),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Profile',
                                  style: cairoTxtStyle(size: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.payment_outlined),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Payment Methods',
                                  style: cairoTxtStyle(size: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<ScreensProvider>(context, listen: false)
                              .LogOutApp(context);
                        },
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.logout),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Logout',
                                  style: cairoTxtStyle(size: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
