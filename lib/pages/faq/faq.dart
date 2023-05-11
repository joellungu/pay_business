import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_business/utils/requete.dart';

class Faq extends StatelessWidget {
  //
  Requete requete = Requete();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
      ),
      body: FutureBuilder(
        future: getFaqs(),
        builder: (c, t) {
          if (t.hasData) {
            List l = t.data as List;
            return Column(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(""), //${l.length} au total
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: List.generate(l.length, (index) {
                      Map e = l[index];
                      return ListTile(
                        leading: const Icon(Icons.question_mark),
                        title: Text("${e['question']}"),
                        subtitle: Text(
                          "${e['reponse']}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
    );
  }

  //
  Future<List> getFaqs() async {
    Response rep = await requete.getE("faq/all");
    if (rep.isOk) {
      return rep.body;
    } else {
      return [];
    }
  }
}
