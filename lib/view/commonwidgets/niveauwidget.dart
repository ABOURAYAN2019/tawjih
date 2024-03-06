import 'package:flutter/material.dart';
import 'package:tawjih/model/niveaumodel.dart';

class NiveauxGrid extends StatelessWidget {
  final List<Niveaumodel> niveaumodels;
  const NiveauxGrid({Key? key, required this.niveaumodels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: niveaumodels.length,
      itemBuilder: (context, index) {
        final niveaumodel = niveaumodels[index];

        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 500),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            // color: Colors.blueAccent,
            decoration: BoxDecoration(
              color: niveaumodel.mcolor!,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              children: [
                niveaumodel.icon != null
                    ? Icon(niveaumodel.icon! as IconData?)
                    : Icon(
                        Icons.book,
                        size: 40,
                      ),
                Text(
                  niveaumodel.namear!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'almarai',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  niveaumodel.namefr!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'roboto',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
