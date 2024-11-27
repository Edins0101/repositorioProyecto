// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yesnoapp/models/Carrito.dart';
import 'package:yesnoapp/models/Producto.dart';
import 'package:http/http.dart' as http;

class ProductoScreen extends StatefulWidget {
  const ProductoScreen({super.key});

  @override
  _ProductoScreenState createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  List<Producto> productosSeleccionados = [];

  Future<List<Producto>> fetchProductos(BuildContext context) async {
    final int idCategoria = ModalRoute.of(context)!.settings.arguments as int;
    final response = await http.get(Uri.parse(
        'https://gestion.promo.ec/promo/productos/ws/categoria-listar-productos/?VHozaS85TU9uUnhTR2FpMWh0eUJCZz09=gAAAAABgAGpunQZzKslbNqIL71S6nhjanaqWYmni6w7Bv_i0nc49t4WyDc3X6fPWVYzx2Lg_3b8PabFJ5RUF2rS43OGWXQ-Yuw==&id_sucursal=20&id_categoria=$idCategoria&id_subcategoria=0&offset=0&limit=10'));
    if (response.statusCode == 200) {
      final productosData = Productos.fromJson(json.decode(response.body));
      return productosData.productos;
    } else {
      throw Exception('Failed to load productos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Carrito>(builder: (context, carrito, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Productos'),
        ),
        body: FutureBuilder<List<Producto>>(
          future: fetchProductos(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No se encontraron productos.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                          'https://gestion.promo.ec/${snapshot.data![index].imagenes[0]}'),
                      title: Text(
                        snapshot.data![index].nombre,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              // Si el producto no está seleccionado, agrégalo al array
                              carrito.agregarProducto(
                                  snapshot.data![index].idProducto,
                                  snapshot.data![index].tipo,
                                  snapshot.data![index].codPrincipal,
                                  snapshot.data![index].nombre,
                                  snapshot.data![index].descripcion,
                                  snapshot.data![index].precio,
                                  snapshot.data![index].stock,
                                  snapshot.data![index].imagenes
                                  );
                            });
                          },
                          icon: const Icon(Icons.add)),
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    });
  }
}
