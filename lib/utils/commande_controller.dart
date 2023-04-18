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
    Map user = box.read("user");
    print(user);
    String idProprio = "${user['id']}";
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
  Future<void> mettreajour(Map e) async {
    //
    Response rep = await requete.putE("compte", e);
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
}
