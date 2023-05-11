import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_business/pages/accueil.dart';
import 'package:pay_business/utils/requete.dart';

class CommandeController extends GetxController with StateMixin<List> {
  //
  final box = GetStorage();
  //
  Requete requete = Requete();
  //
  tousCompte() async {
    //
    Map boutique = box.read("boutique");
    print(boutique);
    String idProprio = "${boutique['id']}";
    //
    change([], status: RxStatus.loading());
    //
    Response rep = await requete.getE("compte/all/$idProprio");
    if (rep.isOk) {
      change(rep.body, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }

  //
  Future<void> supprimer(String id) async {
    //
    Response rep = await requete.deleteE("compte/$id");
    if (rep.isOk) {
      Get.back();
      tousCompte();
    } else {
      Get.back();
      tousCompte();
    }
  }

  //
  Future<void> mettreajourCommande(Map e) async {
    //
    Response rep = await requete.putE("commande", e);
    if (rep.isOk) {
      Get.back();
      Get.snackbar("Succès", "Mise à jour éffectué");
      //Get.off(Accueil());
    } else {
      Get.back();
      Get.snackbar("Erreur", "Un problème lors de la mise à jour");
    }
  }

  //
  Future<void> mettreajour(Map e) async {
    //
    Response rep = await requete.putE("compte", e);
    if (rep.isOk) {
      box.write("user", rep.body);
      Get.back();
      Get.snackbar("Succès", "Mise à jour éffectué");
      //Get.off(Accueil());
    } else {
      Get.back();
      Get.snackbar("Erreur", "Un problème lors de la mise à jour");
    }
  }

  //
  Future<List> commandes(String idEntreprise, String date) async {
    //
    Response rep =
        await requete.getE("commande/entreprise/$idEntreprise/$date");
    if (rep.isOk) {
      print(rep.body);
      print(rep.statusCode);
      //
      //change(rep.body, status: RxStatus.success());
      return rep.body;
      //
    } else {
      //
      print(rep.body);
      print(rep.statusCode);
      //change([], status: RxStatus.empty());
      return [];
      //
    }
  }

  //
  Future<void> enregistrer(Map e) async {
    //
    Response rep = await requete.postE("compte", e);
    if (rep.isOk) {
      //
      Get.back();
      //
      Get.back();
      //
      tousCompte();
      //
      Get.snackbar("Succès", "L'enregistrement à reussit");
    } else {
      //
      print(rep.body);
      Get.back();
      Get.snackbar("Erreur", "Un problème est survenu lors de l'inscription");
    }
  }

  //
  Future<Map> getCommande(String id) async {
    //
    Response rep = await requete.getE("commande/$id");
    if (rep.isOk) {
      //
      return rep.body;
    } else {
      //
      return {};
    }
  }
  //
}
