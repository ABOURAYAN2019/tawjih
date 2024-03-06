import 'package:tawjih/controller/evaluate_controller.dart';
import 'package:tawjih/core/functions/validinput.dart';
import 'package:tawjih/model/extmodel.dart';
import 'package:tawjih/view/commonwidgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EvaluateScreen extends StatelessWidget {
  EvaluateScreen({Key? key}) : super(key: key);
  final ExtModel extinceur = Get.arguments[0];
  final controller = Get.put(
    EvaluateController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.check),
          backgroundColor: Colors.blueAccent,
          title: Text("Checklist de contrôle"),
        ),
        body: SafeArea(
            child: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(3.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(("N° de serie :" + (extinceur.n_serie ?? ""))),
                subtitle: Text(
                  ("Famille :" + (extinceur.famille ?? "")),
                ),
                tileColor: Colors.blue.shade200,
              ),
              GetBuilder<EvaluateController>(
                  builder: (controller) => Card(
                        elevation: 5,
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            CustomTextformfield(
                              valid: (val) {
                                if (val == null) return "champs vide";
                                return validInput(val!, 5, 30, "text");
                              },
                              hintText: "Date ",
                              headingText: "Date",
                              prefixIcon: Icon(Icons.date_range),
                              readonly: true,
                              onTap: () => controller.Adddatedebut(),
                              controller: controller.t_date_debut,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.checklist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return controller
                                              .checklist[index].categorie !=
                                          extinceur.famille
                                      ? SizedBox.shrink()
                                      : SwitchListTile(
                                          title: Text(controller
                                                  .checklist[index].controle ??
                                              ""),
                                          onChanged: (bool value) {
                                            controller.check(
                                                value,
                                                controller
                                                        .checklist[index].id ??
                                                    -1,
                                                extinceur.n_serie ?? "");
                                          },
                                          value: controller.checklist[index]
                                                      .valeur ==
                                                  0
                                              ? false
                                              : true,
                                        );
                                }),
                          ],
                        ),
                      )),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: ElevatedButton.icon(
                    onPressed: () {
                      controller.save(extinceur.n_serie ?? "");
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
                      style: TextStyle(fontFamily: 'roboto', fontSize: 14),
                    )),
              )
            ],
          ),
        )));
  }
}
