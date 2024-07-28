import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:meditation_app/constants/colors.dart';
import 'package:meditation_app/constants/custom_fontstyle.dart';
import 'package:provider/provider.dart';

import '../../provider/firebase_provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController firstNameTextController =
        TextEditingController();
    final TextEditingController lastNameTextController =
        TextEditingController();
    final TextEditingController passTextController = TextEditingController();
    bool? emailValidate;
    String? emailValidateText;
    bool? passValidate;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 50,
      ),
      body: Stack(
        children: [
          Container(
            height: screenSize.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  'assets/images/Login(2).jpg',
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      child: Text(
                        'Join Our\nCalm Enviroment',
                        style: disneyBoldTxt(size: 40, customColor: kTextColor),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Add your credentials:',
                        style: regularTxt(size: 20, customColor: kTextColor),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: firstNameTextController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelStyle: regularTxt(size: 15),
                        hintText: 'First Name',
                        hintStyle: regularTxt(size: 18),
                        errorText: emailValidateText,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: kShadowTwoColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: lastNameTextController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelStyle: regularTxt(size: 15),
                        hintText: 'Last Name',
                        hintStyle: regularTxt(size: 18),
                        errorText: emailValidateText,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: kShadowTwoColor),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<FirebaseServiceProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return TextField(
                          controller: emailTextController,
                          onChanged: (_) {
                            emailValidateText = provider.checkEmail(
                                email: emailTextController.text);

                            emailValidateText == null
                                ? emailValidate = true
                                : emailValidate = false;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: emailTextController.text.isEmpty
                                ? null
                                : 'Email',
                            labelStyle: regularTxt(size: 15),
                            hintText: 'Email',
                            hintStyle: regularTxt(size: 18),
                            errorText: emailValidateText,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: kShadowTwoColor),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<FirebaseServiceProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return TextField(
                          controller: passTextController,
                          onChanged: (_) {},
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: passTextController.text.isEmpty
                                ? null
                                : 'Password',
                            labelStyle: regularTxt(size: 15),
                            hintText: 'New Password',
                            hintStyle: regularTxt(size: 18),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: kShadowTwoColor),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FlutterPwValidator(
                      controller: passTextController,
                      minLength: 8,
                      uppercaseCharCount: 1,
                      lowercaseCharCount: 2,
                      specialCharCount: 1,
                      width: 400,
                      height: 170,
                      onSuccess: () {
                        passValidate = true;
                      },
                      onFail: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<FirebaseServiceProvider>(context,
                                  listen: false)
                              .signUp(
                                  context: context,
                                  emailValid: emailValidate,
                                  email: emailTextController.text,
                                  passValid: passValidate,
                                  password: passTextController.text,
                                  firstName: firstNameTextController.text,
                                  lastName: lastNameTextController.text);
                        },
                        style: ElevatedButton.styleFrom(
                            textStyle: regularTxt(size: 18),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black87),
                        child: const Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: 30),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         InkWell(
          //           onTap: () {},
          //           child: Container(
          //             height: 45,
          //             width: 45,
          //             decoration: const BoxDecoration(
          //               image: DecorationImage(
          //                   fit: BoxFit.scaleDown,
          //                   image:
          //                       AssetImage('assets/images/google_black.png')),
          //               shape: BoxShape.circle,
          //             ),
          //           ),
          //         ),
          //         Container(
          //           height: 45,
          //           width: 45,
          //           decoration: const BoxDecoration(
          //             image: DecorationImage(
          //                 fit: BoxFit.scaleDown,
          //                 image: AssetImage('assets/images/apple-logo.png')),
          //             shape: BoxShape.circle,
          //           ),
          //         ),
          //         Container(
          //           height: 45,
          //           width: 45,
          //           decoration: const BoxDecoration(
          //             image: DecorationImage(
          //                 fit: BoxFit.scaleDown,
          //                 image: AssetImage('assets/images/facebook_black'
          //                     '.png')),
          //             shape: BoxShape.circle,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
