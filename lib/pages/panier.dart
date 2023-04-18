import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_business/utils/panier_controller.dart';

class Panier extends GetView<PanierController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: controller.obx((state) => Container()),
    );
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