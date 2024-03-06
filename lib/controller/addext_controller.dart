import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tawjih/controller/auth_controller.dart';
import 'package:tawjih/core/services.dart';
import 'package:tawjih/model/entitemodel.dart';
import 'package:tawjih/model/extmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddextController extends GetxController {
  TextEditingController extincteurCrt = TextEditingController();
  TextEditingController positioncrt = TextEditingController();
  TextEditingController serialCrt = TextEditingController();
  TextEditingController constucteurcrt = TextEditingController();
  late String produit;
  late String capacite;
  late String type;
  late String entite;
  FirebaseDatabase database = FirebaseDatabase.instance;
  String? _user = Get.find<AuthController>().user;
  String? get user => _user;
  late DateTime date_fabrication;
  late DateTime date_reepreuve;
  TextEditingController t_date_fabrication = TextEditingController();
  TextEditingController t_date_date_reepreuve = TextEditingController();
  // List<String> emplacements = [];
  // List<String> types = [];
  // late File? _photo;
  // final ImagePicker _picker = ImagePicker();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  String n_serie = "";
  String domaine = "";
  List<Entitenmodel> _entites = [];
  ExtModel selectentite = ExtModel();
  List<Entitenmodel> get entites => _entites;
  MyServices myservices = Get.find();
  TextEditingController t_date_debut = TextEditingController();

  getdata() async {
    if (_user != null) {
      if (!myservices.sharedPreferences.containsKey("entites")) {
        getdatafromcloud();
      } else {
        getdatafromlocal();
      }

      // EasyLoading.dismiss();
      update();
    }
  }

  Adddatefabrication() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime
            .now(), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (pickedDate == null) return;

    t_date_fabrication.text = DateFormat('yyyy').format(pickedDate);
    date_fabrication = pickedDate;
  }

  Adddatereepreuve() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(2000, 1, 1,
            1), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (pickedDate == null) return;

    t_date_date_reepreuve.text = DateFormat('yyyy').format(pickedDate);
    date_reepreuve = pickedDate;
  }

  @override
  void onInit() async {
    await getdata();
    super.onInit();
  }

  showmsg(String message) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: 'Message',
      desc: message,
      btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }

  getdatafromlocal() {
    List<Entitenmodel> _ents = [];
    Entitenmodel _ent;
    final condJson = myservices.sharedPreferences.getString('entites') ?? '';
    List mapcond = jsonDecode(condJson);
    mapcond.forEach(
      (element) {
        _ent = Entitenmodel.fromJson(element);
        _ents.add(_ent);
      },
    );
    _entites = _ents;
    update();
  }

  getdatafromcloud() async {
    Map entity_;
    List<Map>? entities = [];
    List<Entitenmodel> cs = [];
    Entitenmodel c;
    DatabaseReference lextincteurs = database.ref('entites');
    DataSnapshot snapshot = await lextincteurs.get();
    if (snapshot.value != null) {
      final map = snapshot.value as Map;
      map.forEach((key, value) {
        entity_ = value;
        inspect("--------------------");
        inspect(value);
        entity_['key'] = key;
        entities?.add(value);
        c = Entitenmodel.fromJson(entity_);
        cs.add(c);
      });
      _entites = cs;
      inspect(_entites);
      final String condencodedData = json.encode(cs);
      myservices.sharedPreferences.setString("entites", condencodedData);
      update();
    }
  }

  Future save() async {
    EasyLoading.show(status: "Enregistrement en cours");
    String newPostKey = "";
    ExtModel extinc = ExtModel();
    extinc.adddate = DateTime.now().microsecondsSinceEpoch;
    extinc.updatedate = DateTime.now().microsecondsSinceEpoch;
    extinc.updater = user;
    extinc.user = user;
    extinc.annee_fabrication = date_fabrication.year;
    extinc.annee_Reepreuve = date_reepreuve.year;
    extinc.capacite = capacite;
    extinc.designation_produit = produit;
    extinc.n_serie = serialCrt.text;
    extinc.entite = entite;
    extinc.famille = produit == "POUDRE ABC" ? "POUDRE" : produit;
    extinc.position = positioncrt.text;
    extinc.type = type;
    inspect(extinc);
    DatabaseReference ref = database.ref("extincteurs");
    newPostKey = ref.push().key!;
    await ref.child(newPostKey).set(extinc.toJson()).then((value) {
      EasyLoading.dismiss();
      //  showmsg("Votre extincteur à été ajoutéd à la base");
      positioncrt.text = "";
      entite = "";
      positioncrt.text = "";
      update();
      // Get.back();
      Navigator.pop(Get.context!);
      // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => {EasyLoading.dismiss()});
  }
}
