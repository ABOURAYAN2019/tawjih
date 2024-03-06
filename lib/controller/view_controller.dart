import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:tawjih/controller/auth_controller.dart';
import 'package:tawjih/core/services.dart';
import 'package:tawjih/model/controlmodel.dart';
import 'package:tawjih/model/extmodel.dart';
import 'package:tawjih/model/inspmodel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../view/screens/addext.dart';
import '../view/screens/evaluate.dart';
import '../view/screens/view.dart';

class ViewController extends GetxController {
  TextEditingController extincteurCrt = TextEditingController();

  FirebaseDatabase database = FirebaseDatabase.instance;
  String? _user = Get.find<AuthController>().user;
  String? get user => _user;
  Inspectnmodel laststate = Inspectnmodel();

  String n_serie = "";
  String domaine = "";
  List<ExtModel> _extincteurs = [];
  ExtModel selectedextincteur = ExtModel();
  List<ExtModel> get extincteurs => _extincteurs;
  MyServices myservices = Get.find();
  List<Controlmodel>? checklist = [];
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

  void findext(String? p0) async {
    Inspectnmodel? etat = Inspectnmodel();
    DatabaseReference lextincteurs = database.ref('etat').child(p0 ?? '');
    DataSnapshot snapshot = await lextincteurs.get();
    if (snapshot.exists) {
      inspect(snapshot.value);
      final map = snapshot.value as Map;
      etat = Inspectnmodel.fromJson(map);
      laststate = etat;
      checklist =
          etat.checklist?.where((element) => element.valeur == 1).toList();
      print(etat.toString());

      update();
    } else {
      print("no data");
    }
  }

  generatePdf() async {
    final pdf = pw.Document();
    final ByteData logoByteData =
        await rootBundle.load('assets/images/logoocp.png');
    final Uint8List logoBytes = logoByteData.buffer.asUint8List();
    final font =
        await rootBundle.load("assets/fonts/Montserrat-VariableFont_wght.ttf");
    final ttf = Font.ttf(font);
    // Add a page to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Simple header with logo and date
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(pw.MemoryImage(
                        // Load the logo image from assets
                        logoBytes), width: 100, height: 100),
                    pw.Text(
                      DateTime.now().toString(), // Current date
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, font: ttf),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),

                // Title of the document in text format
                pw.Text(
                  'Document Title',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 20, font: ttf),
                ),
                pw.SizedBox(height: 20),
                pw.ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => pw.Text(
                      " Replace this with your actual list items",
                      style: pw.TextStyle(font: ttf)),
                ),
                // List of 10 elements as a table with two columns (name and value)
                pw.TableHelper.fromTextArray(
                  cellStyle: pw.TextStyle(font: ttf),
                  border: null,
                  headers: ['Name', 'Value'],
                  data: List.generate(
                    10,
                    (index) => ['Name $index', 'Value $index'],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    Uint8List pdfData = await pdf.save();
    inspect(pdfData);
    final Directory appDocumentsDir = await getTemporaryDirectory();
    inspect(appDocumentsDir);

    String path = appDocumentsDir.path;
    inspect(path);

    final String fileName = 'invoice.pdf';
    File myfile = await File(path + '/' + fileName).writeAsBytes(pdfData);
    inspect(myfile);
    await Share.shareXFiles(
      [XFile(myfile.path)],
    );

    // await OpenFile.open(myfile.path);
    // await launchUrl(Uri.file(myfile.path));
    //await fo.OpenFile.open(myfile.path);
  }
}
