import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_business/utils/commande_controller.dart';
import 'package:pay_business/utils/requete.dart';

class DetailsReservation extends StatelessWidget {
  //
  CommandeController commandeController = Get.find();
  //
  String id;
  DetailsReservation(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: commandeController.getCommande(id),
        builder: (c, t) {
          if (t.hasData) {
            Map c = t.data as Map;
            if (c['type'] == 2) {
              /**
               * public long idBoutique;
    public long idUtilisateur;
    public String date;
    public int type;//1 pour commande normal et 2 pour evenement
    public long idProduit;
    @ElementCollection
    public List<HashMap> produits;
    public double prix;
    public String devise;
    public String reference;
    public boolean deja
               */
              return Column(
                children: [
                  Container(
                    height: 400,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade900,
                      image: DecorationImage(
                        image: NetworkImage(
                            "${Requete.urlSt}produit/photo.png?id=${c['idProduit']}"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(
                        0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      "${c['date']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                    ),
                    subtitle: Text(
                      "${c['prix']}, ${c['devise']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 30),
                    ),
                  ),
                  !c['deja']
                      ? ElevatedButton(
                          onPressed: () {
                            //
                            Get.dialog(
                              const Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            );
                            //
                            c['deja'] = true;
                            commandeController.mettreajourCommande(c);
                          },
                          child: const Text(
                            "Valider",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: Text(
                            "Enregistré",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        )
                ],
              );
            } else {
              return ListView(
                children: [
                  ListTile(
                    title: Text(
                      "Date: ${c['date']}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                    ),
                    subtitle: Text(
                      "Total: ${c['prix']}, ${c['devise']}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 30),
                    ),
                  ),
                  Column(
                    children: List.generate(c['produits'].length, (index) {
                      Map x = c['produits'][index];
                      print(x);
                      return ListTile(
                        title: Text(
                          "${x['nom']} x ${x['quantite']}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 25),
                        ),
                        subtitle: Text(
                          "${x['prix']}, ${x['devise']}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 30),
                        ),
                      );
                    }),
                  )
                ],
              );
            }
          } else if (t.hasError) {
            return const Center(
              child: Text("Cette reservation n'existe pas."),
            );
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
    );
  }

  //
  Widget infos(String c, String v) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$c "),
        Text(v),
      ],
    );
  }
}
