import 'package:flutter/material.dart';
import 'package:tawjih/model/matieremodel.dart';

class MatiereList extends StatelessWidget {
  final List<Matieremodel> matieremodels;
  final List<Color?> listcolors;

  const MatiereList({
    Key? key,
    required this.matieremodels,
    required this.listcolors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      // margin: EdgeInsets.symmetric(horizontal: 5),
      child: ListView.builder(
        itemCount: matieremodels.length,
        itemBuilder: (context, index) {
          Matieremodel matieremodel = matieremodels[index];

          return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 500),
            child: Container(
              padding: EdgeInsets.all(5),
              // margin: EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  // side: BorderSide(color: Colors.black),
                ),
                tileColor: listcolors[index]!,
                leading: matieremodel.icon!,
                title: Text(matieremodel.matiere!),
              ),
            ),
          );
        },
      ),
    );
  }
}
