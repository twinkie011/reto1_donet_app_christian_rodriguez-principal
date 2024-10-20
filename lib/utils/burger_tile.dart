import 'package:flutter/material.dart';

class BurgerTile extends StatelessWidget {
  final String burgerName;
  final String burgerPrice;
  final dynamic burgerColor;
  final String imageName;
  final double borderRadius = 24;
  final VoidCallback addToCart; // Callback para agregar al carrito

  const BurgerTile({
    super.key,
    required this.burgerName,
    required this.burgerPrice,
    this.burgerColor,
    required this.imageName,
    required this.addToCart, // Aceptar el callback en el constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: burgerColor[50],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: [
            // Burger price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: burgerColor[100],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Text(
                    '\$$burgerPrice',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: burgerColor[800],
                    ),
                  ),
                ),
              ],
            ),
            // Burger picture
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: Image.asset(imageName, fit: BoxFit.contain), // Ajuste para que la imagen se ajuste
              ),
            ),
            // Burger name text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
              child: Text(
                burgerName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: burgerColor[1000],
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text('Delicious Burgers'),

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
