// ignore_for_file: library_private_types_in_public_api, unused_local_variable, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Carrito.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});
  @override
  _CarritoScreenState createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Carrito'),
          centerTitle: true,
        ),
        body: Container(
          child: carrito.productos.length == 0
              ? const Center(
                  child: Text('Carrito vacio'),
                )
              : Column(
                  children: <Widget>[
                    for (var producto in carrito.productos.values)
                      Card(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(producto.nombre,
                                    textAlign: TextAlign.center),
                                Text(producto.precio,
                                    textAlign: TextAlign.center),
                                Text(producto.descripcion,
                                    textAlign: TextAlign.center),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      onPressed: () {
                                        setState(() {
                                          carrito.removerCarrito();
                                        });
                                      },
                                    ),
                                    Center(
                                      child: Text(producto.stock.toString()),
                                    ),
                                    IconButton(
                                      icon:
                                          const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        setState(() {
                                          carrito.incremetarProducto(
                                              producto.stock);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            validatorSessions();
                            carrito.productos.clear();
                            carrito.removerCarrito();
                          },
                          child: const Text('Comprar'),
                        ),
                      ],
                    )
                  ],
                ),
        ),
      );
    });
  }

  void mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alerta'),
        content: const Text('Su compra ha sido realizada'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, 'principal'),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void validatorSessions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      Navigator.pushNamed(context, 'login');
    } else {
      mostrarAlerta(context);
    }
  }
}
