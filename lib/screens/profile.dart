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

class ProfileSRC extends StatelessWidget {
  const ProfileSRC({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    String? userEmail;

    final TextEditingController searchBarController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 35,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            height: screenSize.height * 0.42,
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
            child: FutureBuilder(
              future:
                  Provider.of<FirebaseServiceProvider>(context, listen: false)
                      .getUserData(),
              builder: (BuildContext context, snapshot) {
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
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                            const Divider(
                              indent: 20,
                              endIndent: 20,
                            ),
                            Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Email :',
                                      style: cairoTxtStyle(size: 18),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '\'${snapshot.data?.email}\'',
                                      style: cairoTxtStyle(size: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
                }
                return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 25),
                    child: const CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
