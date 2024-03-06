class Entitenmodel {
  late int? id;
  late String? entite;
  late String? key;
  Entitenmodel({this.id, this.entite, this.key});

  Entitenmodel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    id = map["id"];
    entite = map["entite"];
    key = map["key"];
  }
  toJson() {
    return {
      'entite': entite,
      'key': key,
      "id": id,
    };
  }
}
