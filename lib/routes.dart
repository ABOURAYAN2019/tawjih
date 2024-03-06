import 'package:mainquiz/view/control_view.dart';
import 'package:mainquiz/view/screens/matiere.dart';
import 'package:mainquiz/view/screens/onboarding.dart';
import 'package:mainquiz/view/screens/sections.dart';
import 'package:mainquiz/view/screens/signin.dart';
import 'package:mainquiz/view/screens/view.dart';

import 'package:get/get.dart';
import 'package:mainquiz/view/screens/welcome.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: "/", page: () => ControlView()),
  GetPage(name: "/onboarding", page: () => OnBoarding()),
  GetPage(name: "/login", page: () => Signin()),
  GetPage(name: "/welcome", page: () => Welcome()),
  GetPage(name: "/welcome", page: () => Matieres()),
  GetPage(name: "/sections", page: () => Sections()),
];
