import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_business/utils/login_controller.dart';
import 'inscription.dart';

class Connexion extends StatelessWidget {
  //

  final formKey = GlobalKey<FormState>();
  final telephone = TextEditingController();
  final mdp = TextEditingController();
  //
  LoginController loginController = Get.find();
  String groupe = "Utilisateur";
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
            title: const Text("Connexion"),
            centerTitle: true,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Text("""Votre argent partout avec vous"""),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        controller: telephone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline_outlined),
                          prefixText: "+243  ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'telephone'.tr,
                          labelText: 'telephone'.tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Téléphone'.tr;
                          } else if (!value.isPhoneNumber) {
                            return "Téléphone";
                          }

                          return null;
                        },
                        onChanged: (value) {
                          //print("Password value $value");
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: mdp,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Mot de passe'.tr,
                          labelText: 'Mot de passe'.tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mot de passe'.tr;
                          }

                          return null;
                        },
                        onChanged: (value) {
                          //print("Password value $value");
                        },
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 20,
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       Expanded(
                      //         flex: 5,
                      //         child: RadioListTile(
                      //           value: "Utilisateur",
                      //           onChanged: (e) {
                      //             groupe = "Utilisateur";
                      //           },
                      //           groupValue: groupe,
                      //           title: const Text("Utilisateur"),
                      //         ),
                      //       ),
                      //       Expanded(
                      //         flex: 5,
                      //         child: RadioListTile(
                      //           value: "Business",
                      //           onChanged: (e) {
                      //             groupe = "Business";
                      //           },
                      //           groupValue: groupe,
                      //           title: const Text("Business"),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Get.dialog(
                              const Center(
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                            loginController.connexion(
                                "+243${telephone.text}", mdp.text);
                            //Get.off(Accueil()); //
                            //Get.to(Inscription()); //
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.green.shade700,
                          ),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: Get.size.width / 1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.login),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Connexion",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     //
                      //   },
                      //   child: Text("Mot de passe oublié"),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Text("""Si vous n'avez pas encore de compte"""),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(Inscription()); //
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.green.shade700,
                          ),
                          elevation: MaterialStateProperty.all(0),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: Get.size.width / 1.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.person_add),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Créer un compte",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
