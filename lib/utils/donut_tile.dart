import 'package:flutter/material.dart';

class DonutTile extends StatelessWidget {
  final String donutFlavor;
  final String donutPrice;
  final Color donutColor; // Cambiado a Color
  final String imageName;

  final double borderRadius = 24;
  final VoidCallback addToCart; // Callback para agregar al carrito

  const DonutTile({
    super.key,
    required this.donutFlavor,
    required this.donutPrice,
    required this.donutColor, // Requerido ahora
    required this.imageName,
    required this.addToCart, // Recibe el callback en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: donutColor, // Usa directamente donutColor
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // Donut price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: donutColor
                        .withOpacity(0.9), // Cambia según sea necesario
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Text(
                    '\$$donutPrice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white, // Cambiar a un color que se vea bien
                    ),
                  ),
                ),
              ],
            ),
            // Donut picture
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: Image.asset(imageName, fit: BoxFit.contain),
              ),
            ),
            // Donut flavor text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
              child: Text(
                donutFlavor,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black, // Cambiar a un color que se vea bien
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text('Dunkin\'s'),

            // Heart icon + Add button
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
                      // Acción del ícono de favorito (opcional)
                    },
                  ),
                  // Botón "Add" como texto negro sin fondo
                  TextButton(
                    onPressed: addToCart,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
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