import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pay_business/utils/login_controller.dart';
import 'package:uuid/uuid.dart';

class Inscription extends StatefulWidget {
  //
  @override
  State<StatefulWidget> createState() {
    return _Inscription();
  }
}

class _Inscription extends State<Inscription> {
  TextEditingController nom = TextEditingController();
  TextEditingController postnom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController adresse = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController lieu_de_naissance = TextEditingController();
  //certificat
  TextEditingController certificatAgre = TextEditingController();
  TextEditingController certificatOmo = TextEditingController();
  TextEditingController licence = TextEditingController();
  TextEditingController cellule = TextEditingController();
  TextEditingController etablissement = TextEditingController();
  TextEditingController lieu = TextEditingController();
  TextEditingController rccm = TextEditingController();
  TextEditingController nombreEtablissement = TextEditingController();
  TextEditingController annee = TextEditingController();
  TextEditingController titre = TextEditingController();
  TextEditingController codepromo = TextEditingController();
  TextEditingController idnat = TextEditingController();
  TextEditingController numeroImpot = TextEditingController();
  //
  LoginController loginController = Get.find();
  //

  List genres = ["Homme", "Femme"];
  List etatCivils = ["Célibataire", "Marié", "Divorcé"];
  int etatCivil = 0;
  int genre = 0;
  List types = [
    "Diplôme d'etat",
    "Diplôme d'aptitude profesionnel",
    "Brevet professionnel",
    "Certificat d'étude primaire",
    "Note d'acquis de droit",
    "Attestation reussite (EXETAT)",
    "Attestation de N.D.D",
    "Releve de côtes"
  ];
  //
  List listeOptions = [
    "LATIN-PHILOSOPHIE,101",
    "MATHEMATIQUE-PHYSIQUE,102",
    "CHIMIE-BIOLOGIE,103",
    "LATIN-GREC,104",
    "LATIN-MATHEMATIQUE,105",
    "SCIENCES,106",
    "PEDAGOGIE GENERALE,201",
    "EDUCATION PHYSIQUE,202",
    "NORMALE,203",
    "PEDAGOGIE MATERNELLE,204",
    "COMMERCIALE ET GESTION,301",
    "SECRETARIAT-ADMINISTRATION,302",
    "SOCIALE,401",
    "ARTS PLASTIQUES,501",
    "ARTS DRAMATIQUES,502",
    "MUSIQUE,503",
    "ESTHETIQUE & COIFFURE,504",
    "COIFFURE,505",
    "COUPE-COUTURE,601",
    "HOTESSE D'ACCUEIL,701",
    "HOTELLERIE & RESTAURATION,702",
    "TOURISME,704",
    "AGRICULTURE GENERALE,801",
    "PECHE ET NAVIGATION,802",
    "VETERINAIRE,803",
    "INDUSTRIES AGRICOLES,804",
    "NUTRITION,805",
    "FORESTERIE,806",
    "MECANIQUE GENERALE,901",
    "MECANIQUE MACHINES-OUTILS,902",
    "ELECTRICITE,903",
    "CONSTRUCTION,904",
    "CHIMIE INDUSTRIELLE,905",
    "ELECTRONIQUE,906",
    "IMPRIMERIE,907",
    "COMMUTATION,908",
    "RADIO-TRANSMISSION,909",
    "METEOROLOGIE,910",
    "AVIATION CIVILE,911",
    "PETRO-CHIMIE,914",
    "MECANIQUE AUTOMOBILE,915",
    "CONSTRUCTION METALLIQUE,916",
    "MENUISERIE EBENISTERIE,917",
    "MINE ET GEOLOGIE,918",
    "METALLURGIE,919",
    "DESSIN DE BATIMENT,920",
    "INSTALLATION SANITAIRE,921",
    "TOLERIE,922",
    "AJUSTAGE ET SOUDURE,923",
  ];
  //
  RxList categorie = [""].obs;
  List hotel = [
    "Groupe 1",
    "Groupe 2",
  ].obs;
  List restaurant = [
    "1 Fourchette",
    "2 Fourchette",
    "3 Fourchette",
    "4 Fourchette",
  ].obs;
  RxList autre = ["Catégorie A", "Catégorie B"].obs;

  //
  int a = 0;
  int s = 0;
  int b = 0;
  int p = 0;
  int dd = 0;
  //
  int option = 0;
  int p_e = 0;
  int n_e = 1;
  int cat = 0;
  //
  XFile? photo;
  //
  List<Map<String, dynamic>> listeDistrict2 = [
    {"p": "BAS-UELE", "d": "BAS-UELE"},
    {"p": "EQUATEUR", "d": "EQUATEUR 1"},
    {"p": "EQUATEUR", "d": "EQUATEUR 2"},
    {"p": "HAUT-KATANGA", "d": "HAUT-KATANGA 1"},
    {"p": "HAUT-KATANGA", "d": "HAUT-KATANGA 2"},
    {"p": "HAUT-LOMAMI", "d": "HAUT-LOMAMI 1"},
    {"p": "HAUT-LOMAMI", "d": "HAUT-LOMAMI 2"},
    {"p": "HAUT-UELE", "d": "HAUT-UELE 1"},
    {"p": "HAUT-UELE", "d": "HAUT-UELE 2"},
    {"p": "ITURI", "d": "ITURI 1"},
    {"p": "ITURI", "d": "ITURI 2"},
    {"p": "ITURI", "d": "ITURI 3"},
    {"p": "KASAI", "d": "KASAI 1"},
    {"p": "KASAI", "d": "KASAI 2"},
    {"p": "KASAI CENTRAL", "d": "KASAI CENTRAL 1"},
    {"p": "KASAI CENTRAL", "d": "KASAI CENTRAL 2"},
    {"p": "KASAI ORIENTAL", "d": "KASAI ORIENTAL 1"},
    {"p": "KASAI ORIENTAL", "d": "KASAI ORIENTAL 2"},
    {"p": "KINSHASA", "d": "KINSHASA-FUNA"},
    {"p": "KINSHASA", "d": "KINSHASA-LUKUNGA"},
    {"p": "KINSHASA", "d": "KINSHASA-MONT AMBA"},
    {"p": "KINSHASA", "d": "KINSHASA-PLATEAU"},
    {"p": "KINSHASA", "d": "KINSHASA-TSHANGU"},
    {"p": "KONGO CENTRAL", "d": "KONGO CENTRAL 1"},
    {"p": "KONGO CENTRAL", "d": "KONGO CENTRAL 2"},
    {"p": "KONGO CENTRAL", "d": "KONGO CENTRAL 3"},
    {"p": "KWANGO", "d": "KWANGO 1"},
    {"p": "KWANGO", "d": "KWANGO 2"},
    {"p": "KWILU", "d": "KWILU 1"},
    {"p": "KWILU", "d": "KWILU 2"},
    {"p": "KWILU", "d": "KWILU 3"},
    {"p": "LOMAMI", "d": "LOMAMI"},
    {"p": "LOMAMI", "d": "LOMAMI 2"},
    {"p": "LUALABA", "d": "LUALABA 1"},
    {"p": "LUALABA", "d": "LUALABA 2"},
    {"p": "MAI-NDOMBE", "d": "MAI-NDOMBE 1"},
    {"p": "MAI-NDOMBE", "d": "MAI-NDOMBE 2"},
    {"p": "MAI-NDOMBE", "d": "MAI-NDOMBE 3"},
    {"p": "MANIEMA", "d": "MANIEMA 1"},
    {"p": "MANIEMA", "d": "MANIEMA 2"},
    {"p": "MONGALA", "d": "MONGALA 1"},
    {"p": "MONGALA", "d": "MONGALA 2"},
    {"p": "NORD-KIVU", "d": "NORD-KIVU 1"},
    {"p": "NORD-KIVU", "d": "NORD-KIVU 2"},
    {"p": "NORD-KIVU", "d": "NORD-KIVU 3"},
    {"p": "NORD-UBANGI", "d": "NORD-UBANGI 1"},
    {"p": "NORD-UBANGI", "d": "NORD-UBANGI 2"},
    {"p": "SANKURU", "d": "SANKURU 1"},
    {"p": "SANKURU", "d": "SANKURU 2"},
    {"p": "SUD KIVU", "d": "SUD KIVU 2"},
    {"p": "SUD KIVU", "d": "SUD-KIVU 1"},
    {"p": "SUD KIVU", "d": "SUD-KIVU 3"},
    {"p": "SUD-UBANGI", "d": "SUD-UBANGI 1"},
    {"p": "SUD-UBANGI", "d": "SUD-UBANGI 2"},
    {"p": "TANGANYIKA", "d": "TANGANYIKA 1"},
    {"p": "TANGANYIKA", "d": "TANGANYIKA 2"},
    {"p": "TSHOPO", "d": "TSHOPO 1"},
    {"p": "TSHOPO", "d": "TSHOPO 2"},
    {"p": "TSHUAPA", "d": "TSHUAPA 1"},
    {"p": "TSHUAPA", "d": "TSHUAPA 2"}
  ];
  //
  List<String> listeDistrict = [];
  //
  RxInt type = 0.obs;
  List listeProvince = [
    "Bas-Uele",
    "Équateur",
    "Haut-Katanga",
    "Haut-Lomami",
    "Haut-Uele",
    "Ituri",
    "Kasai",
    "Kasai central",
    "Kasai oriental",
    "Kinshasa",
    "Kongo Central",
    "Kwango",
    "Kwilu",
    "Lomami",
    "Lualaba",
    "Mai-Ndombe",
    "Maniema",
    "Mongala",
    "Nord-Kivu",
    "Nord-Ubangi",
    "Sankuru",
    "Sud-Kivu",
    "Sud-Ubangi",
    "Tanganyika",
    "Tshopo",
    "Tshuapa",
  ];
  int pp = 9;
  //
  String ext1 = "png";
  RxInt i = 0.obs;
  //XFile? img1;
  //
  DateTime? d;

  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    categorie.value = hotel;

    listeDistrict.clear();
    //
    listeDistrict2.forEach((element) {
      if ("${element['p']}".toLowerCase() ==
          ("${listeProvince[0]}".toLowerCase())) {
        listeDistrict.add("${element['d']}");
      }
    });
    //
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo.shade900,
        title: const Text(
          "Enregistrement du business",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Information personnel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: nom,
            decoration: InputDecoration(
              //prefixIcon: Text("De:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: const Text("Nom du DG ou Propriètaire"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: postnom,
            decoration: InputDecoration(
                //prefixIcon: Text("Téléphone:"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                label: Text("Postnom")
                //prefixText: "De: "
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: prenom,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: Text("Prenom"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
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
                  Text(
                    "  Genre:",
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: genre,
                        /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                        isExpanded: true,
                        onChanged: (value) {
                          genre = value as int;
                          print("le id: $genre");
                        },
                        items: List.generate(
                          genres.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(genres[index]),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
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
                  Text(
                    "  Etat Civil:",
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<int>(
                        value: etatCivil,
                        /*
                            style: TextStyle(
                                //fontSize: 12,
                                color: Colors.black
                            ),
                            */
                        isExpanded: true,
                        onChanged: (value) {
                          etatCivil = value as int;
                          print("le id: $genre");
                        },
                        items: List.generate(
                          etatCivils.length,
                          (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(etatCivils[index]),
                            );
                          },
                        ),
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
            controller: email,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: Text("Email"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: telephone,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              prefixText: "+243",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: Text("Numéro de téléphone"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: adresse,
            decoration: InputDecoration(
              //prefixIcon: Text("Email:"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              label: Text("Adresse"),
              //prefixText: "De: "
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Information sur l'établissement",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ///////////
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Nom établissement: ",
                    style: TextStyle(fontSize: 12),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      //width: Get.size.width,
                      child: TextField(
                        controller: etablissement,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
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
          Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Adresse établissement: ",
                    style: TextStyle(fontSize: 12),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      //width: Get.size.width,
                      child: TextField(
                        controller: lieu,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.all(0)),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
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
          Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "  RCCM: ",
                    style: TextStyle(fontSize: 12),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      //width: Get.size.width,
                      child: TextField(
                        controller: rccm,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
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
          Card(
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
                  const Text("  Province siège social:"),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: p_e,
                        onChanged: (value) {
                          p_e = value as int;
                          //value = s;
                        },
                        items: List.generate(listeProvince.length, (index) {
                          return DropdownMenuItem(
                            value: index,
                            child: Text(listeProvince[index]),
                          );
                        }),
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
          Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(" Type établissement:"),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: n_e,
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            n_e = value as int;
                            cat = 0;
                          });
                          // if (n_e == 0) {
                          //   categorie.value = hotel;
                          // } else if (n_e == 1) {
                          //   categorie.value = restaurant;
                          // } else {
                          //   categorie.value = autre;
                          // }
                        },
                        /* //
                        */
                        items: const [
                          DropdownMenuItem(
                            value: 0,
                            child: Text("Bar"),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text("Evenementiel"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("Restaurant"),
                          ),
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
          Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
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
                  const Text("  Catégorie:"),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: n_e == 1
                        ? DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: cat,
                              onChanged: (value) {
                                setState(() {
                                  cat = value as int;
                                });
                              },
                              /*
                        */
                              items: List.generate(
                                hotel.length,
                                (index) {
                                  return DropdownMenuItem(
                                    value: index,
                                    child: Text("${hotel[index]}"),
                                  );
                                },
                              ),
                            ),
                          )
                        : n_e == 2
                            ? DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  value: cat,
                                  onChanged: (value) {
                                    setState(() {
                                      cat = value as int;
                                    });
                                  },
                                  /*
                        */
                                  items: List.generate(
                                    restaurant.length,
                                    (index) {
                                      return DropdownMenuItem(
                                        value: index,
                                        child: Text("${restaurant[index]}"),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  value: cat,
                                  onChanged: (value) {
                                    setState(() {
                                      cat = value as int;
                                    });
                                  },
                                  /*
                        */
                                  items: List.generate(
                                    autre.length,
                                    (index) {
                                      return DropdownMenuItem(
                                        value: index,
                                        child: Text("${autre[index]}"),
                                      );
                                    },
                                  ),
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 0,
            margin: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  Nombre de succursale end RDC: ",
                    style: TextStyle(fontSize: 12),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      //width: Get.size.width,
                      child: TextField(
                        controller: nombreEtablissement,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          /////////////////////////////////

          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            onPressed: () async {
              //showDialog(context: context, builder: builder);
              final ImagePicker _picker = ImagePicker();
              // Pick an image
              photo = await _picker.pickImage(
                source: ImageSource.gallery,
                maxHeight: 800,
                maxWidth: 800,
                imageQuality: 75,
              );
              ext1 = "${photo!.name}".split(".").last;
              i = 1.obs;
              print("ext ${photo!.name}".split(".").last);
              // Capture a photo
              Timer(Duration(seconds: 1), () {
                setState(() {
                  //
                });
              });
            },
            icon: const Icon(Icons.file_present),
            label: const Text("Joindre la photo du Propriètaire"),
          ),
          ///////////
          Obx(() => i.value != 0
              ? Container(
                  height: Get.size.height / 4,
                  width: Get.size.width / 1.1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        File(photo!.path),
                      ),
                    ),
                  ),
                )
              : Container()),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: codepromo,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.join_full),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Champ non obligatoire'.tr,
              labelText: 'Code promo'.tr,
            ),
            onChanged: (value) {
              //print("Password value $value");
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: idnat,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.join_full),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'ID NAT'.tr,
              labelText: 'ID NAT'.tr,
            ),
            onChanged: (value) {
              //print("Password value $value");
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: numeroImpot,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.join_full),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "Numero d'impot".tr,
              labelText: "Numero d'impot".tr,
            ),
            onChanged: (value) {
              //print("Password value $value");
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (nom.text.isEmpty) {
                messageErreur("Erreur", "Veuillez remplire le champ nom");
              } else if (postnom.text.isEmpty) {
                messageErreur("Erreur", "Veuillez remplire le champ postnom");
              } else if (prenom.text.isEmpty) {
                messageErreur("Erreur", "Veuillez remplire le champ prenom");
              } else {
                var connectivityResult =
                    await (Connectivity().checkConnectivity());
                //
                if (connectivityResult == ConnectivityResult.mobile ||
                    connectivityResult == ConnectivityResult.wifi) {
                  //
                  Get.dialog(Center(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: 7,
                      ),
                    ),
                  ));
                  //
                  DateTime d2 = DateTime.now();
                  //
                  //ControllerApp controllerApp = Get.find();
                  //
                  //String vd = d!.day < 9 ? "0${d!.day}" : "${d!.day}";
                  String categorie = n_e == 1
                      ? hotel[cat]
                      : n_e == 2
                          ? restaurant[cat]
                          : autre[cat];
                  //String ddd = "${d!.year}-${d!.month}-$vd";
                  Map<String, dynamic> e = {
                    //"id": getCode(),
                    "nom": nom.text,
                    "postnom": postnom.text,
                    "prenom": prenom.text,
                    "sexe": genres[genre],
                    "etatCivil": etatCivils[etatCivil],
                    "email": email.text,
                    "telephone": "+243${telephone.text}",
                    "adresse": adresse.text,
                    "denomination": etablissement.text,
                    "adresseEtablissement": lieu.text,
                    "rccm": rccm.text,
                    "idnat": idnat.text,
                    "numeroImpot": numeroImpot.text,
                    "provinceSiege": listeProvince[p_e],
                    "typeEtablissement": [
                      "Bar",
                      "Evenementiel",
                      "Restaurant"
                    ][n_e],
                    "categorie": categorie,
                    "nombreEtablissement": nombreEtablissement.text,
                    "photo": photo != null
                        ? File(photo!.path).readAsBytesSync()
                        : null,
                    "codePromo": codepromo.text,
                    "motDePasse": "pay0000",
                    "status": 0,
                  };
                  //
                  loginController.inscription(e);
                  //
                  //
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

                  // Map v = {"v": false}; //await controllerApp.creerCompte(e);
                  // //
                  // if (v['v']) {
                  //   //
                  //   nom = TextEditingController();
                  //   postnom = TextEditingController();
                  //   prenom = TextEditingController();
                  //   nom_pere = TextEditingController();
                  //   nom_mere = TextEditingController();
                  //   telephone = TextEditingController();
                  //   adresse = TextEditingController();
                  //   lieu_de_naissance = TextEditingController();
                  //   email = TextEditingController();
                  //   //
                  //   cellule = TextEditingController();
                  //   etablissement = TextEditingController();
                  //   lieu = TextEditingController();
                  //   annee = TextEditingController();
                  //   titre = TextEditingController();
                  //   //
                  //   Get.back();
                  //   Get.snackbar("Succès", "${v['message']}");
                  // } else {
                  //   Get.back();
                  //   Get.snackbar("Erreur", "code: ${v['code']}.");
                  // }
                  //____________________________________________________________
                } else {
                  Get.snackbar("Connexion", "Vous n'etes pas connecté");
                }
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: 40,
              child: const Text("Enregistrer"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  send(Map formulaireD) async {
    Get.back();
    // DemandeIdentificationController demandeIdentificationController =
    //     Get.find();
    // //ByteArrayInputStream//formulaireD
    // //
    // Timer(const Duration(seconds: 1), () {
    //   demandeIdentificationController.faireUneInscription(formulaireD);
    // });
  }

  String getCode() {
    String n = "";
    var rng = Random();
    for (var i = 0; i < 17; i++) {
      n = "$n${rng.nextInt(9)}";
    }
    return n;
  }

  messageErreur(String titre, String message) {
    //GetSnackBar(title: titre, message: message);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titre),
          content: Text(message),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
              ),
            )
          ],
        );
      },
    );
  }

  String getReference() {
    var uuid = Uuid();
    return "${uuid.v4()}";
  }

  Future<void> _createFolderAndSave(
      String folderName, List<Map<String, dynamic>> liste) async {
    try {
      //
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      //final folderName = "some_name";
      final path = Directory("$appDocPath/$folderName");
      if ((await path.exists())) {
        // TODO:
        print("exist");
      } else {
        path.create();
        for (int t = 0; t < liste.length; t++) {
          //
          File("${path.create()}/t.${liste[t]['type']}")
              .create(recursive: true)
              .then((File file) {
            //
            file.writeAsBytes(liste[t]["data"]); //
          });
        }
        //print("not exist");
      }
    } catch (e) {
      print("_______________: $e");
    }
  }
}
