import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/pizza_tile.dart';

class PizzaTab extends StatefulWidget {
  final Function(double) addItem; // Función para agregar un item

  const PizzaTab({super.key, required this.addItem}); // Recibe la función en el constructor

  @override
  _PizzaTabState createState() => _PizzaTabState();
}

class _PizzaTabState extends State<PizzaTab> {
  final CollectionReference pizzasRef = FirebaseFirestore.instance
      .collection('pizzas'); // Referencia a la colección en Firestore
  List<dynamic> pizzasOnSale = []; // Lista vacía que se llenará con los datos de Firestore

  @override
  void initState() {
    super.initState();
    getPizzasData(); // Llamamos la función para obtener los datos al iniciar
  }

  void getPizzasData() async {
    try {
      // Obtener los datos de la colección 'pizzas'
      pizzasRef.snapshots().listen((snapshot) {
        setState(() {
          // Convertir los documentos en una lista
          pizzasOnSale = snapshot.docs.map((doc) => doc.data()).toList();
        });
      });
    } catch (e) {
      // Manejar errores
      print('Error al obtener datos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pizzasOnSale.length, // longitud del arreglo dinámico
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var pizza = pizzasOnSale[index];

        // Imprimir valores para debugging
        print(
            'Nombre: ${pizza['nombre']}, Precio: ${pizza['precio']}, Color: ${pizza['color']}');

        return PizzaTile(
          pizzaFlavor: pizza['nombre'] is String
              ? pizza['nombre']
              : pizza['nombre'].toString(), // Asegúrate de que sea un String
          pizzaPrice: pizza['precio'] is String
              ? pizza['precio']
              : pizza['precio'].toString(), // Asegúrate de que sea un String
          pizzaColor: Color(pizza['color']), // Convertir el entero en un Color
          imageName: pizza['img'], // Cambié 'image' a 'img'
          addToCart: () {
            widget.addItem(double.parse(pizza['precio']
                .toString())); // Llama a la función addItem con el precio
          },
        );
      },
    );
  }
}
