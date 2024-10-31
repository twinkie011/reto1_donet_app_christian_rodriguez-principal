import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Define la función aquí o impórtala desde otra clase
  Future<void> addDataToFirestore() async {
    CollectionReference donuts = FirebaseFirestore.instance.collection('productos');

    final List<List<dynamic>> donutData = [
      ["Ice Cream", "36", Colors.blue.value, "lib/images/chocolate_donut.png"],
      ["Strawberry", "45", Colors.brown.value, "lib/images/grape_donut.png"],
      ["Grape Ape", "84", Colors.red.value, "lib/images/icecream_donut.png"],
      ["Choco", "95", Colors.pink.value, "lib/images/strawberry_donut.png"],
      ["Vanilla", "40", Colors.grey.value, "lib/images/vanilla_donut.png"],
      ["Caramel", "50", Colors.orange.value, "lib/images/caramel_donut.png"],
      ["Blueberry", "55", Colors.purple.value, "lib/images/blueberry_donut.png"],
      ["Mint Chocolate", "60", Colors.green.value, "lib/images/mint_chocolate_donut.png"],
    ];

    for (var item in donutData) {
      await donuts.add({
        'nombre': item[0],
        'precio': item[1],
        'color': item[2],
        'img': item[3],
      });
    }

    print("Datos agregados a Firestore");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Donas a Firestore"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            addDataToFirestore();
          },
          child: Text("Agregar Donas"),
        ),
      ),
    );
  }
}
