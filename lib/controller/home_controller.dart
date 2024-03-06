import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tawjih/controller/auth_controller.dart';
import 'package:tawjih/core/services.dart';
import 'package:tawjih/model/extmodel.dart';
import 'package:tawjih/view/screens/addext.dart';
import 'package:tawjih/view/screens/evaluate.dart';
import 'package:tawjih/view/screens/view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  TextEditingController extincteurCrt = TextEditingController();

  FirebaseDatabase database = FirebaseDatabase.instance;
  String? _user = Get.find<AuthController>().user;
  String? get user => _user;

  // List<String> emplacements = [];
  // List<String> types = [];
  // late File? _photo;
  // final ImagePicker _picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String n_serie = "";
  String domaine = "";
  List<ExtModel> _extincteurs = [];
  ExtModel selectedextincteur = ExtModel();
  List<ExtModel> get extincteurs => _extincteurs;
  MyServices myservices = Get.find();
  TextEditingController t_date_debut = TextEditingController();

  getdata() async {
    if (_user != null) {
      print(domaine);
      domaine = _user!.split("@")[1].split(".")[0];
      EasyLoading.show(status: "Téléchargement");
      if (!myservices.sharedPreferences.containsKey("exts")) {
        getdatafromcloud();
      } else {
        getdatafromlocal();
      }

      EasyLoading.dismiss();
      update();
    }
  }

  @override
  void onInit() async {
    await getdata();
    super.onInit();
  }

  @override
  void onClose() async {
    try {
      EasyLoading.dismiss();
    } catch (e) {}

    super.onClose();
  }

  showmsg(String message) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Attention',
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    ).show();
  }

  getdatafromlocal() {
    List<ExtModel> _exts = [];
    ExtModel _ext;
    final condJson = myservices.sharedPreferences.getString('exts') ?? '';
    List mapcond = jsonDecode(condJson);
    mapcond.forEach(
      (element) {
        _ext = ExtModel.fromJson(element);
        _exts.add(_ext);
      },
    );
    _extincteurs = _exts;
  }

  getdatafromcloud() async {
    Map extincteur_;
    List<Map>? extincteurs_ = [];
    List<ExtModel> cs = [];
    ExtModel c;
    DatabaseReference lextincteurs = database.ref('extincteurs');
    DataSnapshot snapshot = await lextincteurs.get();
    if (snapshot.value != null) {
      final map = snapshot.value as Map;
      map.forEach((key, value) {
        extincteur_ = value;
        extincteur_['key'] = key;
        extincteurs_?.add(value);
        c = ExtModel.fromJson(extincteur_);
        cs.add(c);
      });
      _extincteurs = cs;
    }
    final String condencodedData = json.encode(cs);
    myservices.sharedPreferences.setString("exts", condencodedData);
    update();
  }

  void selectextincteur(String? p0) {
    selectedextincteur =
        _extincteurs.where((element) => element.n_serie == p0).first;
    update();
  }

  evaluate() {
    Get.to(() => EvaluateScreen(),
        transition: Transition.downToUp,
        duration: Duration(microseconds: 500),
        arguments: [selectedextincteur],
        fullscreenDialog: true);
  }

  editscreen() {
    Get.to(() => ViewScreen(),
        transition: Transition.downToUp,
        duration: Duration(microseconds: 500),
        arguments: [selectedextincteur],
        fullscreenDialog: true);
  }

  void save() {}

  void add() {
    Get.to(() => AddextScreen(),
        transition: Transition.downToUp,
        duration: Duration(microseconds: 500),
        arguments: [],
        fullscreenDialog: true);
  }

  void findext(String? p0) {}
}
