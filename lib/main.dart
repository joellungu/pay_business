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
import 'utils/requete.dart';
import 'widgets/paiement_controller.dart';

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
  PaiementController paiementController = Get.put(PaiementController());
  //
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  //
  final box = GetStorage();
  //Requete requete = Requete();
  //
  @override
  Widget build(BuildContext context) {
    Map e = box.read("boutique") ?? {};
    print(e);
    //
    return GetMaterialApp(
      title: 'Pay Business',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: e['id'] != null ? Accueil() : Connexion(),
      //Connexion()
      //Accueil(),
      //Entreprise(),
      //Profile(),
    );
  }
}
