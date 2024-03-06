class Controlmodel {
  late int? valeur;
  late String? controle;
  late int? id;
  late String? categorie;

  Controlmodel({this.id, this.valeur, this.controle, this.categorie});

  Controlmodel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    id = map["id"];
    categorie = map["categorie"];
    valeur = map["valeur"];
    controle = map["controle"];
  }

  toJson() {
    return {
      'valeur': valeur,
      'controle': controle,
      'categorie': categorie,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'id: $id,controle: $controle,valeur: $valeur,  categorie: $categorie';
  }
}
