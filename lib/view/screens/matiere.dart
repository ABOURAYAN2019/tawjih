import 'package:tawjih/controller/index_controller.dart';
import 'package:tawjih/controller/matiere_controller.dart';
import 'package:tawjih/controller/onboarding-controller.dart';
import 'package:tawjih/view/commonwidgets/matierewidget.dart';
import 'package:tawjih/view/commonwidgets/niveauwidget.dart';
import 'package:tawjih/view/widgets/onboarding/custombutton.dart';
import 'package:tawjih/view/widgets/onboarding/customslider.dart';
import 'package:tawjih/view/widgets/onboarding/dotcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Matieres extends StatelessWidget {
  Matieres({Key? key}) : super(key: key);
  final controller = Get.put(
    MatiereController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.go();
            },
            icon: Icon(Icons.golf_course),
          ),
        ],
        title: const Text('Sample Code'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: MatiereList(
              matieremodels: [],
              listcolors: controller.colors,
            )),
      ),
    );
  }
}
