import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_business/utils/requete.dart';

import 'details_reservation.dart';

class Commandes extends StatelessWidget {
  //
  Requete requete = Requete();
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
          body: FutureBuilder(
            future: getCommandes(),
            builder: (c, t) {
              if (t.hasData) {
                List ll = t.data as List;
                //
                List l = ll.reversed.toList();
                //
                return Column(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(""), //${l.length} au total
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView(
                        children: List.generate(l.length, (index) {
                          Map e = l[index];
                          return ListTile(
                            onTap: () {
                              //
                              Get.to(DetailsReservation("${e['id']}"));
                            },
                            leading: const Icon(Icons.table_bar),
                            title: Text(
                              "Table N° ${e['tables'] ?? ''}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 25),
                            ),
                            subtitle: Text(
                              "${e['prix']} ${e['devise']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 25),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Icon(
                              Icons.check_circle,
                              color: e['deja']
                                  ? Colors.green
                                  : Colors.red.shade900,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              } else if (t.hasError) {
                return Container();
              }
              return const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  //
  Future<List> getCommandes() async {
    //
    var box = GetStorage();
    //
    DateTime dateTime = DateTime.now();
    String d = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    //
    Map e = box.read("boutique") ?? {};
    //journalier
    Response rep = await requete.getE("commande/entreprise/${e['id']}/$d");
    if (rep.isOk) {
      return rep.body;
    } else {
      return [];
    }
  }
}
