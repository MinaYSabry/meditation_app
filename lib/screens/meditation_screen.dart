import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation_app/constants/colors.dart';
import 'package:meditation_app/model/sessionsData.dart';
import 'package:meditation_app/widgets/grid_tile.dart';
import 'package:meditation_app/widgets/small_grid_tile.dart';
import 'package:provider/provider.dart';

import '../constants/categories.dart';
import '../constants/custom_fontstyle.dart';
import '../provider/app_provider.dart';
import '../widgets/navbar.dart';
import '../widgets/search_bar.dart';

class MeditationScreen extends StatelessWidget {
  String? title, description, duration;
  List<SessionsData>? allSessionsData;

  MeditationScreen({
    super.key,
    required this.title,
    required this.description,
    required this.duration,
    required this.allSessionsData,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final TextEditingController searchBarController = TextEditingController();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            height: screenSize.height * 0.47,
            decoration: const BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  'assets/images/meditation_bg.png',
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 20),
                    child: Container(
                      child: Text(
                        title!,
                        style: cairoTxtStyle(
                          size: 30,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      child: Text(
                        duration!,
                        style: cairoTxtStyle(
                          size: 18,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: screenSize.width * 0.7,
                      child: Text(
                        description!,
                        style: cairoTxtStyle(
                          size: 18,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width * 0.65,
                    child: CustomSearchBar(
                      customSearchBar: searchBarController,
                      onSubmitting: (_) {},
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: GridView.builder(
                        itemCount: allSessionsData!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.25,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 18),
                        itemBuilder: (context, index) {
                          return CustomSmallGridTile(
                            name: allSessionsData![index].title,
                            isDone: allSessionsData![index].isDone,
                            onTap: () {
                              print('Button Clicked');
                              Provider.of<ScreensProvider>(context,
                                      listen: false)
                                  .videoScreen(
                                      context,
                                      allSessionsData![index].url,
                                      allSessionsData![index].title);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      title!,
                      style: cairoTxtStyle(size: 20, weight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: kShadowColor,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: SvgPicture.asset(
                                'assets/icons/yoga.svg',
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Basics 2',
                                  style: cairoTxtStyle(
                                      size: 17, weight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text('Start your practice'),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.lock),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
