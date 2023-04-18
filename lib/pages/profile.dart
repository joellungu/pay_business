import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
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
            title: const Text("Pay"),
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Card(
                elevation: 1,
                color: Colors.indigo.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: Get.size.height / 4.5,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: BarcodeWidget(
                            barcode: Barcode.qrCode(
                              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                            ),
                            data: '1234567\n7',
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text.rich(
                                  TextSpan(text: "", children: [
                                    TextSpan(
                                      text: "Vodacom\n",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.indigo.shade900,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: "+243 815 381 693",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  //
                  //Get.to(UpdateProfile());
                  //DemandeTransfere
                },
                leading: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    CupertinoIcons.person,
                    size: 30,
                    color: Colors.grey.shade700,
                  ),
                ),
                title: Text("Profile"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
              ListTile(
                onTap: () {
                  //
                  //Get.to(Faq());
                  //
                },
                leading: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    Icons.question_mark,
                    size: 30,
                    color: Colors.grey.shade700,
                  ),
                ),
                title: Text("F.A.Q"),
                subtitle: Text("Questions courante..."),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
              ListTile(
                onTap: () {
                  //Get.to(ConditionUtilisateur());
                },
                leading: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    Icons.list,
                    size: 30,
                    color: Colors.grey.shade700,
                  ),
                ),
                title: Text("Condition d'utilisation"),
                subtitle: Text("Régles et obligations"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
              ListTile(
                onTap: () {
                  //Get.to(Propos());
                },
                leading: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade900.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    Icons.abc,
                    size: 30,
                    color: Colors.grey.shade700,
                  ),
                ),
                title: Text("À propos"),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
              // ListTile(
              //   leading: Container(
              //     height: 50,
              //     width: 50,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       color: Colors.indigo.shade900.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(25),
              //     ),
              //     child: Icon(
              //       Icons.contact_page_outlined,
              //       size: 30,
              //       color: Colors.grey.shade700,
              //     ),
              //   ),
              //   title: Text("Contacter nous"),
              //   trailing: Icon(
              //     Icons.arrow_forward_ios,
              //   ),
              // ),//,
            ],
          ),
        ),
      ),
    );
  }
}
