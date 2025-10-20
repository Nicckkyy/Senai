import 'package:flutter/material.dart';
import 'package:navbottombar/Tela1.dart';
import 'package:navbottombar/Tela2.dart';
import 'package:navbottombar/Tela3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int myindex = 0; // indica o index da tela desejada

  void changeindex(int newindex){
    setState(() { // nescessário para trocar o valor de uma variavel
      myindex = newindex; 
    });
  } 

  List <Widget> screens = [
    Tela1(),
    Tela2(),
    Tela3()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screens.elementAt(myindex),
        bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(label: "Tela 1", icon: Icon(Icons.account_circle)),
          BottomNavigationBarItem(label: "Tela 2", icon: Icon(Icons.account_circle_outlined)),
          BottomNavigationBarItem(label: "Tela 3", icon: Icon(Icons.account_circle_sharp)),
        ],
        
        currentIndex: myindex, // indica o index atual = my Index
        onTap: changeindex, // troca o valor do index = chama a função para troca

        ),
      ),
    );
  }
}