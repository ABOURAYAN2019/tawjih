import 'package:flutter/material.dart';
import 'package:tawjih/controller/section_controller.dart';
import 'package:tawjih/model/sectionmodel.dart';
import 'package:tawjih/data/static.dart';

class SectionsGrid extends StatelessWidget {
  final List<Sectionmodel> setionsmodels;
  const SectionsGrid({Key? key, required this.setionsmodels}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: setionsmodels.length,
      itemBuilder: (context, index) {
        final setionmodel = setionsmodels[index];

        return AnimatedContainer(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 500),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            // color: Colors.blueAccent,
            decoration: BoxDecoration(
              color: myColors[index]!,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                setionmodel.icon != null
                    // ignore: unnecessary_cast
                    ? setionmodel.icon!
                    : Icon(
                        Icons.book,
                        size: 40,
                      ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  setionmodel.namear!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'almarai',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  setionmodel.namefr!,
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
