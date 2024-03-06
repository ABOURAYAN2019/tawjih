import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tawjih/controller/auth_controller.dart';
import 'package:tawjih/data/static.dart';
import 'package:tawjih/model/controlmodel.dart';
import 'package:tawjih/model/extmodel.dart';
import 'package:tawjih/model/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

class EvaluateController extends GetxController {
  FirebaseDatabase database = FirebaseDatabase.instance;
  bool loading = false;
  List<ExtModel> extincteurs = [];
  List<Controlmodel> checklist = controlModelList;
  String type = "";
  String link = "";
  String? _user = Get.find<AuthController>().user;
  String? get user => _user;
  late UserModel _userdata;
  String? _userid = Get.find<AuthController>().uid;
  late DateTime date_debut;
  TextEditingController t_date_debut = TextEditingController();

  late File? _photo;
  final ImagePicker _picker = ImagePicker();
  String emplacement = "";
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  @override
  void onClose() {
    super.onClose();
  }

  getdata() async {}

  close() {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'test',
      desc: "test",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        Get.back();
      },
    ).show();
  }

  @override
  void onInit() async {
    if (_user != null) {
      // print(domaine);
      // domaine = _user!.split("@")[1].split(".")[0];
      //  EasyLoading.show(status: "Chargement");
      await getdata();
      //  EasyLoading.dismiss();
      update();
    }
    super.onInit();
  }

  void check(bool value, int s, String p) {
    int index = checklist.indexWhere((element) => element.id == s);
    value == true ? checklist[index].valeur = 1 : checklist[index].valeur = 0;
    update();
  }

  Adddatedebut() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime
            .now(), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (pickedDate == null) return;

    t_date_debut.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    date_debut = pickedDate;
  }

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    // setState(() {
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected.');
    }
    // });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    // setState(() {
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected.');
    }
    //  });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';
    EasyLoading.show(status: 'Enregisterment en cours...');
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
      link = await ref.getDownloadURL();
      EasyLoading.dismiss();
      update();
    } catch (e) {
      print('error occured');
      EasyLoading.dismiss();
    }
  }

  addphoto() {
    Get.bottomSheet(Container(
        height: 150,
        color: Colors.grey,
        child: Center(
            child: Column(
          children: [
            ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text('Gallery'),
                onTap: () {
                  imgFromGallery();
                  Get.back();
                }),
            new ListTile(
              leading: new Icon(Icons.photo_camera),
              title: new Text('Camera'),
              onTap: () {
                imgFromCamera();
                Get.back();
              },
            ),
          ],
        ))));
  }

  void save(String serial) async {
    inspect(serial);
    String newPostKey = "";
    List<Map<String, dynamic>> controles = [];
    Map<String, dynamic> obser = {};
    checklist.forEach((element) {
      controles.add(element.toJson());
    });
    obser['date'] = DateTime.now().millisecondsSinceEpoch;
    obser['image'] = "";
    obser['serial'] = serial;
    obser['checklist'] = controles;
    obser["user"] = user;
    inspect(obser);
    DatabaseReference ref = database.ref("historique");
    DatabaseReference ref2 = database.ref("etat");
    newPostKey = ref.push().key!;
    inspect("----------------------------------");
    inspect(obser);
    await ref2.child(serial).set(obser);
    await ref.child(newPostKey).update(obser).then((value) {
      //EasyLoading.dismiss();
      //  showmsg("Votre extincteur à été ajoutéd à la base");
      checklist = controlModelList;
      Get.back();
    });
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
    ).show();
  }
}
