import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_business/pages/accueil.dart';
import 'package:pay_business/utils/requete.dart';

class LoginController extends GetxController {
  //
  final box = GetStorage();
  //
  Requete requete = Requete();
  //
  Future<void> connexion(String telephon, String motdepasse) async {
    //
    Response rep =
        await requete.getE("utilisateur/login/$telephon/$motdepasse");
    if (rep.isOk) {
      box.write("user", rep.body);
      Get.back();
      Get.snackbar(
        "Succès",
        "L'enregistrement à reussit",
        colorText: Colors.black,
        backgroundColor: Colors.white,
      );
      Get.off(Accueil());
    } else {
      Get.back();
      Get.snackbar("Erreur", "Un problème lors de la connexion");
    }
  }

  //
  Future<void> connexionEntreprise(String telephon, String motdepasse) async {
    //
    Response rep =
        await requete.getE("utilisateur/login/$telephon/$motdepasse");
    if (rep.isOk) {
      box.write("user", rep.body);
      Get.back();
      Get.snackbar("Succès", "L'enregistrement à reussit");
      Get.off(Accueil());
    } else {
      Get.back();
      Get.snackbar("Erreur", "Un problème lors de la connexion");
    }
  }

  //
  // Future<void> supprimer(String id) async {
  //   //
  //   Response rep = await requete.deleteE("utilisateur/$id");
  //   if (rep.isOk) {
  //     box.write("user", rep.body);
  //     Get.back();
  //     Get.snackbar("Succès", "L'enregistrement à reussit");
  //     Get.off(Connexion());
  //   } else {
  //     Get.back();
  //     Get.snackbar("Erreur", "Un problème lors de la suppression");
  //   }
  // }

  //
  Future<void> mettreajour(Map e) async {
    //
    Response rep = await requete.putE("utilisateur", e);
    if (rep.isOk) {
      box.write("user", rep.body);
      Get.back();
      Get.snackbar("Succès", "Mise à jour éffectué");
      Get.off(Accueil());
    } else {
      Get.back();
      Get.snackbar("Erreur", "Un problème lors de la mise à jour");
    }
  }

  //
  Future<void> inscription(Map e) async {
    //
    Response rep = await requete.postE("utilisateur", e);
    if (rep.isOk) {
      //
      box.write("user", rep.body);
      Get.back();
      Get.snackbar("Succès", "L'enregistrement à reussit");
      Get.off(Accueil());
    } else {
      //
      print(rep.body);
      Get.back();
      Get.snackbar("Erreur", "Un problème est survenu lors de l'inscription");
    }
  }
  //
}
