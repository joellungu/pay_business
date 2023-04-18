import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_business/utils/produit_controller.dart';
import 'package:pay_business/utils/requete.dart';

class DetailsPRoduit extends StatelessWidget {
  Map e = {};
  File f = File("photo");
  DetailsPRoduit(this.e) {
    nom.text = e['nom'];
    prix.text = "${e['prix']}";
    quantite.text = "${e['quantite']}";
    poids.text = "${e['poids']}";
    details.text = e['details'];
    //
    v.value = e['type'];
    //
    photo.value = "photo";
    //
    //print(e['photo']);
    //f.writeAsBytesSync(e['photo'].codeUnits);
    //print(f.existsSync());
  }
  //
  RxList<bool> choix = [true, false, false].obs;
  //
  RxInt vue = 0.obs;
  //
  List unites = ["Gramme", "Kilogramme", "Millilittre", "Litre"];
  RxInt unite = 0.obs;
  //
  RxString photo = "".obs;
  //
  ProduitController produitController = Get.find();
  //
  TextEditingController nom = TextEditingController(); //
  TextEditingController prix = TextEditingController();
  TextEditingController details = TextEditingController();
  RxString device = "CDF".obs;
  TextEditingController quantite = TextEditingController();
  TextEditingController poids = TextEditingController();
  //
  RxString path = "".obs;
  //
  RxString v = "Produit".obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: const Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                width: 500,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Categorie",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                      value: "Produit",
                                      groupValue: v.value,
                                      onChanged: (e) {
                                        v.value = e as String;
                                      },
                                    ),
                                    Text("Produit")
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Radio(
                                      value: "Service",
                                      groupValue: v.value,
                                      onChanged: (e) {
                                        v.value = e as String;
                                        path.value = "";
                                      },
                                    ),
                                    Text("Autres")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: nom,
                      decoration: InputDecoration(
                        hintText: "Name",
                        suffixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ), //device
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 5,
                          child: TextField(
                            controller: prix,
                            decoration: InputDecoration(
                              hintText: "Prix",
                              suffixIcon: Icon(Icons.price_check),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Obx(
                              () => DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  onChanged: (tt) {
                                    //
                                    device.value = tt as String;
                                  },
                                  value: device.value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("CDF"),
                                      value: "CDF",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("USD"),
                                      value: "USD",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: quantite,
                      decoration: InputDecoration(
                        hintText: "Quantité",
                        suffixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => v.value == "Produit"
                          ? Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: TextField(
                                          controller: poids,
                                          decoration: InputDecoration(
                                            hintText: "Poids ou litrage",
                                            suffixIcon: Icon(Icons.scale),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "   Unit ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: 50,
                                                width: 200,
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                child: Obx(
                                                  () =>
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton<int>(
                                                      onChanged: (c) {
                                                        //
                                                        unite.value = c as int;
                                                      },
                                                      focusColor: Colors.white,
                                                      value: unite.value,
                                                      items: List.generate(
                                                          unites.length,
                                                          (index) {
                                                        String e =
                                                            unites[index];
                                                        return DropdownMenuItem(
                                                          child: Text(e),
                                                          value: index,
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: details,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Détails",
                        suffixIcon: Icon(Icons.price_check),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        //
                        //
                        final ImagePicker img = ImagePicker();
                        XFile? file = await img.pickImage(
                          source: ImageSource.gallery,
                          maxHeight: 800,
                          maxWidth: 800,
                          imageQuality: 75,
                        );
                        //
                        photo.value = file!.path;
                        //
                      },
                      icon: const Icon(Icons.photo),
                      label: const Text("Ajouter une photo"),
                    ),
                    Obx(
                      () => photo.value.isNotEmpty
                          ? Image.network(
                              "${Requete.urlSt}produit/photo.png?id=${e['id']}")
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  /**
                 * 
                 */
                  //
                  Get.dialog(
                    const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                  /**
                   */
                  Map x = {
                    "id": e['id'],
                    "type": v.value,
                    "nom": nom.text,
                    "prix": prix.text,
                    "devise": device.value,
                    "quantite": quantite.text,
                    "poids": poids.text,
                    "unite": unites[unite.value],
                    "details": details.text,
                    "photo": photo.value == "photo"
                        ? e['photo']
                        : File(photo.value).readAsBytesSync(),
                  };
                  //
                  produitController.mettreajour(x);
                },
                child: Container(
                  width: 200,
                  alignment: Alignment.center,
                  height: 45,
                  child: const Text("Save"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
