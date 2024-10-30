import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/smoothie_tile.dart'; // Asegúrate de que el archivo existe y está en la ruta correcta.

class SmoothieTab extends StatefulWidget {
  final Function(double) addItem; // Función para agregar un item al carrito

  const SmoothieTab({super.key, required this.addItem}); // Recibe la función en el constructor

  @override
  _SmoothieTabState createState() => _SmoothieTabState();
}

class _SmoothieTabState extends State<SmoothieTab> {
  final CollectionReference smoothiesRef = FirebaseFirestore.instance
      .collection('smoothies'); // Referencia a la colección en Firestore
  List<dynamic> smoothiesOnSale = []; // Lista vacía que se llenará con los datos de Firestore

  @override
  void initState() {
    super.initState();
    getSmoothiesData(); // Llamamos la función para obtener los datos al iniciar
  }

  void getSmoothiesData() async {
    try {
      // Obtener los datos de la colección 'smoothies'
      smoothiesRef.snapshots().listen((snapshot) {
        setState(() {
          // Convertir los documentos en una lista
          smoothiesOnSale = snapshot.docs.map((doc) => doc.data()).toList();
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
      itemCount: smoothiesOnSale.length, // longitud del arreglo dinámico
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var smoothie = smoothiesOnSale[index];

        // Imprimir valores para debugging
        print(
            'Nombre: ${smoothie['nombre']}, Precio: ${smoothie['precio']}, Color: ${smoothie['color']}');

        return SmoothieTile(
          smoothieFlavor: smoothie['nombre'] is String
              ? smoothie['nombre']
              : smoothie['nombre'].toString(), // Asegúrate de que sea un String
          smoothiePrice: smoothie['precio'] is String
              ? smoothie['precio']
              : smoothie['precio'].toString(), // Asegúrate de que sea un String
          smoothieColor: Color(smoothie['color']), // Convertir el entero en un Color
          imageName: smoothie['img'], // Cambié 'image' a 'img'
          addToCart: () {
            widget.addItem(double.parse(smoothie['precio']
                .toString())); // Llama a la función addItem con el precio
          },
        );
      },
    );
  }
}
