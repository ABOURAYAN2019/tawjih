import 'package:tawjih/controller/home_controller.dart';
import 'package:tawjih/core/functions/validinput.dart';
import 'package:tawjih/view/commonwidgets/autocomplete_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final controller = Get.put(
    HomeController(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(3.0),
      child: Card(
          elevation: 5,
          child: GetBuilder<HomeController>(
              builder: (controller) => ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: Icon(Icons.fire_extinguisher_sharp),
                        tileColor: Colors.blue.shade100,
                        trailing: IconButton(
                            onPressed: () {
                              controller.add();
                            },
                            icon: Icon(Icons.add)),
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
                        },
                        controller: controller.extincteurCrt,
                        prefixIcon: Icon(Icons.search),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                          elevation: 5,
                          child: GetBuilder<HomeController>(
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
                                        ListTile(
                                          tileColor: Colors.blue,
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
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.factory,
                                          ),
                                          title: Text(
                                            'Entité : ',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          subtitle: Text(controller
                                                  .selectedextincteur.entite ??
                                              ""),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.map,
                                          ),
                                          title: Text(
                                            'Position : ',
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          subtitle: Text(controller
                                                  .selectedextincteur.type ??
                                              ""),
                                        ),
                                        ListTile(
                                          leading: Icon(
                                            Icons.water,
                                          ),
                                          title: Text(
                                            'designation_produit : ',
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                            style:
                                                TextStyle(color: Colors.grey),
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
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          subtitle: Text(controller
                                                  .selectedextincteur
                                                  .annee_Reepreuve
                                                  .toString() ??
                                              ""),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.check,
                                            color: Colors.black,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue.shade100,
                                          ),
                                          onPressed: () {
                                            controller.evaluate();
                                          },
                                          label: Text(
                                            "Controler",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 11,
                                                fontFamily: 'roboto'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        ElevatedButton.icon(
                                          icon: Icon(
                                            Icons.edit_attributes,
                                            color: Colors.black,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.red.shade300,
                                          ),
                                          onPressed: () {
                                            controller.editscreen();
                                          },
                                          label: Text(
                                            "Editer",
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
