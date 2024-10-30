import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/pancakes_tile.dart';

class PancakeTab extends StatefulWidget {
  final Function(double) addItem; // Función para agregar un item

  const PancakeTab(
      {super.key,
      required this.addItem}); // Recibe la función en el constructor

  @override
  _PancakeTabState createState() => _PancakeTabState();
}

class _PancakeTabState extends State<PancakeTab> {
  final CollectionReference pancakesRef = FirebaseFirestore.instance
      .collection('pancakes'); // Referencia a la colección en Firestore
  List<dynamic> pancakeOnSale =
      []; // Lista vacía que se llenará con los datos de Firestore

  @override
  void initState() {
    super.initState();
    getPancakesData(); // Llamamos la función para obtener los datos al iniciar
  }

  void getPancakesData() async {
    try {
      // Obtener los datos de la colección 'pancakes'
      pancakesRef.snapshots().listen((snapshot) {
        setState(() {
          // Convertir los documentos en una lista
          pancakeOnSale = snapshot.docs.map((doc) => doc.data()).toList();
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
      itemCount: pancakeOnSale.length, // longitud del arreglo dinámico
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var pancake = pancakeOnSale[index];

        // Imprimir valores para debugging
        print(
            'Nombre: ${pancake['nombre']}, Precio: ${pancake['precio']}, Color: ${pancake['color']}');

        return PancakeTile(
          pancakeName: pancake['nombre'] is String
              ? pancake['nombre']
              : pancake['nombre'].toString(), // Asegúrate de que sea un String
          pancakePrice: pancake['precio'] is String
              ? pancake['precio']
              : pancake['precio'].toString(), // Asegúrate de que sea un String
          pancakeColor:
              Color(pancake['color']), // Convertir el entero en un Color
          imageName: pancake['img'], // Cambié 'image' a 'img'
          addToCart: () {
            widget.addItem(double.parse(pancake['precio']
                .toString())); // Llama a la función addItem con el precio
          },
        );
      },
    );
  }
}
