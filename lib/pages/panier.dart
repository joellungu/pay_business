import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_business/utils/panier_controller.dart';
import 'package:pay_business/utils/requete.dart';
import 'package:pay_business/widgets/paiement.dart';
import 'package:uuid/uuid.dart';

class Panier extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Panier();
  }
}

class _Panier extends State<Panier> {
  double total = 0;
  List tables = [];
  List tablesPay = [].obs;
  PanierController controller = Get.find();

  int tab = 1;
  _Panier() {
    //
    tab = 1;
    //
    for (int t = 1; t <= 100; t++) {
      tables.add("$t");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
        backgroundColor: Colors.indigo.shade900,
        //actions: [],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey),
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("  Table "),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: tab,
                          onChanged: (value) {
                            //total = RxDouble(0);

                            total = 0;
                            tab = value as int;
                            tablesPay.clear();
                            setState(() {});

                            //
                            print(tab);
                            //value = s;
                          },
                          items: List.generate(tables.length, (index) {
                            return DropdownMenuItem(
                              value: index + 1,
                              child: Text(tables[index]),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                //
                //padding: EdgeInsets.symmetric(horizontal: 10),
                children:
                    List.generate(controller.listProduits.length, (index) {
                  Map e = controller.listProduits[index];

                  //tablesPay.clear();

                  if (e['table'] == "$tab") {
                    tablesPay.add(e);
                    total = total + calcule(e);
                    print("total: ${total}");
                    //
                    // setState(() {
                    //   total = total + calcule(e);
                    //   print("total: ${total}");
                    // });
                    //calcule();
                    return ListTile(
                      // onTap: () {
                      //   //
                      //   //Get.to(DetailsPRoduit(e));
                      // },
                      leading: Container(
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade900,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "${Requete.urlSt}produit/photo.png?id=${e['id']}"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                        ),
                      ),
                      title: Text(
                        "${e['nom']} | ${e['prix']} ${e['devise']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "Q: ${e['quantite']} || tab: ${e['table']}",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          //
                          setState(() {
                            controller.listProduits.removeAt(index);
                            tablesPay.removeAt(index);
                          });
                          //
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            //"table":controller.listProduits[0]['table'],
            final box = GetStorage();
            //
            Map boutique = box.read("boutique");
            //
            var ref = getReference();
            //
            DateTime dateTime = DateTime.now();
            String d = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
            Map e = {
              "idBoutique": boutique['id'],
              //"idUtilisateur": user['id'],
              "date": d,
              "type": 1,
              "idProduit": null,
              "produits": controller.listProduits.value,
              "prix": total,
              "devise": "CDF",
              "tables": controller.listProduits[0]['table'],
              "reference": ref,
            };
            showDialog(
              context: context,
              builder: (c) {
                return Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 300,
                      width: 270,
                      child: PayementMethode(
                        e,
                        7,
                        send,
                        "pay",
                        "pay",
                      ),
                    ),
                  ),
                );
              },
            );

            //
          },
          child: Text("Payer $total"),
        ),
      ),
    );
  }

  send(Map e) async {
    //
    Get.back();
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
    controller.commander(e);
  }

  //
  String getReference() {
    var uuid = Uuid();
    return "${uuid.v4()}";
  }

  double calcule(Map element) {
    double to = 0;
    //tablesPay.forEach((element) {
    print(
        "element: ${element['nom']} prix: ${element['prix']} quantite: ${element['quantite']}");
    print("------------------------------");
    to = double.parse(element["prix"]) * int.parse(element["quantite"]);
    print("to: $to");
    print("------------------------------ ${tablesPay.length}");
    //});
    return to;
  }
}

// showDialog(
//   context: context,
//   builder: (c) {
//     return Material(
//       color: Colors.transparent,
//       child: Center(
//         child: Container(
//           padding: const EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           height: 300,
//           width: 270,
//           child: PayementMethode(
//             e,
//             7,
//             send,
//             "palmares",
//             "palmares",
//           ),
//         ),
//       ),
//     );
//   },
// );
