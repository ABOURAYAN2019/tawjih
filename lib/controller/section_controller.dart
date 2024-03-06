import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tawjih/controller/auth_controller.dart';
import 'package:tawjih/core/services.dart';
import 'package:tawjih/data/static.dart';
import 'package:tawjih/model/extmodel.dart';
import 'package:tawjih/model/niveaumodel.dart';
import 'package:tawjih/model/sectionmodel.dart';
import 'package:tawjih/view/screens/addext.dart';
import 'package:tawjih/view/screens/evaluate.dart';
import 'package:tawjih/view/screens/matiere.dart';
import 'package:tawjih/view/screens/view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SectionController extends GetxController {
  FirebaseDatabase database = FirebaseDatabase.instance;
  String? _user = Get.find<AuthController>().user;
  String? get user => _user;

  // List<String> emplacements = [];
  // List<String> types = [];
  // late File? _photo;
  // final ImagePicker _picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

//  List<Sectionmodel> _sections = SectionmodelList;
  // List<Sectionmodel> get sections => _sections;
  List<Color?> _colors = myColors;
  List<Color?> get colors => _colors;
  MyServices myservices = Get.find();

  @override
  void onInit() async {
    //await getdata();
    super.onInit();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  go() async {
    await Get.to(() => Matieres(),
        transition: Transition.downToUp,
        duration: Duration(microseconds: 500),
        arguments: [],
        fullscreenDialog: true);
  }
}
