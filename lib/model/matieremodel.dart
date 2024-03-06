import 'package:flutter/material.dart';

class Matieremodel {
  late String? matiere;
  late String? slug;
  late int? id;
  late String? lang;
  late Icon? icon;
  late String? key;

  Matieremodel(
      {this.id, this.lang, this.matiere, this.icon, this.slug, this.key});

  Matieremodel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    id = map["id"];
    matiere = map["matiere"];
    slug = map["slug"];
    lang = map["lang"];
    icon = map["icon"];
    key = map["key"];
  }

  toJson() {
    return {
      'lang': lang,
      'matiere': matiere,
      'slug': slug,
      "id": id,
      "key": key,
      "icon": icon,
    };
  }

  @override
  String toString() {
    return 'id: $id,matiere: $matiere,slug: $slug,  lang: $lang';
  }
}
