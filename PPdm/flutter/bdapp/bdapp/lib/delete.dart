import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
// lógica da page
  List<dynamic>?valores;
  @override
  void initState() {
    super.initState(); //função que matem as informações do banco atualizadas sempre.
    getValues();
  }

void getValues(){
  // instancia na coleção do banco onde os retornos são listados
  FirebaseFirestore.instance.collection("monitoramento").snapshots().listen(
    (snapshots){
      //cria uma variavel que receberá apenas os documentos de um retorno
      final data = snapshots.docs; //'tratativa de erro', caso tenha falhas durante o processo a função reinicia,
      //caso contrario ela recebe o valor de data
      setState(() {
        valores = data;
      });
    }
  );
}

Future<void> deleteValue (String id) async {
   await FirebaseFirestore.instance.collection("monitoramento").doc(id).delete();
}

  @override
// interface bunitinha 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Tela de delete")),
        body: valores == null ? Center(child: CircularProgressIndicator()) : 
        ListView.builder(
          itemCount: valores!.length, //quatidade de itens depende do tamanho da lista
          itemBuilder: (context, index) {
            final item = valores![index]; //variavel que referencia cada item da lista.
            return ListTile(
              title: Text("Temperatura do banco:"),
              subtitle: Text("${item["temperatura"]}"),
              trailing: GestureDetector( //permite que o icone possua ações ao clicar
                child: Icon(Icons.remove),
                onTap: (){deleteValue(item.id);}, //clicando faz alguma coisa
                
              ),
            );
          },
        )
      )
    );
  }
}