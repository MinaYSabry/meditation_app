import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/constants/custom_fontstyle.dart';
import 'package:meditation_app/provider/app_provider.dart';
import 'package:meditation_app/provider/firebase_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passTextController = TextEditingController();
    bool? emailValidate;
    String? emailValidateText;
    bool passHidden = true;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenSize.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                fit: BoxFit.fitHeight,
                image: AssetImage(
                  'assets/images/login_background.jpg',
                ),
              ),
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 130,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome to Our\nCalm Enviroment',
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
                      'Login in to your Account:',
                      style: regularTxt(size: 20, customColor: kTextColor),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
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
                          labelText:
                              emailTextController.text.isEmpty ? null : 'Email',
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
                  Consumer<ScreensProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                      return TextField(
                        controller: passTextController,
                        obscureText: passHidden,
                        decoration: InputDecoration(
                          hintText: ' Password',
                          hintStyle: regularTxt(size: 18),
                          suffixIcon: InkWell(
                            onTap: () {
                              passHidden = Provider.of<ScreensProvider>(context,
                                      listen: false)
                                  .passVisibility(passHidden: passHidden);
                              print('Login : pass hidden test ${passHidden}');
                            },
                            child: passHidden == true
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
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
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 55,
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () {
                              Provider.of<FirebaseServiceProvider>(context,
                                      listen: false)
                                  .login(
                                      context: context,
                                      emailValid: emailValidate,
                                      email: emailTextController.text,
                                      password: passTextController.text);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 194, 210, 171),
                                foregroundColor: kTextColor),
                            child: Text(
                              'Login',
                              style: regularTxt(size: 18),
                            )),
                      ),
                      Container(
                        height: 55,
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () {
                              Provider.of<ScreensProvider>(context,
                                      listen: false)
                                  .signUpScreen(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 194, 210, 171),
                                foregroundColor: kTextColor),
                            child: Text(
                              'Sign up',
                              style: regularTxt(size: 18),
                            )),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Provider.of<FirebaseServiceProvider>(context,
                                  listen: false)
                              .googleLogin(context);
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.scaleDown,
                                image: AssetImage(
                                    'assets/images/google_black.png')),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 45,
                      //   width: 45,
                      //   decoration: const BoxDecoration(
                      //     image: DecorationImage(
                      //         fit: BoxFit.scaleDown,
                      //         image:
                      //             AssetImage('assets/images/apple-logo.png')),
                      //     shape: BoxShape.circle,
                      //   ),
                      // ),
                      // Container(
                      //   height: 45,
                      //   width: 45,
                      //   decoration: const BoxDecoration(
                      //     image: DecorationImage(
                      //         fit: BoxFit.scaleDown,
                      //         image: AssetImage('assets/images/facebook_black'
                      //             '.png')),
                      //     shape: BoxShape.circle,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
