import 'package:tawjih/controller/onboarding-controller.dart';
import 'package:flutter/material.dart';
import 'package:tawjih/core/constant/colors.dart';
import 'package:get/get.dart';

class CustomButtonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomButtonOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 40,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.purple.shade400,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
          ),
          onPressed: () {
            controller.next();
          },
          child: const Text(
            "Suivant",
            style: TextStyle(fontFamily: 'lato'),
          )),
    );
  }
}
