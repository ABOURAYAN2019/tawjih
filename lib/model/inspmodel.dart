import 'package:tawjih/model/controlmodel.dart';

class Inspectnmodel {
  late int? id;
  late String? serial;
  late String? key;
  late String? image;
  late String? user;
  late int? date;
  late List<Controlmodel>? checklist;
  Inspectnmodel({
    this.date,
    this.image,
    this.id,
    this.serial,
    this.key,
    this.checklist,
    this.user,
  });

  Inspectnmodel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    id = map["id"];
    serial = map["serial"];
    key = map["key"];
    date = map["date"];
    user = map["user"];
    image = map['image'];
    checklist = Inspectnmodel.toListofcontroles(map["checklist"]);
  }
  toJson() {
    return {
      'id': id,
      'key': key,
      "date": date,
      "user": user,
      "image": image,
      "checklist": checklist,
    };
  }

  @override
  String toString() {
    return 'id: $id,key: $key,date: $date,  user: $user,image: $image ,  checklist: $checklist ';
  }

  static List<Controlmodel> toListofcontroles(List<dynamic> list) {
    List<Controlmodel> subjectsList;
    subjectsList = list.map((e) => Controlmodel.fromJson(e)).toList();
    return subjectsList;
  }
}
