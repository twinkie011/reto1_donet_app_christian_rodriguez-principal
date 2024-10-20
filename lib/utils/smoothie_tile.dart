import 'package:flutter/material.dart';

class SmoothieTile extends StatelessWidget {
  final String smoothieFlavor; // Renombrado
  final String smoothiePrice;
  final dynamic smoothieColor;
  final String imageName;
  final double borderRadius = 24;
  final VoidCallback addToCart; // Callback para agregar al carrito

  const SmoothieTile({
    super.key,
    required this.smoothieFlavor,
    required this.smoothiePrice,
    this.smoothieColor,
    required this.imageName,
    required this.addToCart, // Aceptar el callback en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: smoothieColor[50],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // Smoothie price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: smoothieColor[100],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Text(
                    '\$$smoothiePrice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: smoothieColor[800],
                    ),
                  ),
                ),
              ],
            ),
            // Smoothie picture
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: Image.asset(imageName, fit: BoxFit.contain),
              ),
            ),
            // Smoothie flavor text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
              child: Text(
                smoothieFlavor,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: smoothieColor[1000],
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text('Smoothie Shop'),

            // Heart icon + Add button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border), // Cambiado a un ícono de favorito vacío
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