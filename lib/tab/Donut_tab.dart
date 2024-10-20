import 'package:flutter/material.dart';

import '../utils/donut_tile.dart';

class DonutTab extends StatelessWidget {
  // Lista de donuts
  final List donutsOnsale = [
    ["Ice Cream", "36", Colors.blue, "lib/images/chocolate_donut.png"],
    ["Strawberry", "45", Colors.brown, "lib/images/grape_donut.png"],
    ["Grape Ape", "84", Colors.red, "lib/images/icecream_donut.png"],
    ["Choco", "95", Colors.pink, "lib/images/strawberry_donut.png"],
    ["Vanilla", "40", Colors.grey, "lib/images/vanilla_donut.png"],
    ["Caramel", "50", Colors.orange, "lib/images/caramel_donut.png"],
    ["Blueberry", "55", Colors.purple, "lib/images/blueberry_donut.png"],
    ["Mint Chocolate", "60", Colors.green, "lib/images/mint_chocolate_donut.png"],
  ];

  final Function(double) addItem; // Función para agregar un item

  // Constructor que recibe la función para agregar un item
  DonutTab({super.key, required this.addItem});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: donutsOnsale.length, // longitud del arreglo
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: donutsOnsale[index][0],
          donutPrice: donutsOnsale[index][1],
          donutColor: donutsOnsale[index][2],
          imageName: donutsOnsale[index][3],
          // Agregar botón "Add"
          addToCart: () {
            addItem(double.parse(donutsOnsale[index][1])); // Llama a la función addItem con el precio
          },
        );
      },
    );
  }
}
