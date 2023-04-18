import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/accueil.dart';
import 'pages/entreprise.dart';
import 'pages/login/connexion.dart';
import 'utils/commande_controller.dart';
import 'utils/compte_controller.dart';
import 'utils/login_controller.dart';
import 'utils/panier_controller.dart';
import 'utils/produit_controller.dart';

void main() async {
  //
  await GetStorage.init();
  //
  LoginController applicationController = Get.put(LoginController());
  //
  ProduitController produitController = Get.put(ProduitController());
  //
  CompteController compteController = Get.put(CompteController());
  //
  CommandeController commandeController = Get.put(CommandeController());
  //
  PanierController panierController = Get.put(PanierController());
  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Pay Business',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: Connexion()
        //Accueil(),
        //Entreprise(),
        //Profile(),
        );
  }
}
