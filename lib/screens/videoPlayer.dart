import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/constants/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constants/custom_fontstyle.dart';
import '../widgets/navbar.dart';

class VideoScreen extends StatelessWidget {
  final String? url;
  final String? title;
  final YoutubePlayerController youtubePlayerController;

  VideoScreen({
    super.key,
    this.url,
    required this.youtubePlayerController,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: youtubePlayerController,
        width: double.maxFinite,
      ),
      builder: (BuildContext, player) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 40,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              Container(
                height: screenSize.height * 0.45,
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
                      Center(
                        child: Text(
                          title!,
                          style: cairoTxtStyle(
                              size: 30,
                              weight: FontWeight.w500,
                              customColor: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      player
                    ],
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: const NavBar(),
        );
      },
    );
  }
}
