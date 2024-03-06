import 'package:tawjih/controller/addext_controller.dart';
import 'package:tawjih/core/functions/validinput.dart';
import 'package:tawjih/view/commonwidgets/custom-dropdown_form_field.dart';
import 'package:tawjih/view/commonwidgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddextScreen extends StatelessWidget {
  AddextScreen({Key? key}) : super(key: key);
  final controller = Get.put(
    AddextController(),
  );
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.check),
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close))
          ],
          backgroundColor: Colors.green.shade400,
          title: Text("Ajouter un extincteur"),
        ),
        body: SafeArea(
            child: Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(3.0),
                child: Card(
                  elevation: 4,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextformfield(
                            hintText: "N° de serie",
                            readonly: false,
                            controller: controller.serialCrt,
                            valid: (val) {
                              return validInput(val!, 2, 30, "text");
                            },
                            prefixIcon: Icon(Icons.people),
                          ),
                          CustumDropdownSearch(
                            hintText: "Designation de produit",
                            items: ["CO2", "POUDRE ABC", "EAU"],
                            valid: (val) {
                              return validInput(val!, 2, 30, "text");
                            },
                            onChange: (p0) => {controller.produit = p0 ?? ""},
                            //selectedItem: controller.selectedservice,
                          ),
                          CustumDropdownSearch(
                            hintText: "Capacité en L/KG",
                            items: [
                              "5KG",
                              "2KG",
                              "9KG",
                              "6KG",
                              "9L",
                              "6L",
                              "50KG",
                              "10KG",
                              "20KG",
                              "30KG",
                              "50L",
                            ],
                            valid: (val) {
                              return validInput(val!, 2, 30, "text");
                            },
                            onChange: (p0) => {controller.capacite = p0 ?? ""},
                            //selectedItem: controller.selectedservice,
                          ),

                          CustumDropdownSearch(
                            hintText: "Designation de produit",
                            items: ["CO2", "POUDRE ABC", "EAU"],
                            valid: (val) {
                              return validInput(val!, 2, 30, "text");
                            },
                            onChange: (p0) => {controller.produit = p0 ?? ""},
                            //selectedItem: controller.selectedservice,
                          ),
                          CustumDropdownSearch(
                            hintText: "Type",
                            items: [
                              "permanant",
                              "auxiliaire",
                            ],
                            valid: (val) {
                              return validInput(val!, 2, 30, "text");
                            },
                            onChange: (p0) => {controller.type = p0 ?? ""},
                            //selectedItem: controller.selectedservice,
                          ),

                          GetBuilder<AddextController>(
                              builder: (_) => CustumDropdownSearch(
                                    hintText: "Entité",
                                    items: controller.entites
                                        .map((e) => e.entite ?? "")
                                        .toList(),
                                    valid: (val) {
                                      return validInput(val!, 2, 30, "text");
                                    },
                                    onChange: (p0) =>
                                        {controller.entite = p0 ?? ""},
                                    //selectedItem: controller.selectedservice,
                                  )),

                          CustomTextformfield(
                            hintText: "Position",
                            readonly: false,
                            controller: controller.positioncrt,
                            valid: (val) {
                              return validInput(val!, 2, 30, "text");
                            },
                            prefixIcon: Icon(Icons.map_sharp),
                          ),
                          // CustumDropdownSearch(
                          //   hintText: "Nature de transport",
                          //   items: controller.transport,
                          //   onChange: (p0) {
                          //     controller.selectedtypetrajet = p0 ?? '';
                          //   },
                          //   selectedItem: controller.selectedtypetrajet,
                          //   valid: (val) {
                          //     return validInput(val!, 2, 30, "text");
                          //   },
                          // ),

                          CustomTextformfield(
                            hintText: "Constructeur",
                            readonly: false,
                            controller: controller.constucteurcrt,
                            valid: (val) {
                              return validInput(val!, 2, 30, "text");
                            },
                            prefixIcon: Icon(Icons.factory),
                          ),
                          SizedBox(
                            height: 12,
                          ),

                          GetBuilder<AddextController>(
                              builder: (_) => CustomTextformfield(
                                    valid: (val) {
                                      return validInput(val!, 2, 30, "text");
                                    },
                                    hintText: "Date de fabrication  ",
                                    readonly: true,
                                    onTap: () {
                                      controller.Adddatefabrication();
                                    },
                                    prefixIcon: Icon(Icons.date_range),
                                    controller: controller.t_date_fabrication,
                                  )),
                          GetBuilder<AddextController>(
                              builder: (_) => CustomTextformfield(
                                    hintText: "Date de réepreuve",
                                    readonly: true,
                                    valid: (val) {
                                      return validInput(val!, 2, 30, "text");
                                    },
                                    onTap: () {
                                      controller.Adddatereepreuve();
                                    },
                                    prefixIcon: Icon(Icons.date_range),
                                    controller:
                                        controller.t_date_date_reepreuve,
                                  )),
                          // CustumDropdownSearch(
                          //     hintText: "Circuit",
                          //     items: controller.circuit,
                          //     valid: (val) {
                          //       return "true";
                          //     }),
                          SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: ElevatedButton.icon(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    await controller.save();
                                  }
                                },
                                icon: Icon(
                                  Icons.save,
                                  size: 30,
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 50),
                                  backgroundColor: Colors.green,
                                ),
                                label: Text(
                                  "Sauvegarder",
                                  style: TextStyle(
                                      fontFamily: 'roboto', fontSize: 14),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
