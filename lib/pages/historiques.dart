import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Historique extends StatelessWidget {
  RxString date = "".obs;
  TextEditingController text = TextEditingController();
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
            title: const Text("Historiques"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Obx(
                        () => TextField(
                          controller: text,
                          decoration: InputDecoration(
                            hintText: "Cherche ",
                            prefixIcon: date.value.isEmpty
                                ? Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //
                        //type.value = "${d!.month}-${d.year}";
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2030),
                        ).then((d) {
                          //
                          date.value = "${d!.day}-${d.month}-${d.year}";
                          text.text = date.value;
                          //controller.getAllFactures("${d.day}-${d.month}-${d.year}");
                        });
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    //padding: EdgeInsets.symmetric(horizontal: 10),
                    children: List.generate(9, (index) {
                      return ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade900.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${index + 8} H",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        title: Text(
                          "Total 50000 CDF",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text("Nombre de commandes: 18"),
                        // trailing: Icon(
                        //   Icons.arrow_forward_ios,
                        // ),
                      );
                    }),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
