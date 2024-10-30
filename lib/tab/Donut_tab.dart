import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/donut_tile.dart';

class DonutTab extends StatefulWidget {
  final Function(double) addItem; // Función para agregar un item

  const DonutTab({super.key, required this.addItem});

  @override
  _DonutTabState createState() => _DonutTabState();
}

class _DonutTabState extends State<DonutTab> {
  final CollectionReference productosRef = FirebaseFirestore.instance
      .collection('donas'); // Referencia a la colección en Firestore
  List<dynamic> donutsOnsale =
      []; // Lista vacía que se llenará con los datos de Firestore

  @override
  void initState() {
    super.initState();
    getDonutsData(); // Llamamos la función para obtener los datos al iniciar
  }

  void getDonutsData() async {
    try {
      // Obtener los datos de la colección 'donas'
      productosRef.snapshots().listen((snapshot) {
        setState(() {
          // Convertir los documentos en una lista
          donutsOnsale = snapshot.docs.map((doc) => doc.data()).toList();
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
      itemCount: donutsOnsale.length, // longitud del arreglo dinámico
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        var donut = donutsOnsale[index];

        // Imprimir valores para debugging
        // print(
        //     'Nombre: ${donut['nombre']}, Precio: ${donut['precio']}, Color: ${donut['color']}');

        return DonutTile(
          donutFlavor: donut['nombre'] is String
              ? donut['nombre']
              : donut['nombre'].toString(),
          donutPrice: donut['precio'] is String
              ? donut['precio']
              : donut['precio'].toString(),
          donutColor: Color(donut['color']), // Convertir el entero en un Color
          imageName: donut['img'],
          addToCart: () {
            widget.addItem(double.parse(donut['precio']
                .toString())); // Llama a la función addItem con el precio
          },
        );
      },
    );
  }
}
