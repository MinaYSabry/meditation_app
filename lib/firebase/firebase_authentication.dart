import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditation_app/model/userData.dart';
import 'package:uuid/uuid.dart';

import '../credentials/credentials.dart';

class FirebaseAuthenticationService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpService(
      {required String email, required String password}) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return newUser.user;
    } catch (e) {
      print('Error Occured');
      print(e);
    }
    return null;
  }

  Future<bool?> loginInService(
      {required String email, required String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await AppUserCredentials.storeCredentials(
            isLoggedIn: true, userDocID: value.user!.uid);
      });

      return true;
    } catch (e) {
      print('Unsuccessful Login: User not found');
    }
    return false;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<List?>? getSpecificCoursesData(
      {required String? searchBarText}) async {
    final dbInstance = FirebaseFirestore.instance;
    List? doc;

    if (searchBarText!.isEmpty) {
      await dbInstance.collection("courses").get().then(
        (querySnapshot) {
          doc = [];
          for (var docSnapshot in querySnapshot.docs) {
            doc?.add(docSnapshot.data());
          }
        },
      );
    } else {
      await dbInstance.collection("courses").get().then(
        (querySnapshot) {
          doc = [];
          for (var docSnapshot in querySnapshot.docs) {
            String title = docSnapshot['title'].toString().toLowerCase();
            if (title == searchBarText) {
              doc?.add(docSnapshot.data());
            }
          }
        },
      );
    }

    return doc;
  }

  Future storeNewUser({
    required String? docID,
    required String? firstName,
    required String? lastName,
    required String? email,
  }) async {
    final dbInstance = FirebaseFirestore.instance;
    Map<String, dynamic> newUserData = {
      'id': Uuid().v6(),
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };

    await dbInstance.collection('users').doc(docID).set(newUserData);
  }

  Future<List?>? getAllCoursesData({required String? searchBarText}) async {
    final dbInstance = FirebaseFirestore.instance;
    List? doc;

    await dbInstance.collection("courses").get().then(
      (querySnapshot) {
        doc = [];
        if (searchBarText!.isEmpty) {
          for (var docSnapshot in querySnapshot.docs) {
            doc?.add(docSnapshot.data());
          }
        } else {
          for (var docSnapshot in querySnapshot.docs) {
            String title = docSnapshot['title'].toString().toLowerCase();
            if (searchBarText == title) {
              doc?.add(docSnapshot.data());
            }
          }
        }
      },
    );

    return doc;
  }

  Future<AppUserData?> getUserData({required String? userDocId}) async {
    final dbInstance = FirebaseFirestore.instance;
    AppUserData? currentUser;
    await dbInstance.collection('users').doc(userDocId).get().then((snapShot) {
      currentUser = AppUserData.fromJson(snapShot.data());
    });
    return currentUser;
  }
}
