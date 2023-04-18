import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay_business/pages/profile.dart';

import 'entreprise.dart';

class Accueil extends StatelessWidget {
  //
  Rx<Widget> vue = Rx(Entreprise());
  RxBool couleur = true.obs;
  RxInt choix = 0.obs;
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => vue.value),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (c) {
            //
            print(c);
            if (c == 0) {
              couleur.value = true;
              choix.value = 0;
              vue.value = Entreprise();
            } else {
              couleur.value = false;
              choix.value = 1;
              vue.value = Profile();
            }
          },
          currentIndex: choix.value,
          selectedItemColor:
              couleur.value ? Colors.indigo.shade900 : Colors.indigo.shade900,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Compte",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
