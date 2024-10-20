import 'package:flutter/material.dart';
import '../utils/smoothie_tile.dart';  // Asegúrate de que el archivo existe y está en la ruta correcta.

class SmoothieTab extends StatelessWidget {
  final List smoothiesOnSale = [
    ["Mango Magic", "36", Colors.orange, "lib/images/mango_smoothie.png"],
    ["Berry Blast", "45", Colors.purple, "lib/images/berry_smoothie.png"],
    ["Green Detox", "50", Colors.green, "lib/images/green_smoothie.png"],
    ["Tropical Sunrise", "60", Colors.yellow, "lib/images/strawberry_smoothie.png"],
    ["Peach Paradise", "55", Colors.pink, "lib/images/peach_smoothie.png"],
    ["Chocolate Dream", "65", Colors.brown, "lib/images/chocolate_smoothie.png"],
    ["Pineapple Punch", "48", Colors.yellowAccent, "lib/images/pineapple_smoothie.png"],
    ["Blueberry Bliss", "53", Colors.blue, "lib/images/blueberry_smoothie.png"],
  ];

  final Function(double) addItem; // Función para agregar un item al carrito

  SmoothieTab({super.key, required this.addItem}); // Recibe la función en el constructor

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: smoothiesOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        return SmoothieTile(
          smoothieFlavor: smoothiesOnSale[index][0],
          smoothiePrice: smoothiesOnSale[index][1],
          smoothieColor: smoothiesOnSale[index][2],
          imageName: smoothiesOnSale[index][3],
          addToCart: () {
            addItem(double.parse(smoothiesOnSale[index][1])); // Llama a la función addItem con el precio
          },
        );
      },
    );
  }
}
