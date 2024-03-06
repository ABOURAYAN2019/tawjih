import 'package:tawjih/controller/view_controller.dart';
import 'package:tawjih/core/functions/validinput.dart';
import 'package:tawjih/view/commonwidgets/autocomplete_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewScreen extends StatelessWidget {
  ViewScreen({Key? key}) : super(key: key);

  final controller = Get.put(
    ViewController(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      child: Card(
          elevation: 5,
          child: GetBuilder<ViewController>(
              builder: (controller) => ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: Icon(Icons.fire_extinguisher_sharp),
                        tileColor: Colors.blue.shade100,
                        title: Text("Chercher un extincteur"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Autocompleteformfield(
                        valid: (val) {
                          return validInput(val!, 5, 30, "text");
                        },
                        suggestons: controller.extincteurs
                            .map((e) => e.n_serie ?? '')
                            .toList(),
                        hintText: "N° serie",
                        onselect: (p0) {
                          controller.selectextincteur(p0);
                          controller.findext(p0);
                        },
                        controller: controller.extincteurCrt,
                        prefixIcon: Icon(Icons.search),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                          elevation: 5,
                          child: GetBuilder<ViewController>(
                              builder: (controller) => controller
                                          .selectedextincteur.n_serie ==
                                      null
                                  ? Container(
                                      height: 500,
                                      child: Center(
                                        child: Text(
                                          "Pas de données",
                                        ),
                                      ),
                                    )
                                  : ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        ExpansionTile(
                                          leading: Icon(
                                            Icons.swipe_right_alt,
                                          ),
                                          title: Text(
                                            'N° serie : ',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          subtitle: Text(controller
                                                  .selectedextincteur.n_serie ??
                                              ""),
                                          children: [
                                            ListTile(
                                              leading: Icon(
                                                Icons.factory,
                                              ),
                                              title: Text(
                                                'Entité : ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              subtitle: Text(controller
                                                      .selectedextincteur
                                                      .entite ??
                                                  ""),
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.map,
                                              ),
                                              title: Text(
                                                'Position : ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              subtitle: Text(
                                                (controller.selectedextincteur
                                                        .position ??
                                                    ""),
                                              ),
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.menu,
                                              ),
                                              title: Text(
                                                'Type : ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              subtitle: Text(controller
                                                      .selectedextincteur
                                                      .type ??
                                                  ""),
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.water,
                                              ),
                                              title: Text(
                                                'designation_produit : ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              subtitle: Text(controller
                                                      .selectedextincteur
                                                      .designation_produit ??
                                                  ""),
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.monitor_weight,
                                              ),
                                              title: Text(
                                                'Capacité : ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              subtitle: Text(controller
                                                      .selectedextincteur
                                                      .capacite ??
                                                  ""),
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.date_range,
                                              ),
                                              title: Text(
                                                'Année de production  : ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              subtitle: Text(controller
                                                      .selectedextincteur
                                                      .annee_fabrication
                                                      .toString() ??
                                                  ""),
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.date_range_sharp,
                                              ),
                                              title: Text(
                                                'Anneé de Réepreuve: ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              subtitle: Text(controller
                                                      .selectedextincteur
                                                      .annee_Reepreuve
                                                      .toString() ??
                                                  ""),
                                            ),
                                          ],
                                        ),
                                        controller.laststate.date == null
                                            ? Center(
                                                child: Text(
                                                "pas de données de contrôle  pour cet extincteur",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ))
                                            : ListTile(
                                                title: Text("Inspection du " +
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime
                                                            .fromMillisecondsSinceEpoch(
                                                                controller
                                                                        .laststate
                                                                        .date ??
                                                                    0))
                                                        .toString()),
                                                tileColor:
                                                    Colors.green.shade300,
                                              ),
                                        ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                controller.checklist?.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                  leading:
                                                      const Icon(Icons.list),
                                                  trailing: Text(
                                                    (controller
                                                            .checklist?[index]
                                                            .valeur
                                                            .toString() ??
                                                        ""),
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 15),
                                                  ),
                                                  title: Text(controller
                                                          .checklist?[index]
                                                          .controle ??
                                                      ""));
                                            }),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.picture_as_pdf,
                                            color: Colors.black,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.shade400,
                                          ),
                                          onPressed: () {
                                            controller.generatePdf();
                                          },
                                          label: Text(
                                            "Exporter rapport",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontFamily: 'roboto'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        controller.laststate.date == null
                                            ? SizedBox.shrink()
                                            : ElevatedButton.icon(
                                                icon: Icon(
                                                  Icons.file_copy,
                                                  color: Colors.black,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green.shade400,
                                                ),
                                                onPressed: () {
                                                  controller.editscreen();
                                                },
                                                label: Text(
                                                  "Télécharger état XLS",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 11,
                                                      fontFamily: 'roboto'),
                                                ),
                                              )
                                      ],
                                    ))),
                    ],
                  ))),
    );
  }
}
