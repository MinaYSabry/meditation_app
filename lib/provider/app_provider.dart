import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/credentials/credentials.dart';
import 'package:meditation_app/model/sessionsData.dart';
import 'package:meditation_app/screens/authentication/login.dart';
import 'package:meditation_app/screens/authentication/signUp.dart';
import 'package:meditation_app/screens/homescreen.dart';
import 'package:meditation_app/screens/profile.dart';
import 'package:meditation_app/screens/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../screens/meditation_screen.dart';
import '../screens/videoPlayer.dart';

class ScreensProvider extends ChangeNotifier {
  void changeScreen(
    context, {
    required String? title,
    required String? description,
    required String? duration,
    required List<SessionsData>? allSessionsData,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeditationScreen(
          title: title,
          description: description,
          duration: duration,
          allSessionsData: allSessionsData,
        ),
      ),
    );
  }

  void videoScreen(context, String? url, String? title) {
    final YoutubePlayerController youtubePlayerController;
    final videoID = YoutubePlayer.convertUrlToId(url!);
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoScreen(
          url: url,
          youtubePlayerController: youtubePlayerController,
          title: title,
        ),
      ),
    );
  }

  void signUpScreen(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUp(),
      ),
    );
  }

  static Future<Widget> appRun() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    bool? isLoggedIn = await sharedPref.getBool('isLoggedIn');
    sharedPref.setString('onScreen', 'HomeScreen');

    if (isLoggedIn == true) {
      return HomeScreen();
    }
    return LoginPage();
  }

  void LogOutApp(context) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setBool('isLoggedIn', false);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  bool passVisibility({required bool? passHidden}) {
    if (passHidden == true) {
      passHidden = false;
    } else {
      passHidden = true;
    }
    notifyListeners();
    return passHidden;
  }

  // int? changeNavBarFocus({int? focusNode, int? buttonReq}) {
  //   if (focusNode == buttonReq) {
  //     print('App Provider: NavBar focus : they are equal');
  //     notifyListeners();
  //     return focusNode;
  //   } else {
  //     focusNode = buttonReq;
  //     notifyListeners();
  //     return focusNode;
  //   }
  // }

  Future<String?> changeNavBarFocus() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String? currentScreen = sharedpref.getString('onScreen');

    return currentScreen;
  }

  Future<void> goToSettings(BuildContext context) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String? currentScreen = sharedpref.getString('onScreen');
    if (currentScreen != 'Settings') {
      sharedpref.setString('onScreen', 'Settings');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AppSettingsSRC()));
    }
  }

  Future<void> goToHome(BuildContext context) async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String? currentScreen = sharedpref.getString('onScreen');
    if (currentScreen != 'HomeScreen') {
      sharedpref.setString('onScreen', 'HomeScreen');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
  }

  void goToProfile(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfileSRC()));
  }

  void refreshScreen(BuildContext context) {
    notifyListeners();
  }
}
