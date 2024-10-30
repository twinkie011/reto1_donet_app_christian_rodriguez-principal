import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/burger_tile.dart';

class BurgerTab extends StatefulWidget {
  final Function(double) addItem; // Función para agregar un item

  const BurgerTab({super.key, required this.addItem});

  @override
  _BurgerTabState createState() => _BurgerTabState();
}

class _BurgerTabState extends State<BurgerTab> {
  final CollectionReference hamburguesasRef = FirebaseFirestore.instance
      .collection('hamburguesas'); // Referencia a la colección en Firestore
  List<dynamic> burgersOnSale =
      []; // Lista vacía que se llenará con los datos de Firestore

  @override
  void initState() {
    super.initState();
    getBurgersData(); // Llamamos la función para obtener los datos al iniciar
  }

  void getBurgersData() async {
    try {
      // Obtener los datos de la colección 'hamburguesas'
      hamburguesasRef.snapshots().listen((snapshot) {
        setState(() {
          // Convertir los documentos en una lista
          burgersOnSale = snapshot.docs.map((doc) => doc.data()).toList();
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
      itemCount: burgersOnSale.length, // longitud del arreglo dinámico
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var burger = burgersOnSale[index];

        // Imprimir valores para debugging
        // print('Nombre: ${burger['nombre']}, Precio: ${burger['precio']}, Color: ${burger['color']}');

        return BurgerTile(
          burgerName: burger['nombre'] is String
              ? burger['nombre']
              : burger['nombre'].toString(), // Asegúrate de que sea un String
          burgerPrice: burger['precio'] is String
              ? burger['precio']
              : burger['precio'].toString(), // Asegúrate de que sea un String
          burgerColor:
              Color(burger['color']), // Convertir el entero en un Color
          imageName: burger['img'],
          addToCart: () {
            widget.addItem(double.parse(burger['precio']
                .toString())); // Llama a la función addItem con el precio
          },
        );
      },
    );
  }
}
