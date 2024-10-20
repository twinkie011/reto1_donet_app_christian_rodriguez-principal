import 'package:flutter/material.dart';
import 'package:reto1_donet_app_christian_rodriguez/utils/pancakes_tile.dart';


class PancakeTab extends StatelessWidget {
  final List pancakeOnSale = [
    ["Classic Pancake", "36", Colors.brown, "lib/images/classic_pancake.png"],
    ["Blueberry Pancake", "45", Colors.blue, "lib/images/blueberry_pancake.png"],
    ["Chocolate Pancake", "50", Colors.brown, "lib/images/chocolate_pancake.png"],
    ["Banana Pancake", "55", Colors.yellow, "lib/images/banana_pancake.png"],
    ["Strawberry Pancake", "48", Colors.red, "lib/images/strawberry_pancake.png"],
    ["Nutella Pancake", "60", Colors.green, "lib/images/nutella_pancake.png"],
    ["Coconut Pancake", "52", Colors.brown, "lib/images/coconut_pancake.png"],
    ["Caramel Pancake", "58", Colors.orange, "lib/images/caramel_pancake.png"],
  ];

  final Function(double) addItem; // Función para agregar un item

  PancakeTab({super.key, required this.addItem}); // Recibir la función en el constructor

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pancakeOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return PancakeTile(
          pancakeName: pancakeOnSale[index][0],
          pancakePrice: pancakeOnSale[index][1],
          pancakeColor: pancakeOnSale[index][2],
          imageName: pancakeOnSale[index][3],
          addToCart: () {
            addItem(double.parse(pancakeOnSale[index][1])); // Llama a la función addItem con el precio
          },
        );
      },
    );
  }
}
