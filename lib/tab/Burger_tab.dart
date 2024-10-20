import 'package:flutter/material.dart';

import '../utils/burger_tile.dart';

class BurgerTab extends StatelessWidget {
  final List burgersOnSale = [
    ["Classic Burger", "50", Colors.brown, "lib/images/classic_burger.png"],
    ["Cheese Burger", "60", Colors.yellow, "lib/images/cheese_burger.png"],
    ["Bacon Burger", "70", Colors.red, "lib/images/bacon_burger.png"],
    ["Vegan Burger", "65", Colors.green, "lib/images/vegan_burger.png"],
    ["BBQ Burger", "75", Colors.deepOrange, "lib/images/bbq_burger.png"],
    ["Double Cheese Burger", "85", Colors.amber, "lib/images/double_cheese_burger.png"],
    ["Spicy Chicken Burger", "80", Colors.orange, "lib/images/spicy_chicken_burger.png"],
    ["Mushroom Burger", "68", Colors.grey, "lib/images/mushroom_burger.png"],
  ];

  final Function(double) addItem; // Función para agregar un item

  BurgerTab({super.key, required this.addItem}); // Recibe la función en el constructor

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: burgersOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return BurgerTile(
          burgerName: burgersOnSale[index][0],
          burgerPrice: burgersOnSale[index][1],
          burgerColor: burgersOnSale[index][2],
          imageName: burgersOnSale[index][3],
          addToCart: () {
            addItem(double.parse(burgersOnSale[index][1])); // Llama a la función addItem con el precio
          },
        );
      },
    );
  }
}
