import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/constants/colors.dart';
import 'package:meditation_app/model/courses.dart';
import 'package:meditation_app/model/userData.dart';
import 'package:meditation_app/provider/firebase_provider.dart';
import 'package:meditation_app/widgets/grid_tile.dart';
import 'package:meditation_app/widgets/navbar.dart';
import 'package:meditation_app/widgets/navbar_item.dart';
import 'package:provider/provider.dart';

import '../../constants/categories.dart';
import '../../constants/custom_fontstyle.dart';
import '../../constants/nav_items.dart';
import '../provider/app_provider.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.firstName, this.lastName});

  final String? firstName;
  final String? lastName;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final TextEditingController searchBarController = TextEditingController();
    return Scaffold(
      endDrawer: Drawer(
        width: screenSize.width * 0.18,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            const Spacer(),
            Builder(builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  Provider.of<ScreensProvider>(context, listen: false)
                      .goToProfile(context);
                  Scaffold.of(context).closeEndDrawer();
                },
                child: const ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                ),
              );
            }),
            InkWell(
              onTap: () {
                Provider.of<ScreensProvider>(context, listen: false)
                    .LogOutApp(context);
              },
              child: const ListTile(
                leading: Icon(Icons.logout),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: screenSize.height * 0.47,
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
                Builder(builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, top: 8),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF2BEA1),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/menu.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                FutureBuilder(
                  future: Provider.of<FirebaseServiceProvider>(context,
                          listen: false)
                      .getUserData(),
                  builder: (BuildContext context, snapshot) {
                    AppUserData? user = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          child: Text(
                            'Good Morning \n${user!.firstName}',
                            style: cairoTxtStyle(
                              size: 30,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    }
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 25),
                        child: const CircularProgressIndicator());
                  },
                ),
                CustomSearchBar(
                  customSearchBar: searchBarController,
                  onSubmitting: (finalValue) {
                    Provider.of<FirebaseServiceProvider>(context, listen: false)
                        .coursesDataRetrieve(searchBarText: finalValue);
                    Provider.of<FirebaseServiceProvider>(context, listen: false)
                        .refresh();
                  },
                ),
                Consumer<FirebaseServiceProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return FutureBuilder(
                      future: Provider.of<FirebaseServiceProvider>(context,
                              listen: false)
                          .coursesDataRetrieve(
                              searchBarText: searchBarController.text),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          List<CourseData>? finalDataRetrieved = snapshot.data;
                          return Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: GridView.builder(
                                itemCount: finalDataRetrieved!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15),
                                itemBuilder: (context, index) {
                                  return CustomGridTile(
                                    name: finalDataRetrieved[index].title,
                                    imagePath: categories[index]['icon'],
                                    onTap: () {
                                      context
                                          .read<ScreensProvider>()
                                          .changeScreen(context,
                                              title: finalDataRetrieved[index]
                                                  .title,
                                              duration:
                                                  finalDataRetrieved[index]
                                                      .duration,
                                              description:
                                                  finalDataRetrieved[index]
                                                      .description,
                                              allSessionsData:
                                                  finalDataRetrieved[index]
                                                      .allSessionsData);
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return const Center(
                            child: Text('NO DATA AVAILABLE'),
                          );
                        }
                      },
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
