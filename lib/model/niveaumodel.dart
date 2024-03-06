import 'package:flutter/material.dart';

class Niveaumodel {
  late int? id;
  late String? slug;
  late String? namear;
  late String? namefr;
  late Icon? icon;
  late Color? mcolor;

  Niveaumodel(
      {this.mcolor, this.id, this.slug, this.namear, this.namefr, this.icon});

  Niveaumodel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    mcolor = map["mcolor"];
    id = map["id"];
    namear = map["namear"];
    namefr = map["namefr"];
    slug = map["slug"];
    icon = map["icon"];
  }

  toJson() {
    return {
      'namear': namear,
      'namefr': namefr,
      'slug': slug,
      'mcolor': mcolor,
      'icon': icon,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'id: $id,namear: $namear,namefr: $namefr,  slug: $slug';
  }
}
