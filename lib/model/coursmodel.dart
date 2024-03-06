class Coursmodel {
  late String? id;
  late String? cours;
  late String? ordernum;
  late String? slug;
  late String? idmatiere;
  late String? periode;
  late String? lang;

  Coursmodel(
      {this.id,
      this.lang,
      this.ordernum,
      this.cours,
      this.slug,
      this.idmatiere,
      this.periode});

  Coursmodel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    id = map["id"];
    lang = map["lang"];
    cours = map["cours"];
    ordernum = map["ordernum"];
    periode = map["periode"];
    slug = map["slug"];
    idmatiere = map["idmatiere"];
  }

  toJson() {
    return {
      'cours': cours,
      'ordernum': ordernum,
      'slug': slug,
      'lang': lang,
      'periode': periode,
      'idmatiere': idmatiere,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'id: $id,idmatiere: $idmatiere,cours: $cours,  slug: $slug';
  }
}
