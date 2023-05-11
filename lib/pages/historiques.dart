import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_business/utils/commande_controller.dart';
import 'package:pay_business/utils/requete.dart';

class Historique extends StatelessWidget {
  RxString date = "".obs;
  //
  Requete requete = Requete();
  CommandeController commandeController = Get.find();
  //
  RxString service = "Restaurant".obs;
  //
  RxDouble total = RxDouble(0);
  //
  Rx<Widget> vue = Rx(Container());
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade900, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo.shade900,
            title: const Text("Historiques"),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          height: 45,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Obx(
                            () => Text(date.value),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 3,
                        child: ElevatedButton(
                          onPressed: () {
                            //
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2023),
                                    lastDate: DateTime(2030))
                                .then(
                              (d) {
                                //
                                total.value = 0;
                                //
                                final box = GetStorage();
                                //
                                Map boutique = box.read("boutique");
                                //
                                date.value = "${d!.day}-${d.month}-${d.year}";
                                //
                                //commandeController.commandes(
                                //  "${user['id']}", date.value);
                                vue.value = FutureBuilder(
                                  future: commandeController.commandes(
                                      "${boutique['id']}", date.value),
                                  builder: (c, t) {
                                    if (t.hasData) {
                                      List liste = t.data as List;
                                      return ListView(
                                        padding: const EdgeInsets.all(10),
                                        children: List.generate(
                                          liste.length,
                                          (index) {
                                            //
                                            Map e = liste[index];
                                            Timer(Duration(seconds: 1), () {
                                              total.value += e['prix'];
                                            });
                                            //
                                            if (e['type'] == 2) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Container(
                                                      height: 400,
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .indigo.shade900,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${Requete.urlSt}produit/photo.png?id=${e['idProduit']}"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 3,
                                                  ),
                                                  Expanded(
                                                    flex: 7,
                                                    child: ListTile(
                                                      title: Text(
                                                        "${e['date']}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 25),
                                                      ),
                                                      subtitle: Text(
                                                        "${e['prix']}, ${e['devise']}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 30),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              //
                                              return InkWell(
                                                onTap: () {
                                                  //
                                                  //Get.to(EvenementDetails(e));
                                                  //
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Icon(
                                                          Icons.table_bar),
                                                    ),
                                                    Expanded(
                                                      flex: 9,
                                                      child: ListTile(
                                                        title: Text(
                                                          "Table N° ${e['tables']}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 25),
                                                        ),
                                                        subtitle: Text(
                                                          "${e['prix']}, ${e['devise']}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 30),
                                                        ),
                                                        // trailing: Icon(
                                                        //   Icons.arrow_forward_ios,
                                                        // ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      );
                                    } else if (t.hasError) {
                                      return const Center(
                                        child: Icon(Icons.hourglass_empty),
                                      );
                                    }
                                    return const Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Text("Date"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Obx(() => vue.value),
                )
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 40,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text("$total "),
                ),
                const Text("CDF"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  Future<List> getCommandes(String date) async {
    //
    var box = GetStorage();
    //
    DateTime dateTime = DateTime.now();
    String d = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    print(d);
    //
    Map e = box.read("boutique") ?? {};
    //journalier
    Response rep = await requete.getE("commande/journalier/${e['id']}/$date");
    if (rep.isOk) {
      return rep.body;
    } else {
      return [];
    }
  }
}
