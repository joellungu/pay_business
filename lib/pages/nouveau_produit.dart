import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_business/utils/produit_controller.dart';

class NouveauProduit extends StatelessWidget {
  //
  RxList<bool> choix = [true, false, false].obs;
  //
  RxInt vue = 0.obs;
  //
  final box = GetStorage();
  //
  List unites = ["Gramme", "Kilogramme", "Millilittre", "Litre"];
  RxInt unite = 0.obs;
  //
  RxString photo = "".obs;
  //
  RxString debut = RxString("");
  RxString fin = RxString("");
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
  RxInt type = 0.obs;
  RxList<String> types = ["Produit"].obs;

  //
  List categories = [];
  //
  NouveauProduit() {
    //
    Map e = box.read("boutique") ?? {};
    print(e);
    if (e['typeEtablissement'] == "Restaurant" ||
        e['typeEtablissement'] == "Bar" ||
        e['typeEtablissement'] == "Pharmacie") {
      types.value = ["Produit"];
    } else {
      types.value = ["Evenement"];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produit & Service"),
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
                            () => DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                onChanged: (c) {
                                  //
                                  //types[type.value] = "";
                                },
                                focusColor: Colors.white,
                                isExpanded: true,
                                value: type.value,
                                items: List.generate(types.length, (index) {
                                  String e = types[index];
                                  return DropdownMenuItem(
                                    child: Text(e),
                                    value: index,
                                  );
                                }),
                              ),
                            ),
                          )
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
                      // ignore: unrelated_type_equality_checks
                      () => types[type.value] == "Produit"
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
                          : Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(debut.value),
                                          IconButton(
                                            onPressed: () {
                                              //
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2023),
                                                lastDate: DateTime(2030),
                                              ).then((d) {
                                                //
                                                debut.value =
                                                    "${d!.day}-${d.month}-${d.year}";
                                              });
                                            },
                                            icon: Icon(Icons.calendar_month),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(fin.value),
                                          IconButton(
                                            onPressed: () {
                                              //
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2023),
                                                lastDate: DateTime(2030),
                                              ).then((d) {
                                                //
                                                fin.value =
                                                    "${d!.day}-${d.month}-${d.year}";
                                              });
                                            },
                                            icon: Icon(Icons.calendar_month),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                          ? Image.file(File(photo.value))
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
                  //
                  Map boutique = box.read('boutique');
                  /**
                   */
                  Map e = {
                    "idBoutique": boutique['id'],
                    "type": types[type.value],
                    "nom": nom.text,
                    "prix": prix.text,
                    "devise": device.value,
                    "quantite": quantite.text,
                    "poids": poids.text,
                    "unite": unites[unite.value],
                    "details": details.text,
                    "date": "${debut.value} ${fin.value}",
                    "photo": photo.value.isEmpty
                        ? null
                        : File(photo.value).readAsBytesSync(),
                  };
                  //
                  produitController.enregistrer(e);
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
