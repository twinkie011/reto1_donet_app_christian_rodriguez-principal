import 'package:flutter/material.dart';
import '../utils/pizza_tile.dart';

class PizzaTab extends StatelessWidget {
  final List pizzasOnSale = [
    ["Margherita", "80", Colors.red, "lib/images/margherita_pizza.png"],
    ["Pepperoni", "90", Colors.orange, "lib/images/pepperoni_pizza.png"],
    ["BBQ Chicken", "100", Colors.brown, "lib/images/bbq_pizza.png"],
    ["Veggie", "70", Colors.green, "lib/images/veggie_pizza.png"],
    ["Hawaiian", "85", Colors.yellow, "lib/images/hawaiian_pizza.png"],
    ["Buffalo Chicken", "95", Colors.deepOrange, "lib/images/buffalo_pizza.png"],
    ["Meat Lovers", "110", Colors.redAccent, "lib/images/meat_lovers_pizza.png"],
    ["Cheese Lovers", "75", Colors.amber, "lib/images/cheese_lovers_pizza.png"],
  ];

  final Function(double) addItem; // Función para agregar un item

  PizzaTab({super.key, required this.addItem}); // Recibir la función en el constructor

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pizzasOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return PizzaTile(
          pizzaFlavor: pizzasOnSale[index][0],
          pizzaPrice: pizzasOnSale[index][1],
          pizzaColor: pizzasOnSale[index][2],
          imageName: pizzasOnSale[index][3],
          addToCart: () {
            addItem(double.parse(pizzasOnSale[index][1])); // Llama a la función addItem con el precio
          }, pizzaName: '',
        );
      },
    );
  }
}
