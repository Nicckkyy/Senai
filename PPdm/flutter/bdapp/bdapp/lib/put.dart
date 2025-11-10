import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PutPage extends StatefulWidget {
  const PutPage({super.key});

  @override
  State<PutPage> createState() => _PutPageState();
}

class _PutPageState extends State<PutPage> {
  //Lógica dessa bagaça
  Map<String, TextEditingController> controladores = {};
  List<dynamic>? values;
  @override
  void initState() {
    super.initState();
    getValues();
  }

  void getValues() {
    FirebaseFirestore.instance.collection("monitoramento").snapshots().listen((
      snapshots,
    ) {
      final data = snapshots.docs;

      setState(() {
        values = data;
        for (dynamic doc in data) {
          controladores[doc.id] = TextEditingController();
        }
      });
    });
  }

  Future<void> putValue(String id) async {
    FirebaseFirestore.instance.collection("monitoramento").doc(id).set({
      "temperatura": controladores[id]!.text,
    });
  }

  @override
  void dispose() {
    for (dynamic value in controladores.values) {
      value.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Página PUT")),
        body: values == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: values!.length,
                itemBuilder: (context, index) {
                  final item = values![index];
                  return ListTile(
                    title: Text("Temperatura atual ${item["temperatura"]}"),
                    subtitle: Column(
                      children: [
                        TextField(controller: controladores[item.id]),
                        ElevatedButton(
                          onPressed: () {
                            putValue(item.id);
                          },
                          child: Text("Enviar"),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
