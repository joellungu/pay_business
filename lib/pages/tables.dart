import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Tables extends StatelessWidget {
  //
  final box = GetStorage();
  //
  RxList liste = [].obs;
  String idBoutique = "";
  //
  Tables() {
    //
    Map e = box.read("boutique") ?? {};
    idBoutique = "${e['id']}" ?? "";
    //
    liste.value = box.read("tables") ?? [];
    print(liste);
  }
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: const Text("Tables"),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: List.generate(
            liste.length,
            (index) => ListTile(
              onTap: () {
                //
                showDialog(
                    context: context,
                    builder: (c) {
                      return Material(
                        color: Colors.transparent,
                        child: Container(
                          height: Get.size.height / 1.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      //
                                      Get.back();
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: BarcodeWidget(
                                  barcode: Barcode.qrCode(
                                    errorCorrectLevel:
                                        BarcodeQRCorrectionLevel.high,
                                  ),
                                  data: '$idBoutique::${liste[index]['table']}',
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  //
                                },
                                child: Text("Imprimer"),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              leading: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(
                    errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                  ),
                  data: '$idBoutique::${liste[index]['table']}',
                  width: 200,
                  height: 200,
                ),
              ),
              title: Text(
                "Table N° ${liste[index]['table']}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  //
                  liste.removeAt(index);
                  box.write("tables", liste);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        child: ElevatedButton(
          child: const Text("Ajouter"),
          onPressed: () {
            //
            liste.value = box.read("tables") ?? [];
            //
            showDialog(
                context: context,
                builder: (c) {
                  //
                  TextEditingController text = TextEditingController();
                  //
                  return AlertDialog(
                    title: const Text("Table"),
                    content: Container(
                      alignment: Alignment.center,
                      height: 70,
                      child: TextField(
                        controller: text,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.table_bar),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          liste.add({"table": text.text});
                          box.write("tables", liste);
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.red.shade900,
                        ),
                      ),
                    ],
                  );
                });
            //
          },
        ),
      ),
    );
  }
}
