import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'commandes.dart';
import 'historiques.dart';
import 'produits.dart';
import 'reservations.dart';

class Entreprise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //, ,
      color: Colors.indigo.shade900, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.indigo.shade900,
              actions: [
                IconButton(
                    onPressed: () {
                      //
                      Get.to(Historique());
                      //
                    },
                    icon: const Icon(Icons.pie_chart))
              ],
              bottom: const TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: "Produits & Services"),
                  Tab(text: "Commandes  2"),
                  Tab(text: "Reservations 10"),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Produits(),
                Commandes(),
                Reservations(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
