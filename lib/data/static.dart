import 'package:flutter/material.dart';
import 'package:tawjih/model/sectionmodel.dart';
import 'package:tawjih/model/controlmodel.dart';
import 'package:tawjih/model/matieremodel.dart';
import 'package:tawjih/model/niveaumodel.dart';

import '../core/constant/imgaeasset.dart';
import '../model/onboardingmodel.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      title: "QuizCompétences Pro",
      body:
          " Découvrez de nouvelles compétences avec des \n quiz interactifs adaptés à votre domaine professionnel.",
      image: AppImageAsset.onBoardingImageTwo),
  OnBoardingModel(
      title: "Évaluation Niveaux Quiz",
      body:
          "Répondez à des questions ciblées pour évaluer vos \n connaissances et progresser à travers différents niveaux.",
      image: AppImageAsset.onBoardingImageThree),
  OnBoardingModel(
      title: " Badges Compétence Pro",
      body:
          "Gagnez des badges de compétence à chaque niveau atteint, \n prêts à être partagés sur vos réseaux professionnels. ",
      image: AppImageAsset.onBoardingImageFour),
  OnBoardingModel(
      title: "Parcours d'Expertise Quiz ",
      body:
          "  Explorez notre application intuitive de quiz, apprenez en  \n vous amusant et suivez votre progression vers l'expertise.",
      image: AppImageAsset.onBoardingImageOne),
];

List<Controlmodel> controlModelList = [];

List<Color?> myColors = [
  Colors.lightBlue[100],
  Colors.lightGreen[100],
  Colors.blue[100],
  Colors.yellow[100],
  Colors.orange[100],
  Colors.pink[100],
  Colors.purple[100],
  Colors.teal[100],
  Colors.cyan[100],
  Colors.indigo[100],
  Colors.deepPurple[100],
];
