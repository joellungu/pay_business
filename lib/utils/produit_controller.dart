import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_business/pages/accueil.dart';
import 'package:pay_business/utils/requete.dart';

class ProduitController extends GetxController with StateMixin<List> {
  //
  final box = GetStorage();
  //
  Requete requete = Requete();
  //
  RxList achats = [].obs;
  //
  tousProduits() async {
    String idbusiness = "1";
    change([], status: RxStatus.loading());
    Response rep = await requete.getE("produit/all/$idbusiness");
    if (rep.isOk) {
      change(rep.body, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
      //return [];
    }
  }

  tousProduitsEntreprise(String id) async {
    String idbusiness = "1";
    change([], status: RxStatus.loading());
    Response rep = await requete.getE("produit/all/$idbusiness");
    if (rep.isOk) {
      change(rep.body, status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
      //return [];
    }
  }

  //
  // Future<void> supprimer(String id) async {
  //   //
  //   Response rep = await requete.deleteE("produit/$id");
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
    Response rep = await requete.putE("produit", e);
    if (rep.isOk) {
      //box.write("user", rep.body);
      Get.back();
      Get.snackbar("Succès", "Mise à jour éffectué");
      Get.off(Accueil());
    } else {
      Get.back();
      Get.snackbar("Erreur", "Un problème lors de la mise à jour");
    }
  }

  //
  Future<void> enregistrer(Map e) async {
    //
    Response rep = await requete.postE("produit", e);
    if (rep.isOk) {
      //
      List l = box.read("produits") ?? [];
      l.add(rep.body);
      box.write("produits", l);
      //box.write("user", rep.body);
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
