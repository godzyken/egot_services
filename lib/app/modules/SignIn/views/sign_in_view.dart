import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  static const colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  static const colorizeTextStyle =
      TextStyle(fontSize: 30.0, fontFamily: 'Horizon');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/lottie/image/logo_bat_services.png",
          ),
          const SizedBox(),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 200.0,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'EGOTE + RMC',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Electricité Générale',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Rénovation complète du batiment',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Optimisation énergétique',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'Conseil',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
                onTap: () {
                  print('Tap Event');
                },
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: context.width * 0.24),
              child: SignInButton(
                Buttons.Google,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 2.0,
                padding: const EdgeInsets.all(8.0),
                text: '',
                onPressed: () => controller.login(context),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
      backgroundColor: Colors.cyanAccent,
    );
  }
}
