class ExtModel {
  late String? id;
  late String? key;
  late String? entite;
  late String? position;
  late String? type;
  late int? annee_Reepreuve;
  late int? annee_fabrication;
  late String? capacite;
  late String? famille;
  late String? n_serie;
  late String? user;
  late String? designation_produit;
  late int? adddate;
  late int? updatedate;
  late String? updater;

  ExtModel(
      {this.updater,
      this.annee_Reepreuve,
      this.user,
      this.annee_fabrication,
      this.id,
      this.adddate,
      this.updatedate,
      this.famille,
      this.key,
      this.entite,
      this.type,
      this.position,
      this.n_serie,
      this.capacite,
      this.designation_produit});

  ExtModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    capacite = map["capacite"];
    updater = map["updater"];
    entite = map["entite"];
    id = map["id"];
    key = map["key"];
    n_serie = map["n_serie"];
    type = map["type"];
    annee_Reepreuve = map["annee_Reepreuve"];
    annee_fabrication = map["annee_fabrication"];
    user = map["user"];
    updatedate = map["updatedate"];
    famille = map["famille"];
    adddate = map["adddate"];
    position = map["position"];
    designation_produit = map["designation_produit"];
  }

  toJson() {
    return {
      "annee_Reepreuve": annee_Reepreuve,
      "id": id,
      "designation_produit": designation_produit,
      "key": key,
      "famille": famille,
      "type": type,
      "annee_fabrication": annee_fabrication,
      "entite": entite,
      "capacite": capacite,
      "user": user,
      "adddate": adddate,
      "n_serie": n_serie,
      "updatedate": updatedate,
      "updater": updater,
      "position": position
    };
  }

  @override
  String toString() {
    return 'id: $id,key: $key,n_serie: $n_serie,  user: $user,adddate: $adddate ,  capacite: $capacite  , designation_produit: $designation_produit  , famille: $famille ,    ';
  }
}
