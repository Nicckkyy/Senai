import 'package:bdapp/post.dart';
import 'package:bdapp/put.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // inicia os componentes
  await Firebase.initializeApp( // espera até que o firebase seja iniciado
  options: DefaultFirebaseOptions.currentPlatform // define automaticamente a plataforma atual do firebase
  ); 

  runApp(const MyApp());
}

// ---------- My App ---------- //
class MyApp  extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TelaGet(),

    );
  }
}

// ---------- Tela Get ---------- //
class TelaGet extends StatefulWidget {
  const TelaGet({super.key});

  @override
  State<TelaGet> createState() => _TelaGetState();
}

class _TelaGetState extends State<TelaGet> {
  // lógica da tela
  String? temperatura;

  @override
  void initState(){ //reinicia sempre que entrar na página
  super.initState();
  getValue();
  }

  void getValue(){
    FirebaseFirestore.instance.collection("monitoramento").snapshots().listen(
      (snapshot){
        final data = snapshot.docs.first.data();
        setState(() {
          temperatura =  data ["temperatura"];
        });
      }
    );
  }

// componentes
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Tela de Get do Banco")),
        body: Center(
          child: Column(
            children: [
              Text("Essa é a tua temperatura do banco"),
              Text("$temperatura"),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage()));
              }, child: Text("Ir para a página POST!")),

              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => PutPage()));
              }, child: Text("Ir para PUT!"))
            ],
          ),
        ),
        ),
      );
  }
}