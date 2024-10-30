import 'package:flutter/material.dart';

class PancakeTile extends StatelessWidget {
  final String pancakeName;
  final String pancakePrice;
  final Color pancakeColor;
  final String imageName;
  final double borderRadius = 24;
  final VoidCallback addToCart; // Callback para agregar al carrito

  const PancakeTile({
    super.key,
    required this.pancakeName,
    required this.pancakePrice,
    required this.pancakeColor,
    required this.imageName,
    required this.addToCart, // Aceptar el callback en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: pancakeColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // Pancake price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: pancakeColor.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Text(
                    '\$$pancakePrice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color:  Colors.white,
                    ),
                  ),
                )
              ],
            ),
            // Pancake picture
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: Image.asset(imageName, fit: BoxFit.contain),
              ),
            ),
            // Pancake name text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
              child: Text(
                pancakeName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text('Pancake House'),
            // Love icon + add button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Heart icon
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    color: Colors.pink[400],
                    onPressed: () {
                      // Lógica para marcar como favorito
                    },
                  ),
                  // Botón "Add" como texto negro sin fondo
                  TextButton(
                    onPressed: addToCart, // Llama al callback al presionar el botón
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      backgroundColor: Colors.transparent, // Sin fondo
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.black, // Color del texto
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
