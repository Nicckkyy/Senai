import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
// lógica da pagina
  TextEditingController novaTemperatura = TextEditingController();
   @override
  void initState() { //reinicia o estado sempre que atualizamos o valor de um campo
    //reinicia sempre que entrar na página
    super.initState();
    postValue();
  }
  
  String? erro;
  Future<void> postValue() async {
    try {
      FirebaseFirestore.instance.collection("monitoramento").add(
        {
          "temperatura": novaTemperatura.text
        }
      );
    } catch (e) {
      setState(() {
        erro = "Erro ao enviar dados. Falha na alteração de valores";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Sua tela Post!!")),
        body: Center(
          child: Column(
            children: [
              Text("Insira aqui a temperatura desejada"),
              TextField(controller: novaTemperatura),
              ElevatedButton(onPressed: postValue, child: Text("Enviar dados"))
            ],
          ),
        )
      ),
    );
  }
}