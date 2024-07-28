import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditation_app/model/courses.dart';
import 'package:meditation_app/model/sessionsData.dart';
import 'package:meditation_app/screens/authentication/login.dart';
import 'package:meditation_app/screens/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../credentials/credentials.dart';
import '../firebase/firebase_authentication.dart';
import '../model/userData.dart';
import '../screens/meditation_screen.dart';

class FirebaseServiceProvider extends ChangeNotifier {
  String? checkEmail({required String? email}) {
    bool validated = EmailValidator.validate(email!);

    if (validated == true) {
      notifyListeners();
      return null;
    }
    notifyListeners();
    return 'Enter a valid email';
  }

  String? checkPass({required bool? pass}) {
    if (pass == true) {
      notifyListeners();
      return 'Valid';
    }
    notifyListeners();
    return 'Invalid';
  }

  Future signUp(
      {required BuildContext context,
      required String? firstName,
      required String? lastName,
      required bool? emailValid,
      required String email,
      required bool? passValid,
      required String password}) async {
    if (emailValid == true && passValid == true) {
      try {
        await FirebaseAuthenticationService()
            .signUpService(email: email, password: password)
            .then(
          (user) async {
            await FirebaseAuthenticationService().storeNewUser(
              docID: user?.uid,
              firstName: firstName,
              lastName: lastName,
              email: user?.email,
            );
          },
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        print('sign up UNSUCCESSFUL');
      }
    }
  }

  Future login(
      {required BuildContext context,
      required bool? emailValid,
      required String email,
      required String password}) async {
    if (emailValid == true) {
      try {
        final newUse = await FirebaseAuthenticationService()
            .loginInService(email: email, password: password);
        if (newUse == true) {
          SharedPreferences sharedPref = await SharedPreferences.getInstance();
          sharedPref.setString('onScreen', 'HomeScreen');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } catch (e) {
        print('sign in UNSUCCESSFUL');
      }
    }
  }

  Future googleLogin(context) async {
    try {
      final FirebaseAuthenticationService googleAuth =
          FirebaseAuthenticationService();
      await googleAuth.signInWithGoogle().then((credentials) async {
        // print('Google Credentials: ${credentials.user!.email}');
        await FirebaseAuthenticationService().storeNewUser(
          docID: credentials.user!.uid,
          firstName: credentials.user!.displayName,
          lastName: credentials.user!.displayName,
          email: credentials.user?.email,
        );
        AppUserCredentials.storeCredentials(
            isLoggedIn: true, userDocID: credentials.user!.uid);
      });
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setString('onScreen', 'HomeScreen');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } catch (e) {
      print('Google Login Unsuccessful');
    }
  }

  Future<List<CourseData>?> coursesDataRetrieve(
      {required String? searchBarText}) async {
    // print('Function Called');
    List<CourseData>? finalCoursesData;

    await FirebaseAuthenticationService()
        .getSpecificCoursesData(searchBarText: searchBarText)
        ?.then(
      (dataListReceived) {
        if (dataListReceived != null) {
          finalCoursesData = [];
          for (int x = 0; x < dataListReceived.length; x++) {
            // print('Loop Called');
            List<SessionsData>? temporarySessionsList = [];
            for (var singleSessionMap in dataListReceived[x]['sessions']) {
              SessionsData trialSessionData =
                  SessionsData.fromJson(singleSessionMap);
              temporarySessionsList.add(trialSessionData);
            }

            CourseData courseNewData = CourseData.fromJson({
              'title': dataListReceived[x]['title'],
              'duration': dataListReceived[x]['duration'],
              'description': dataListReceived[x]['description'],
              'allSessionsData': temporarySessionsList,
            });

            finalCoursesData?.add(courseNewData);
          }
        } else {
          print('No data retrieved from Firebase');
          return null;
        }
      },
    );

    return finalCoursesData;
  }

  void refresh() {
    notifyListeners();
  }

  Future<AppUserData?> getUserData() async {
    SharedPreferences sharePref = await SharedPreferences.getInstance();
    String? userDocId = sharePref.getString('userDocId');
    // print('Firebase Provider: Shared Pref userID trial ${userDocId}');

    return await FirebaseAuthenticationService()
        .getUserData(userDocId: userDocId);
  }
}
